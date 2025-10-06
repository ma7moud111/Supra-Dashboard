# Fix host contamination: force all installed files to root:root
do_install:append() {
    chown -R root:root ${D}
}