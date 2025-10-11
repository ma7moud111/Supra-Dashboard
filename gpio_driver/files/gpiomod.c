 
/*
 * gpiomod.c
 * Custom modular GPIO driver with full pull-up/down control for BCM2837
 *
 * Uses gpiomod.h for shared definitions.
 *
 * Build: use Makefile (kernel module)
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/device.h>
#include <linux/fs.h>
#include <linux/uaccess.h>
#include <linux/io.h>
#include <linux/slab.h>
#include <linux/delay.h>
#include <linux/version.h>


#include "gpiomod.h"

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Abdo");
MODULE_DESCRIPTION("Custom modular GPIO driver with full pull-up/down control for BCM2837 (gpiomod)");

/* exported/visible globals referenced by header prototypes */
void __iomem *gpiom_base;
struct gpiom_pin gpiom_pins[GPIOMOD_GPIO_COUNT];
struct mutex gpiom_lock;

/* sysfs class and device pointers for cleanup */
static struct class *gpiom_class;
static struct device *gpiom_devs[GPIOMOD_GPIO_COUNT];

/* helper: compute index and shift for GPFSEL */
static inline void gpfsel_index_shift(unsigned int gpio, unsigned int *idx, unsigned int *shift)
{
    *idx = gpio / 10;
    *shift = (gpio % 10) * 3;
}

/* low-level HW helpers (non-exported) */
void gpiom_hw_set_direction(unsigned int gpio, int output)
{
    unsigned int idx, shift;
    u32 reg, mask;

    gpfsel_index_shift(gpio, &idx, &shift);
    reg = ioread32(gpiom_base + GPFSEL_OFFSET(idx));
    mask = 7u << shift;
    reg &= ~mask;
    if (output)
        reg |= (1u << shift); /* 001 -> output */
    iowrite32(reg, gpiom_base + GPFSEL_OFFSET(idx));
}
EXPORT_SYMBOL_GPL(gpiom_hw_set_direction);

void gpiom_hw_set_value(unsigned int gpio, int value)
{
    if (value)
        iowrite32(1u << gpio, gpiom_base + GPSET0_OFFSET);
    else
        iowrite32(1u << gpio, gpiom_base + GPCLR0_OFFSET);
}
EXPORT_SYMBOL_GPL(gpiom_hw_set_value);

int gpiom_hw_get_value(unsigned int gpio)
{
    u32 lev = ioread32(gpiom_base + GPLEV0_OFFSET);
    return (lev >> gpio) & 1u;
}
EXPORT_SYMBOL_GPL(gpiom_hw_get_value);

void gpiom_hw_set_pull(unsigned int gpio, enum gpiom_pull mode)
{
    /*
     * Broadcom sequence:
     *  1) Write control signal to GPPUD (0=disable,1=down,2=up)
     *  2) Wait 150 cycles (~usecs)
     *  3) Write 1 to GPPUDCLK0 bit corresponding to gpio
     *  4) Wait
     *  5) Clear GPPUD and GPPUDCLK0
     *
     * We protect sequence with gpiom_lock to avoid interleaving by other callers.
     */
    mutex_lock(&gpiom_lock);

    iowrite32((u32)mode, gpiom_base + GPPUD_OFFSET);
    udelay(GPPUD_WAIT_USEC);

    iowrite32(1u << gpio, gpiom_base + GPPUDCLK0_OFFSET);
    udelay(GPPUD_WAIT_USEC);

    /* clear both */
    iowrite32(0, gpiom_base + GPPUD_OFFSET);
    iowrite32(0, gpiom_base + GPPUDCLK0_OFFSET);

    mutex_unlock(&gpiom_lock);
}
EXPORT_SYMBOL_GPL(gpiom_hw_set_pull);

/* ---------- sysfs attribute handlers ---------- */

