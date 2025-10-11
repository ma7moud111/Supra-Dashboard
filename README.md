# Supra Dashboard — metaz-dev Branch

This branch contains the main Yocto layers that define the base system distribution, custom image recipe, and helper utilities for the Supra Dashboard project. It serves as the foundation for building a lightweight, headless-capable embedded Linux system for Raspberry Pi 3B (64-bit).

## Branch Overview

The metaz-dev branch is organized into two primary Yocto meta-layers:

- **meta-supra** — the primary production layer containing the distro definition, image recipe, and all support recipes
- **meta-supra-commonapi** — a future-focused layer reserved for SOME/IP integration (currently disabled)

Together, these layers define how the Supra system is built, what components it includes, and how it's configured for the target hardware.

---

## Repository Structure

```
metaz-dev/
├── meta-supra/
│   ├── conf/
│   │   ├── layer.conf                    # Yocto layer metadata (priority, compat)
│   │   ├── machine/                      # Machine-specific overrides (optional)
│   │   └── distro/
│   │       └── supra.conf                # Distribution definition
│   ├── recipes-core/
│   │   └── images/
│   │       └── core-image-supra.bb       # Main image recipe
│   ├── recipes-extended/
│   │   ├── openssh/                      # SSH server customization
│   │   ├── wifi-config/                  # Wi-Fi configuration helpers
│   │   └── rdp-certs/                    # RDP certificate setup
│   ├── recipes-devtools/
│   │   └── tools/                        # Development and diagnostic tools
│   └── recipes-bsp/
│       └── rpi-config/                   # Raspberry Pi specific tweaks
│
└── meta-supra-commonapi/
    ├── conf/
    │   └── layer.conf
    ├── recipes-core/
    │   └── commonapi/                    # Future: CommonAPI runtimes
    └── recipes-extended/
        └── someip/                       # Future: SOME/IP stack
```

---

## Distro Definition: supra

The distro is defined in `meta-supra/conf/distro/supra.conf` and establishes the system baseline.

### Key Distro Settings

**Identity & Versioning:**
- `DISTRO = "supra"` — official distribution name
- `DISTRO_VERSION = "1.0.0"` — semantic versioning
- `DISTRO_CODENAME = "kirkstone"` — aligned with Yocto Kirkstone LTS release

**Core Features:**
```
DISTRO_FEATURES += "systemd wayland pam wifi"
```
- **systemd** — modern init system with service management
- **wayland** — display server protocol for GPU-accelerated graphics
- **pam** — pluggable authentication modules for flexible security
- **wifi** — wireless networking support (drivers + connectivity tools)

**Default Behaviors:**
- Init manager → systemd (replaces SysVinit)
- Security → PAM-based authentication
- Graphics → Wayland instead of X11 (lighter on embedded resources)
- Networking → Wi-Fi capable with ConnMan or NetworkManager

**Build Defaults:**
- Package format optimized for RPi (ARM64)
- Security hardening enabled where appropriate
- Debug symbols removed by default (release builds only)

---

## Image Recipe: core-image-supra

The main image is defined in `meta-supra/recipes-core/images/core-image-supra.bb`.

### Purpose

This recipe assembles the final system image that boots on the Raspberry Pi 3B in 64-bit mode. It combines the distro (supra), base packages, services, and hardware support into a single .wic disk image.

### Key Image Features & Settings

**Display & Boot:**
```
IMAGE_FEATURES += "weston splash"
```
- **weston** — Wayland compositor included, providing minimal GUI capability
- **splash** — boot splash screen for visual feedback during startup

**Networking & Remote Access:**
```
IMAGE_INSTALL += "openssh openssh-sftp-server"
```
- Replaces Dropbear (default SSH) with OpenSSH for broader compatibility
- Includes SFTP for secure file transfer
- Enabled and started by default via systemd

**Serial & Hardware Access:**
```
ENABLE_UART = "1"
```
- Enables UART on GPIO pins for serial console access
- Useful for debugging and headless operation
- Configured at firmware level (Pi bootloader respects this)

