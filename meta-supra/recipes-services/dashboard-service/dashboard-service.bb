SUMMARY = "Systemd service to start supra dashboard at boot"
DESCRIPTION = "Installs and enables the dashboard.service unit for systemd"
LICENSE = "CLOSED"

SRC_URI = "file://dashboard.service"

inherit systemd
SYSTEMD_AUTO_ENABLE = "enable"

SYSTEMD_SERVICE:${PN} = "dashboard.service"

do_install() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/dashboard.service ${D}${systemd_system_unitdir}/
}

FILES:${PN} += "${systemd_system_unitdir}/dashboard.service"
