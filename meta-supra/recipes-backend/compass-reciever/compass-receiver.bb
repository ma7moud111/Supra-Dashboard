SUMMARY = "Compass Data Receiver using Python"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://compass_server.py \
    file://compass-receiver.service \
"

inherit systemd

S = "${WORKDIR}"

RDEPENDS:${PN} += "python3 "

do_install() {
    # Install Python script
    install -d ${D}/usr/share/compass-receiver
    install -m 0755 ${WORKDIR}/compass_server.py ${D}/usr/share/compass-receiver/

    # Install systemd service (but not auto-enabled)
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/compass-receiver.service ${D}${systemd_system_unitdir}/
}

FILES:${PN} += "/usr/share/compass-receiver \
    ${systemd_system_unitdir}/compass-receiver.service \
    "