/* direction */
static ssize_t direction_show(struct device *dev, struct device_attribute *attr, char *buf)
{
    int gpio = (int)(long)dev_get_drvdata(dev);
    unsigned int idx, shift;
    u32 reg, funct;

    gpfsel_index_shift(gpio, &idx, &shift);
    reg = ioread32(gpiom_base + GPFSEL_OFFSET(idx));
    funct = (reg >> shift) & 7u;
    return scnprintf(buf, PAGE_SIZE, "%s\n", funct == 1u ? "out" : "in");
}

static ssize_t direction_store(struct device *dev, struct device_attribute *attr,
                               const char *buf, size_t count)
{
    int gpio = (int)(long)dev_get_drvdata(dev);

    if (count >= 3 && strncmp(buf, "out", 3) == 0)
        gpiom_hw_set_direction(gpio, 1);
    else if (count >= 2 && strncmp(buf, "in", 2) == 0)
        gpiom_hw_set_direction(gpio, 0);
    else
        return -EINVAL;

    return count;
}

/* value */
static ssize_t value_show(struct device *dev, struct device_attribute *attr, char *buf)
{
    int gpio = (int)(long)dev_get_drvdata(dev);
    int v = gpiom_hw_get_value(gpio);
    return scnprintf(buf, PAGE_SIZE, "%d\n", v);
}

static ssize_t value_store(struct device *dev, struct device_attribute *attr,
                           const char *buf, size_t count)
{
    int gpio = (int)(long)dev_get_drvdata(dev);

    if (count < 1) return -EINVAL;

    if (buf[0] == '1')
        gpiom_hw_set_value(gpio, 1);
    else if (buf[0] == '0')
        gpiom_hw_set_value(gpio, 0);
    else
        return -EINVAL;

    /* convenience: when writing value ensure pin is output */
    gpiom_hw_set_direction(gpio, 1);
    return count;
}

/* pull-up/pull-down: show/store */
static ssize_t pull_up_show(struct device *dev, struct device_attribute *attr, char *buf)
{
    int gpio = (int)(long)dev_get_drvdata(dev);
    int v;

    mutex_lock(&gpiom_lock);
    v = (gpiom_pins[gpio].pull == GPIOM_PULL_UP) ? 1 : 0;
    mutex_unlock(&gpiom_lock);

    return scnprintf(buf, PAGE_SIZE, "%d\n", v);
}

static ssize_t pull_up_store(struct device *dev, struct device_attribute *attr,
                             const char *buf, size_t count)
{
    int gpio = (int)(long)dev_get_drvdata(dev);

    if (count < 1) return -EINVAL;

    if (buf[0] == '1') {
        /* set pull-up and clear stored pull-down */
        gpiom_hw_set_pull(gpio, GPIOM_PULL_UP);
        mutex_lock(&gpiom_lock);
        gpiom_pins[gpio].pull = GPIOM_PULL_UP;
        mutex_unlock(&gpiom_lock);
    } else if (buf[0] == '0') {
        gpiom_hw_set_pull(gpio, GPIOM_PULL_DISABLE);
        mutex_lock(&gpiom_lock);
        gpiom_pins[gpio].pull = GPIOM_PULL_DISABLE;
        mutex_unlock(&gpiom_lock);
    } else {
        return -EINVAL;
    }
    return count;
}

static ssize_t pull_down_show(struct device *dev, struct device_attribute *attr, char *buf)
{
    int gpio = (int)(long)dev_get_drvdata(dev);
    int v;

    mutex_lock(&gpiom_lock);
    v = (gpiom_pins[gpio].pull == GPIOM_PULL_DOWN) ? 1 : 0;
    mutex_unlock(&gpiom_lock);

    return scnprintf(buf, PAGE_SIZE, "%d\n", v);
}

static ssize_t pull_down_store(struct device *dev, struct device_attribute *attr,
                               const char *buf, size_t count)
{
    int gpio = (int)(long)dev_get_drvdata(dev);

    if (count < 1) return -EINVAL;

    if (buf[0] == '1') {
        gpiom_hw_set_pull(gpio, GPIOM_PULL_DOWN);
        mutex_lock(&gpiom_lock);
        gpiom_pins[gpio].pull = GPIOM_PULL_DOWN;
        mutex_unlock(&gpiom_lock);
    } else if (buf[0] == '0') {
        gpiom_hw_set_pull(gpio, GPIOM_PULL_DISABLE);
        mutex_lock(&gpiom_lock);
        gpiom_pins[gpio].pull = GPIOM_PULL_DISABLE;
        mutex_unlock(&gpiom_lock);
    } else {
        return -EINVAL;
    }
    return count;
}

