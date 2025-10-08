# meta-supra/recipes-kernel/linux/linux-raspberrypi_%.bbappend

# Append boot arguments to suppress kernel messages and show splash cleanly
APPEND:append = " quiet vt.global_cursor_default=0 loglevel=3 consoleblank=0 splash"
