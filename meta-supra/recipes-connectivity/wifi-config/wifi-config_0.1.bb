SUMMARY = "Provide WiFi configuration with static IP service"
LICENSE = "CLOSED"

SRC_URI = "file://wpa_supplicant.conf \
           file://wifi-static.sh \
           file://wifi-static.service"

S = "${WORKDIR}"

inherit allarch systemd

do_install() {
    # WiFi config
    install -d ${D}${sysconfdir}/wpa_supplicant
    install -m 0600 ${WORKDIR}/wpa_supplicant.conf \
        ${D}${sysconfdir}/wpa_supplicant/wpa_supplicant.conf

    # Script
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/wifi-static.sh \
        ${D}${bindir}/wifi-static.sh

    # Systemd unit
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/wifi-static.service \
        ${D}${systemd_system_unitdir}/wifi-static.service
}

FILES:${PN} += " \
    ${sysconfdir}/wpa_supplicant/wpa_supplicant.conf \
    ${bindir}/wifi-static.sh \
    ${systemd_system_unitdir}/wifi-static.service \
"

SYSTEMD_SERVICE:${PN} = "wifi-static.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"
