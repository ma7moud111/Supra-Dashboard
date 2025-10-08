#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/device.h>
#include <linux/fs.h>
#include <linux/uaccess.h>
#include <linux/io.h>
#include <linux/slab.h>
#include <linux/delay.h>

#define DRIVER_NAME "gpiomod"
#define GPIO_BASE_PHYS 0x3F200000UL
#define GPIO_MEM_SIZE  0xB4
#define GPIO_COUNT 28

/* Register offsets */
#define GPFSEL_OFFSET(n)   (0x00 + ((n) * 4))
#define GPSET0_OFFSET      0x1C
#define GPCLR0_OFFSET      0x28
#define GPLEV0_OFFSET      0x34
#define GPPUD_OFFSET       0x94
#define GPPUDCLK0_OFFSET   0x98

static void __iomem *gpio_base;
static struct class *mygpio_class;

/* helper: compute GPFSEL index and shift */
static inline void gpfsel_index_shift(int gpio, unsigned int *idx, unsigned int *shift)
{
    *idx = gpio / 10;
    *shift = (gpio % 10) * 3;
}

/* direction */
static void mygpio_set_direction_hw(int gpio, int out)
{
    unsigned int idx, shift;
    u32 reg, mask;

    gpfsel_index_shift(gpio, &idx, &shift);
    reg = ioread32(gpio_base + GPFSEL_OFFSET(idx));
    mask = 7u << shift;
    reg &= ~mask;
    if (out)
        reg |= (1u << shift);
    iowrite32(reg, gpio_base + GPFSEL_OFFSET(idx));
}

static void mygpio_set_value_hw(int gpio, int value)
{
    if (value)
        iowrite32(1u << gpio, gpio_base + GPSET0_OFFSET);
    else
        iowrite32(1u << gpio, gpio_base + GPCLR0_OFFSET);
}

static int mygpio_get_value_hw(int gpio)
{
    u32 lev = ioread32(gpio_base + GPLEV0_OFFSET);
    return (lev >> gpio) & 1u;
}

/* ---- PULL-UP / PULL-DOWN ---- */
enum pull_mode {
    PULL_DISABLE = 0,
    PULL_DOWN    = 1,
    PULL_UP      = 2
};

static void mygpio_set_pull_hw(int gpio, enum pull_mode mode)
{
    /* Step 1: Write to GPPUD */
    iowrite32(mode, gpio_base + GPPUD_OFFSET);
    udelay(5);

    /* Step 2: Clock in for this GPIO */
    iowrite32(1u << gpio, gpio_base + GPPUDCLK0_OFFSET);
    udelay(5);

    /* Step 3: Clear both */
    iowrite32(0, gpio_base + GPPUD_OFFSET);
    iowrite32(0, gpio_base + GPPUDCLK0_OFFSET);
}

/* ---- sysfs attributes ---- */
static ssize_t direction_show(struct device *dev, struct device_attribute *attr, char *buf)
{
    int gpio = (int)(long)dev_get_drvdata(dev);
    unsigned int idx, shift;
    u32 reg, funct;

    gpfsel_index_shift(gpio, &idx, &shift);
    reg = ioread32(gpio_base + GPFSEL_OFFSET(idx));
    funct = (reg >> shift) & 7u;
    return scnprintf(buf, PAGE_SIZE, "%s\n", funct == 1u ? "out" : "in");
}

static ssize_t direction_store(struct device *dev, struct device_attribute *attr,
                               const char *buf, size_t count)
{
    int gpio = (int)(long)dev_get_drvdata(dev);

    if (strncmp(buf, "out", 3) == 0)
        mygpio_set_direction_hw(gpio, 1);
    else if (strncmp(buf, "in", 2) == 0)
        mygpio_set_direction_hw(gpio, 0);
    else
        return -EINVAL;

    return count;
}

static ssize_t value_show(struct device *dev, struct device_attribute *attr, char *buf)
{
    int gpio = (int)(long)dev_get_drvdata(dev);
    int v = mygpio_get_value_hw(gpio);
    return scnprintf(buf, PAGE_SIZE, "%d\n", v);
}