**Development & Diagnostics:**
```
IMAGE_INSTALL += "python3 bash tcpdump vim"
```
- **python3** — scripting and future dashboard backend support
- **bash** — modern shell (instead of ash)
- **tcpdump** — network packet analysis
- **vim** — advanced text editor

**Storage & Output:**
```
IMAGE_FSTYPES = "wic.gz wic.bmap"
```
- **wic** — Wic Image Creator format (partition table included)
- **gz** — compressed for faster downloads and flashing
- **bmap** — block map file for efficient, resumable flashing via bmaptool

### Helper Recipes Included

**Wi-Fi Configuration** (`recipes-extended/wifi-config/`):
- Provides pre-configured ConnMan or NetworkManager profiles
- Allows first-boot Wi-Fi connection without manual setup
- Stores SSID/passphrase safely (can be encrypted at build time)

**RDP Certificate Setup** (`recipes-extended/rdp-certs/`):
- Pre-generates certificates for Weston RDP backend
- Enables remote desktop access over network
- Useful for headless dashboards accessed from workstations

**OpenSSH Customization** (`recipes-extended/openssh/`):
- Tailors SSH daemon settings (key generation, port, etc.)
- Enables password and public-key authentication
- Integrates with systemd for clean service management

**Raspberry Pi BSP Tweaks** (`recipes-bsp/rpi-config/`):
- Applies Pi-specific u-boot patches
- Configures GPIO, SPI, I2C if needed
- Adjusts frequency scaling and thermal management

---

## Layer Configuration: layer.conf

The `meta-supra/conf/layer.conf` file registers this layer with the Yocto build system.

### What It Does

```
BBPATH .= ":${LAYERDIR}"
BBFILES += "${LAYERDIR}/recipes-*/*/*.bb ${LAYERDIR}/recipes-*/*/*.bbappend"
BBFILE_COLLECTIONS += "meta-supra"
BBFILE_PATTERN_meta-supra = "^${LAYERDIR}/"
LAYERVERSION_meta-supra = "1"
LAYERSERIES_COMPAT_kirkstone = "1"
```

- **BBPATH** — tells bitbake where recipe files are located
- **BBFILES** — glob pattern for .bb and .bbappend files
- **BBFILE_COLLECTIONS** — layer identifier
- **LAYERVERSION** — layer version for dependency tracking
- **LAYERSERIES_COMPAT** — compatibility with Kirkstone series (prevents bitbake warnings)

---

## How to Use This Branch

### Prerequisites

You need a standard Yocto build environment:
- **poky** (Yocto reference distribution)
- **meta-raspberrypi** (Raspberry Pi BSP layer)
- Any additional OE layers (openembedded-core, meta-openembedded, etc.)

### Setup Steps

**1. Clone your Yocto workspace and add this branch:**

```bash
cd ~/work/yocto
git clone -b metaz-dev https://github.com/ma7moud111/Supra-Dashboard.git supra-layers
```

**2. Update your build's `conf/bblayers.conf`:**

```python
BBLAYERS ?= " \
  /path/to/poky/meta \
  /path/to/poky/meta-poky \
  /path/to/meta-raspberrypi \
  /path/to/supra-layers/meta-supra \
"

# Uncomment when SOME/IP integration is ready:
# BBLAYERS += "/path/to/supra-layers/meta-supra-commonapi"
```

**3. Configure your build in `conf/local.conf`:**

```python
MACHINE = "raspberrypi3-64"
DISTRO  = "supra"

# Optional: adjust build parallelism for your hardware
BB_NUMBER_THREADS = "4"
PARALLEL_MAKE = "-j 4"
```

**4. Initialize the build environment and build:**

```bash
source poky/oe-init-build-env build-supra
bitbake core-image-supra
```

**5. Find your output image:**

```
tmp/deploy/images/raspberrypi3-64/core-image-supra-raspberrypi3-64.wic.gz
tmp/deploy/images/raspberrypi3-64/core-image-supra-raspberrypi3-64.wic.bmap
```

### Flashing to SD Card