/* attributes declarations */
static DEVICE_ATTR_RW(direction);
static DEVICE_ATTR_RW(value);
static DEVICE_ATTR_RW(pull_up);
static DEVICE_ATTR_RW(pull_down);

/* create/destroy */
int gpiom_create_devices(void)
{
    int i;
    int ret = 0;

    for (i = 0; i < GPIOMOD_GPIO_COUNT; ++i) {
        struct device *dev;
        dev = device_create(gpiom_class, NULL, MKDEV(0, i), NULL, "gpio%d", i);
        if (IS_ERR(dev)) {
            pr_err("gpiomod: device_create failed for gpio%d\n", i);
            ret = PTR_ERR(dev);
            goto cleanup;
        }

        gpiom_devs[i] = dev;
        dev_set_drvdata(dev, (void *)(long)i);

        if (device_create_file(dev, &dev_attr_direction) ||
            device_create_file(dev, &dev_attr_value) ||
            device_create_file(dev, &dev_attr_pull_up) ||
            device_create_file(dev, &dev_attr_pull_down)) {
            pr_err("gpiomod: device_create_file failed for gpio%d\n", i);
            device_unregister(dev);
            gpiom_devs[i] = NULL;
            ret = -EIO;
            goto cleanup;
        }

        /* initialize per-pin state */
        mutex_lock(&gpiom_lock);
        gpiom_pins[i].number = i;
        gpiom_pins[i].pull = GPIOM_PULL_DISABLE;
        mutex_unlock(&gpiom_lock);
    }

    return 0;

cleanup:
    /* cleanup partially created devices */
    while (--i >= 0) {
        if (gpiom_devs[i]) {
            device_destroy(gpiom_class, MKDEV(0, i));
            gpiom_devs[i] = NULL;
        }
    }
    return ret;
}

void gpiom_destroy_devices(void)
{
    int i;
    for (i = 0; i < GPIOMOD_GPIO_COUNT; ++i) {
        if (gpiom_devs[i]) {
            device_destroy(gpiom_class, MKDEV(0, i));
            gpiom_devs[i] = NULL;
        }
    }
}

/* module init / exit */
static int __init gpiom_init(void)
{
    int ret;

    mutex_init(&gpiom_lock);

    /* map GPIO registers */
    gpiom_base = ioremap(GPIO_BASE_PHYS, GPIO_MEM_SIZE);
    if (!gpiom_base) {
        pr_err("gpiomod: ioremap failed\n");
        return -ENOMEM;
    }

    /* create class */
    #if LINUX_VERSION_CODE >= KERNEL_VERSION(6, 4, 0)
    gpiom_class = class_create(GPIOMOD_NAME);
#else
    gpiom_class = class_create(THIS_MODULE, GPIOMOD_NAME);
#endif
    if (IS_ERR(gpiom_class)) {
        pr_err("gpiomod: class_create failed\n");
        iounmap(gpiom_base);
        return PTR_ERR(gpiom_class);
    }

    /* create per-gpio devices and attributes */
    ret = gpiom_create_devices();
    if (ret) {
        class_destroy(gpiom_class);
        iounmap(gpiom_base);
        return ret;
    }

    pr_info("gpiomod: loaded, created %d gpio entries\n", GPIOMOD_GPIO_COUNT);
    return 0;
}

static void __exit gpiom_exit(void)
{
    gpiom_destroy_devices();
    class_destroy(gpiom_class);
    if (gpiom_base)
        iounmap(gpiom_base);
    pr_info("gpiomod: unloaded\n");
}

module_init(gpiom_init);
module_exit(gpiom_exit);
 
