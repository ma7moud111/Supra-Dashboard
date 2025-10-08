
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "file://button.cpp \
           file://CMakeLists.txt \
		   file://button.service " 


PV = "1.0"


S = "${WORKDIR}"

inherit cmake systemd

EXTRA_OECMAKE = ""

# install binary
do_install:append() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/button ${D}${bindir}/button

    # install systemd service
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/button.service ${D}${systemd_system_unitdir}/button.service
}

# enable service
SYSTEMD_AUTO_ENABLE:${PN} = "enable"
SYSTEMD_SERVICE:${PN} = "button.service"
FILES:${PN} += "${systemd_system_unitdir}/button.service"