**Using bmaptool (recommended):**

```bash
sudo bmaptool copy \
  tmp/deploy/images/raspberrypi3-64/core-image-supra-raspberrypi3-64.wic.gz \
  /dev/sdX
```

The .bmap file ensures efficient, resumable writes and validates checksums automatically.

**Using dd (slower, less safe):**

```bash
gunzip -c core-image-supra-raspberrypi3-64.wic.gz | \
  sudo dd of=/dev/sdX bs=4M conv=fsync
```

---

## First Boot & Operation

### Physical Connection

1. Insert the flashed SD card into the Raspberry Pi 3B
2. Connect power (5V micro-USB)
3. Optionally connect:
   - HDMI for display + USB keyboard
   - Ethernet or use pre-configured Wi-Fi
   - Serial console via UART (GPIO 14/15) at 115200 baud

### Boot Process

The Pi will:
1. Load u-boot from the SD card
2. Start the Linux kernel (ARM64)
3. Init systemd
4. Launch Weston (if HDMI connected) or drop to serial/SSH login

### Default Access

- **Serial console** — root login (no password set by default; configure in recipes)
- **SSH** — `ssh root@<ip-address>` using OpenSSH
- **Display** — Weston provides a minimal compositor (right-click for menu)

### Systemd Service Management

Once booted, manage services like this:

```bash
# List services
systemctl list-units --type=service

# Enable a service to start on boot
systemctl enable myservice

# Start/stop/restart a service
systemctl start myservice
systemctl stop myservice
systemctl restart myservice

# View live logs
journalctl -u myservice -f

# View all system logs
journalctl -b
```

---

## Recipes Breakdown

### recipes-core/images/core-image-supra.bb

**Inherits:** `core-image` (provides base image template)  
**Purpose:** Assembles the final disk image

**Key Variables:**
- `IMAGE_INSTALL` — list of packages to include
- `IMAGE_FEATURES` — high-level toggles (weston, splash, etc.)
- `IMAGE_FSTYPES` — output file formats
- `ENABLE_UART` — hardware config

**Typical Customizations:**
- Add packages: append to `IMAGE_INSTALL`
- Change features: modify `IMAGE_FEATURES`
- Adjust filesystem: update `IMAGE_FSTYPES`
- Add systemd services: include them in `IMAGE_INSTALL` and enable via `.service` files

### recipes-extended/openssh/

**Purpose:** Customize SSH daemon behavior  
**Includes:**
- Server key generation on first boot
- Port configuration (default 22)
- Authentication method selection
- systemd integration for clean startup/shutdown

### recipes-extended/wifi-config/

**Purpose:** Deliver pre-configured wireless profiles  
**Includes:**
- ConnMan service files for automatic connection
- NetworkManager profiles (optional)
- Passphrase storage (encrypted or plaintext, configurable)
- Fallback to manual wpa_supplicant if needed

### recipes-extended/rdp-certs/

**Purpose:** Enable remote desktop via Weston RDP backend  
**Includes:**
- Self-signed certificate generation
- Systemd service to start RDP listener
- Configuration for remote access (port, security)
- Useful for headless Pi with Weston running off-screen

### recipes-bsp/rpi-config/

**Purpose:** Pi-specific kernel and firmware tweaks  
**Includes:**
- Device tree customizations
- GPIO setup (if needed)
- SPI/I2C configuration
- CPU frequency scaling and thermal management
- Bootloader parameters

---

## Future: meta-supra-commonapi (SOME/IP Integration)

This layer is reserved for future work on real-time middleware. It is currently disabled.

### What Will Go There

**CommonAPI Runtime** — DBUS middleware for service-oriented architecture

**vSomeIP Stack** — SOME/IP protocol implementation (automotive standard)

**IDL & Codegen** — Franca interface definition language and code generation tools

**Example Services** — HelloWorld service/client for testing communication

**Systemd Units** — Service files for automatic discovery and lifecycle management

### When Ready

1. Add the layer to `bblayers.conf`
2. Include dependencies in the image (boost, etc.)
3. Add service recipes to `recipes-extended/`
4. Build and test