static ssize_t value_store(struct device *dev, struct device_attribute *attr,
                           const char *buf, size_t count)
{
    int gpio = (int)(long)dev_get_drvdata(dev);

    if (buf[0] == '1')
        mygpio_set_value_hw(gpio, 1);
    else if (buf[0] == '0')
        mygpio_set_value_hw(gpio, 0);
    else
        return -EINVAL;

    mygpio_set_direction_hw(gpio, 1);
    return count;
}

/* ---- PULL-UP / PULL-DOWN attributes ---- */
static enum pull_mode current_pull[GPIO_COUNT] = { [0 ... (GPIO_COUNT - 1)] = PULL_DISABLE };

static ssize_t pull_up_show(struct device *dev, struct device_attribute *attr, char *buf)
{
    int gpio = (int)(long)dev_get_drvdata(dev);
    return scnprintf(buf, PAGE_SIZE, "%d\n", current_pull[gpio] == PULL_UP ? 1 : 0);
}

static ssize_t pull_up_store(struct device *dev, struct device_attribute *attr,
                             const char *buf, size_t count)
{
    int gpio = (int)(long)dev_get_drvdata(dev);

    if (buf[0] == '1') {
        mygpio_set_pull_hw(gpio, PULL_UP);
        current_pull[gpio] = PULL_UP;
    } else if (buf[0] == '0') {
        mygpio_set_pull_hw(gpio, PULL_DISABLE);
        current_pull[gpio] = PULL_DISABLE;
    } else
        return -EINVAL;
    return count;
}

static ssize_t pull_down_show(struct device *dev, struct device_attribute *attr, char *buf)
{
    int gpio = (int)(long)dev_get_drvdata(dev);
    return scnprintf(buf, PAGE_SIZE, "%d\n", current_pull[gpio] == PULL_DOWN ? 1 : 0);
}

static ssize_t pull_down_store(struct device *dev, struct device_attribute *attr,
                               const char *buf, size_t count)
{
    int gpio = (int)(long)dev_get_drvdata(dev);

    if (buf[0] == '1') {
        mygpio_set_pull_hw(gpio, PULL_DOWN);
        current_pull[gpio] = PULL_DOWN;
    } else if (buf[0] == '0') {
        mygpio_set_pull_hw(gpio, PULL_DISABLE);
        current_pull[gpio] = PULL_DISABLE;
    } else
        return -EINVAL;
    return count;
}

static DEVICE_ATTR_RW(direction);
static DEVICE_ATTR_RW(value);
static DEVICE_ATTR_RW(pull_up);
static DEVICE_ATTR_RW(pull_down);

static int create_gpio_device(int gpio)
{
    struct device *dev;
    dev = device_create(mygpio_class, NULL, MKDEV(0, gpio), NULL, "gpio%d", gpio);
    if (IS_ERR(dev))
        return PTR_ERR(dev);

    dev_set_drvdata(dev, (void *)(long)gpio);

    if (device_create_file(dev, &dev_attr_direction) ||
        device_create_file(dev, &dev_attr_value) ||
        device_create_file(dev, &dev_attr_pull_up) ||
        device_create_file(dev, &dev_attr_pull_down)) {
        device_unregister(dev);
        return -EIO;
    }
    return 0;
}

static int __init mygpio_init(void)
{
    int i, ret;

    gpio_base = ioremap(GPIO_BASE_PHYS, GPIO_MEM_SIZE);
    if (!gpio_base)
        return -ENOMEM;

    mygpio_class = class_create(THIS_MODULE, DRIVER_NAME);
    if (IS_ERR(mygpio_class)) {
        iounmap(gpio_base);
        return PTR_ERR(mygpio_class);
    }

    for (i = 0; i < GPIO_COUNT; ++i) {
        ret = create_gpio_device(i);
        if (ret)
            break;
    }

    pr_info(DRIVER_NAME ": loaded with full pull-up/down support\n");
    return 0;
}

static void __exit mygpio_exit(void)
{
    int i;
    for (i = 0; i < GPIO_COUNT; ++i)
        device_destroy(mygpio_class, MKDEV(0, i));
    class_destroy(mygpio_class);
    iounmap(gpio_base);
    pr_info(DRIVER_NAME ": unloaded\n");
}

module_init(mygpio_init);
module_exit(mygpio_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Abdo");
MODULE_DESCRIPTION("Custom modular GPIO driver with full pull-up/down control for BCM2837");
