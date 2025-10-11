# meta-supra-commonapi/recipes-apps/helloworld-someip/helloworld-someip_1.0.bb
SUMMARY = "CommonAPI HelloWorld SOME/IP (vendored src-gen)"
LICENSE = "CLOSED"
#LIC_FILES_CHKSUM = "file://E01HelloWorld.fidl;beginline=1;endline=5;md5=3b5d5c3712955042212316173ccf37be"

inherit cmake pkgconfig

DEPENDS = "capicxx-core-runtime capicxx-someip-runtime vsomeip"

SRC_URI = "\
    file://CMakeLists.txt \
    file://E01HelloWorldService.cpp \
    file://E01HelloWorldClient.cpp \
    file://E01HelloWorldStubImpl.hpp \
    file://E01HelloWorldStubImpl.cpp \
    file://E01HelloWorld.fidl \
    file://E01HelloWorld-SomeIP.fdepl \
    file://src-gen \
    file://vsomeip-e01.json \
"

S = "${WORKDIR}"
B = "${WORKDIR}/build"

EXTRA_OECMAKE = "\
  -DCMAKE_BUILD_TYPE=Release \
  -DGEN_DIR=${WORKDIR}/src-gen \
  -DCMAKE_INSTALL_PREFIX:PATH=${prefix} \
"

do_install:append() {
    install -d ${D}${sysconfdir}/vsomeip
    install -m 0644 ${WORKDIR}/vsomeip-e01.json ${D}${sysconfdir}/vsomeip/
}

FILES:${PN} += " ${sysconfdir}/vsomeip/vsomeip-e01.json"
