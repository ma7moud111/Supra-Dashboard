# Make bitbake see the files dire inhere
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
# Enable Weston RDP backend
PACKAGECONFIG:append = " rdp"

SRC_URI:append = " file://weston-rdp.service"

#inherit systemd

do_install:append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/weston-rdp.service \
        ${D}${systemd_system_unitdir}/weston-rdp.service
}



FILES:${PN} += "${systemd_system_unitdir}/weston-rdp.service"
SYSTEMD_SERVICE:${PN} = "weston-rdp.service"
#SYSTEMD_AUTO_ENABLE = "enable"
