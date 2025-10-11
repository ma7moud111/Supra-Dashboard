SUMMARY = "COVESA vSomeIP implementation"
HOMEPAGE = "https://github.com/COVESA/vsomeip"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"

PV = "3.4.10"
SRC_URI = "git://github.com/COVESA/vsomeip.git;protocol=https;branch=master \
           file://no-tests.patch \
"
SRCREV  = "02c199dff8aba814beebe3ca417fd991058fe90c"

S = "${WORKDIR}/git"

inherit cmake pkgconfig
DEPENDS += "boost"

EXTRA_OECMAKE = "\
    -DCMAKE_INSTALL_LIBDIR=${baselib} \
    -DBOOST_INCLUDEDIR=${STAGING_INCDIR} \
    -DBOOST_LIBRARYDIR=${STAGING_LIBDIR} \
    -DBoost_NO_SYSTEM_PATHS=ON \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DBUILD_TESTING=OFF \
    -DBUILD_TESTS=OFF \
    -DVSOMEIP_BUILD_TESTS=OFF \
    -DVSOMEIP_ENABLE_TESTS=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DVSOMEIP_BUILD_EXAMPLES=OFF \
    -DCMAKE_DISABLE_FIND_PACKAGE_GTest=ON \
    -DCMAKE_DISABLE_FIND_PACKAGE_benchmark=ON \
    -DFETCHCONTENT_FULLY_DISCONNECTED=ON \
    -DENABLE_DLT=OFF \
    -DENABLE_SYSTEMD=OFF \
    -DVSOMEIP_ENABLE_SSL=OFF \
"

FILES:${PN} += " \
    ${sysconfdir}/vsomeip \
    ${sysconfdir}/vsomeip/*.json \
"

# Some versions wrongly install under /usr/etc; move them properly:
do_install:append() {
    if [ -d ${D}${prefix}/etc ]; then
        mkdir -p ${D}${sysconfdir}
        mv ${D}${prefix}/etc/* ${D}${sysconfdir}/ 2>/dev/null || true
        rmdir --ignore-fail-on-non-empty ${D}${prefix}/etc || true
    fi
}

