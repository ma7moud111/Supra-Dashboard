SUMMARY = "Systemd service to start tictactoe at boot"
DESCRIPTION = "Installs and enables the myapp.service unit for systemd"
LICENSE = "CLOSED"

SRC_URI = "file://tictactoe.service"

inherit systemd
SYSTEMD_AUTO_ENABLE = "enable"

SYSTEMD_SERVICE:${PN} = "tictactoe.service"

do_install() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/tictactoe.service ${D}${systemd_system_unitdir}/
}

FILES:${PN} += "${systemd_system_unitdir}/tictactoe.service"
