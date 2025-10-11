SUMMARY = "GPIO driver (out-of-tree) for Raspberry Pi"
DESCRIPTION = "${SUMMARY}"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=d14d058ef8b83f5143f5422ba9319cc7"

PV = "1.0"
PR = "r0"

SRC_URI = " \
    file://gpiomod.c \
    file://gpiomod.h \
    file://Makefile \
    file://COPYING \
"

S = "${WORKDIR}"

inherit module

#EXTRA_OEMAKE = "KERNEL_SRC=${STAGING_KERNEL_BUILDDIR}"

do_compile() {
    oe_runmake
}

do_install() {
    install -d ${D}/lib/modules/${KERNEL_VERSION}/extra
    install -m 0644 ${B}/gpiomod.ko ${D}/lib/modules/${KERNEL_VERSION}/extra/
}

RPROVIDES:${PN} += "kernel-module-gpiomod"

KERNEL_MODULE_AUTOLOAD += "gpiomod"
