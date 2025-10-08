LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

#FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " \
    file://servo.cpp \
    file://CMakeLists.txt \
    file://servo.service \
"

PV = "1.0"
S = "${WORKDIR}"

inherit cmake systemd

EXTRA_OECMAKE = ""

do_install:append() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/servo ${D}${bindir}/servo

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/servo.service ${D}${systemd_system_unitdir}/servo.service

        # Create initial CSV file with default values

}

SYSTEMD_AUTO_ENABLE:${PN} = "enable"
SYSTEMD_SERVICE:${PN} = "servo.service"

FILES:${PN} += "${systemd_system_unitdir}/servo.service"
