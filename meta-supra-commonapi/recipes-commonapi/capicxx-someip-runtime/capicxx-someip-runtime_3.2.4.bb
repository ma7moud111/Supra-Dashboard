SUMMARY = "CommonAPI C++ SOME/IP Runtime"
HOMEPAGE = "https://github.com/COVESA/capicxx-someip-runtime"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"

SRC_URI = "git://github.com/COVESA/capicxx-someip-runtime.git;protocol=https;branch=master"
SRCREV  = "86dfd69802e673d00aed0062f41eddea4670b571"
PV      = "3.2.4"
S       = "${WORKDIR}/git"

inherit cmake pkgconfig

DEPENDS += "capicxx-core-runtime vsomeip boost"

EXTRA_OECMAKE += "\
    -DCOMMONAPI_ROOT_DIR=${STAGING_DIR_TARGET}${prefix} \
    -DCMAKE_PREFIX_PATH=${STAGING_DIR_TARGET}${prefix}/lib/cmake \
    -DCMAKE_INSTALL_LIBDIR=${baselib} \
    -DBOOST_INCLUDEDIR=${STAGING_INCDIR} \
    -DBOOST_LIBRARYDIR=${STAGING_LIBDIR} \
    -DBoost_NO_SYSTEM_PATHS=ON \
    -DBoost_NO_BOOST_CMAKE=ON \
"
