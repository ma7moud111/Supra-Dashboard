 
/* gpiomod.h
 * Header for the custom gpiomod kernel module
 * Provides defines, enums, structs, prototypes and basic locking.
 *
 * Author: Abdo
 * License: GPLv2
 */

#ifndef _GPIOMOD_H_
#define _GPIOMOD_H_

#include <linux/types.h>
#include <linux/mutex.h>

/* Driver name / sysfs class */
#define GPIOMOD_NAME       "gpiomod"

/* Physical GPIO base for BCM2837 (Raspberry Pi 2/3) */
#define GPIO_BASE_PHYS     0x3F200000UL
#define GPIO_MEM_SIZE      0xB4

/* How many GPIOs we expose (0..N-1) */
#define GPIOMOD_GPIO_COUNT 28

/* Register offsets (bytes) relative to GPIO base) */
#define GPFSEL_OFFSET(n)    (0x00 + ((n) * 4))  /* n = 0..5, each controls 10 pins */
#define GPSET0_OFFSET       0x1C
#define GPCLR0_OFFSET       0x28
#define GPLEV0_OFFSET       0x34
#define GPPUD_OFFSET        0x94
#define GPPUDCLK0_OFFSET    0x98

/* For convenience: microsecond delays used by the Broadcom sequence */
#define GPPUD_WAIT_USEC     5

/* Pull modes */
enum gpiom_pull {
    GPIOM_PULL_DISABLE = 0,
    GPIOM_PULL_DOWN    = 1,
    GPIOM_PULL_UP      = 2,
};

/* Per-GPIO runtime state stored in kernel */
struct gpiom_pin {
    int number;                 /* GPIO number (0..N-1) */
    enum gpiom_pull pull;       /* last applied pull state */
    /* other fields could include debounce, irq state etc. */
};

/* Global state (opaque in .c) */
extern void __iomem *gpiom_base;
extern struct gpiom_pin gpiom_pins[GPIOMOD_GPIO_COUNT];
extern struct mutex gpiom_lock; /* protect gpiom_pins[] and register sequences */

/* low-level hardware helpers (used internally) */
extern void gpiom_hw_set_direction(unsigned int gpio, int output);
extern void gpiom_hw_set_value(unsigned int gpio, int value);
extern int  gpiom_hw_get_value(unsigned int gpio);
extern void gpiom_hw_set_pull(unsigned int gpio, enum gpiom_pull mode);

/* sysfs helpers (used in the module) */
extern int gpiom_create_devices(void);
extern void gpiom_destroy_devices(void);

#endif /* _GPIOMOD_H_ */
 
