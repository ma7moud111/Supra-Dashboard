SUMMARY = "Add user supra to the system"
DESCRIPTION = "Creates the supra user and assigns basic group permissions"
LICENSE = "CLOSED"

inherit useradd

# Encrypted password (SHA-512)
SUPRA_PASSWD = "\$6\$Mh5L7et1F/EUZZNZ\$AJLz0I1Wht2dWngljgwPliiH2.gK4jDnIPxT68W4.AY5Gf1/vVkILDTKpukXzN/1oYVNMy2dXLYsqrt2/ut.o/"

USERADD_PACKAGES = "${PN}"

# Make sure the supra group is created first
GROUPADD_PARAM:${PN} = "-g 1001 supra"

# Minimal, clean user creation — no fragile -G list yet
USERADD_PARAM:${PN} = "-u 1001 -m -d /home/supra -r -s /bin/bash -p '${SUPRA_PASSWD}' -g supra supra"

# do_install() {
#     # Just create a placeholder in home
#     install -d -m 755 ${D}/home/supra
#     echo "Welcome to supra's home directory" > ${D}/home/supra/README.txt
# }

# FILES:${PN} = "/home/supra"

# # Fix ownership safely after rootfs build
# ROOTFS_POSTPROCESS_COMMAND += "fix_supra_home_ownership;"

# fix_supra_home_ownership() {
#     if [ -d ${IMAGE_ROOTFS}/home/supra ]; then
#         chown -R 1001:1001 ${IMAGE_ROOTFS}/home/supra || true
#         chmod 700 ${IMAGE_ROOTFS}/home/supra || true
#     fi
# }

ALLOW_EMPTY:${PN} = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
EXCLUDE_FROM_WORLD = "1"
