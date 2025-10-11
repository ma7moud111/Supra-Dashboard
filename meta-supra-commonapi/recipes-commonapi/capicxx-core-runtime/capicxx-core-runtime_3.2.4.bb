SUMMARY = "CommonAPI C++ Core Runtime"
HOMEPAGE = "https://github.com/COVESA/capicxx-core-runtime"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"

SRC_URI = "git://github.com/COVESA/capicxx-core-runtime.git;protocol=https;branch=master"
SRCREV  = "0e1d97ef0264622194a42f20be1d6b4489b310b5"
PV      = "3.2.4"
S       = "${WORKDIR}/git"


inherit cmake pkgconfig
DEPENDS += "boost"
EXTRA_OECMAKE += "-DCMAKE_INSTALL_LIBDIR=${baselib}"

EXTRA_OECMAKE += "\
    -DBOOST_INCLUDEDIR=${STAGING_INCDIR} \
    -DBOOST_LIBRARYDIR=${STAGING_LIBDIR} \
    -DBoost_NO_SYSTEM_PATHS=ON \
    -DBoost_NO_BOOST_CMAKE=ON \
"
