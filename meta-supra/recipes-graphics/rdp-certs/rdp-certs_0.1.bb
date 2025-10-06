DESCRIPTION = "A recipe to assign server certs for rdp"
LICENSE = "CLOSED"


SRC_URI = "file://server.key \
            file://server.crt"

S = "${WORKDIR}"


do_install(){
    install -d ${D}/etc/freerdp/keys
    install -m 600 ${WORKDIR}/server.key ${D}/etc/freerdp/keys
    install -m 644 ${WORKDIR}/server.crt ${D}/etc/freerdp/keys
}

FILES:${PN} = "/etc/freerdp/keys"