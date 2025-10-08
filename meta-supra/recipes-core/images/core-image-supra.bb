SUMMARY = "Custom supra image for our car dashboard system"
DESCRIPTION = "A customized Yocto image built for Raspberry Pi with Weston GUI to run car dashboard system."

# Include basic Weston and system features
IMAGE_FEATURES:append = " splash package-management ssh-server-dropbear hwcodecs weston "

# Remove uneeded 
IMAGE_FEATURES:remove = "ssh-server-dropbear"
# Image Install apps
IMAGE_INSTALL:append = " python3 bash tcpdump openssh psplash wifi-config rdp-certs tictactoe dashboard-service user-supra gpio-driver servo button "
#IMAGE_INSTALL:remove = " weston-xwayland"
#CORE_IMAGE_EXTRA_INSTALL:append = " plymouth"

EXTRA_IMAGE_FEATURES ?= "debug-tweaks ssh-server-openssh"

# Enable UART for tty
ENABLE_UART = "1"
SERIAL_CONSOLES = "115200;ttyS0"

# Configure gpio17 as pull-up
RPI_EXTRA_CONFIG:append = " gpio=5=ip,pu"
RPI_EXTRA_CONFIG:append = " gpio=6=ip,pu"
RPI_EXTRA_CONFIG:append = " gpio=12=ip,pu"
RPI_EXTRA_CONFIG:append = " gpio=16=ip,pu"
RPI_EXTRA_CONFIG:append = " gpio=20=ip,pu"


# Add custom applications and packages to the image
IMAGE_INSTALL:append = " gtk+3-demo "

# Inherit from the base core-image class
inherit core-image

# tell it to append the .wic directly
IMAGE_FSTYPES:append = " wic wic.bmap"

# Extend root filesystem space (5GB extra)
#IMAGE_ROOTFS_EXTRA_SPACE = "5242880"

# Example of adding demo app
CORE_IMAGE_BASE_INSTALL += " gtk+3-demo"

# QEMU testing memory
QB_MEM = "-m 512"