For now, the folder structure is in place; no recipes are active.

---

## Troubleshooting

### No GUI / Weston Won't Start

**Check:**
- `DISTRO_FEATURES` includes `wayland` in supra.conf
- `IMAGE_FEATURES` includes `weston` in core-image-supra.bb
- HDMI is connected before boot
- GPU drivers are present (meta-raspberrypi should provide them)

**Debug:**
```bash
ps aux | grep weston
journalctl -u weston -n 50
# Check GPU memory allocation (check config.txt on FAT partition)
cat /proc/device-tree/model
```

### SSH Not Accessible

**Check:**
- `openssh` is in `IMAGE_INSTALL`
- Service is running: `systemctl status ssh`
- Port 22 is not blocked by iptables
- Network is up: `ip addr` and `ip route`

**Debug:**
```bash
systemctl status ssh
journalctl -u ssh -n 50
netstat -tlnp | grep :22
```

### Serial Console Not Working

**Check:**
- `ENABLE_UART = "1"` is set in core-image-supra.bb
- USB-to-UART adapter wired correctly (TX→GPIO14, RX→GPIO15, GND→GND)
- Serial terminal config: 115200 baud, 8N1

**Debug:**
```bash
dmesg | grep tty
cat /proc/device-tree/aliases/uart0
```

### Wi-Fi Connection Issues

**Check:**
- Wi-Fi config files are present: `/etc/connman/` or `/etc/NetworkManager/`
- SSID and passphrase are correct
- Wireless driver is loaded: `rfkill list`

**Debug:**
```bash
connmanctl commands  # if using ConnMan
# or
nmcli device wifi list  # if using NetworkManager
journalctl -u connman -f
```

### Build Fails with "Layer Not Found"

**Check:**
- Path in `bblayers.conf` is correct and exists
- `layer.conf` is in `meta-supra/conf/`
- `LAYERSERIES_COMPAT_kirkstone` is set

**Debug:**
```bash
bitbake-layers show-layers
bitbake-layers flatten
```

---

## What's Next

### Immediate Next Steps

1. **Test the build** — Ensure core-image-supra builds cleanly on your setup
2. **Flash and boot** — Verify the Pi 3B boots and reaches a login prompt
3. **Validate features** — Confirm SSH, Weston, and Wi-Fi work as expected

### Integration Pipeline

Once metaz-dev is stable:

1. **Qt Dashboard** (from qt-dev branch)
   - Build the Qt application
   - Add qt-base and qt-declarative to IMAGE_INSTALL
   - Include systemd service for dashboard auto-start

2. **Backend Services** (from backend-dev branch)
   - Integrate sensor/control daemons
   - Add to IMAGE_INSTALL
   - Enable systemd services for auto-start

3. **Production Release**
   - Pin all layer SHAs to specific commits
   - Tag as release candidate
   - Move to production branch with frozen versions

### Version Management

- Keep metaz-dev as the active development branch
- Tag stable builds: `v1.0.0`, `v1.0.1`, etc.
- Consider a production branch (prod) for release builds
- Maintain compatibility with Yocto Kirkstone LTS through end-of-life

---

## References

- **Yocto Project Documentation** — https://docs.yoctoproject.org/
- **Raspberry Pi Yocto Layer** — https://github.com/agherzan/meta-raspberrypi
- **Weston Compositor** — https://wayland.freedesktop.org/weston/
- **OpenSSH Configuration** — https://man.openbsd.org/sshd_config
- **systemd Manual** — https://www.freedesktop.org/wiki/Software/systemd/

---

## Summary

The **metaz-dev** branch provides a clean, modular Yocto foundation for building the Supra Dashboard system image. The distro (supra) and image recipe (core-image-supra) work together to deliver a Wayland-based, SSH-accessible embedded Linux for Raspberry Pi 3B. Helper recipes add Wi-Fi and RDP support. The CommonAPI layer is held in reserve for future real-time middleware integration. Use this branch as the stable base for integrating the Qt dashboard and backend services from other branches.