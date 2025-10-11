SUMMARY = "Supra CommonAPI Package Group"
LICENSE = "CLOSED"

PACKAGES = "${PN}"
PACKAGE_ARCH = "${MACHINE_ARCH}"

RDEPENDS:${PN} = "\
    capicxx-core-runtime \
    capicxx-someip-runtime \
    vsomeip \
"

ALLOW_EMPTY:${PN} = "1"

