# 🧩 Supra Dashboard — `metaz-dev` Branch

> ⚙️ **Yocto-based system layer** powering the Supra Dashboard.
> Defines the **custom Linux distribution**, **image recipe**, and **embedded services** for Raspberry Pi 3B (64-bit).
> This branch serves as the **foundation** that the Qt front-end and backend layers build upon.

---

<p align="center">
  <img src="https://img.shields.io/badge/Yocto_Project-Kirkstone_LTS-blue?logo=yocto-project&logoColor=white">
  <img src="https://img.shields.io/badge/Target-Raspberry_Pi_3B_(64bit)-red">
  <img src="https://img.shields.io/badge/Init-Systemd-orange">
  <img src="https://img.shields.io/badge/Display-Wayland/Weston-green">
  <img src="https://img.shields.io/badge/Status-Active_(metaz--dev)-lightgrey">
</p>

---

## 📘 Overview

The **`metaz-dev`** branch defines two main Yocto layers:

* **`meta-supra`** → main production layer (distro, image, drivers, services, Qt, backend)
* **`meta-supra-commonapi`** → reserved for future SOME/IP + CommonAPI integration

Together, they create a **lightweight**, **secure**, and **modular Yocto-based Linux system** optimized for **Raspberry Pi 3B (64-bit)**.

---

## 🗂️ Real Meta-Layer Structure

```
meta-supra
├── conf
│   ├── distro
│   │   └── supra.conf
│   └── layer.conf
├── COPYING.MIT
├── README
├── recipes-backend
│   ├── button/
│   ├── compass-reciever/
│   └── servo/
├── recipes-connectivity
│   └── wifi-config/
├── recipes-core
│   ├── images/
│   └── users/
├── recipes-drivers
│   └── gpio/
├── recipes-example
│   └── example/
├── recipes-graphics
│   ├── images/
│   ├── rdp-certs/
│   └── wayland/
├── recipes-kernel
│   └── linux/
├── recipes-qt
│   ├── dashboard/
│   └── qt6/
└── recipes-services
    ├── dashboard-service/
    └── tictactoe-service/
```

> 🧱 Each directory maps to a functional module — backend daemons, graphics, Qt UI, services, and drivers — all included in the Supra image build.

---

## 🧠 Distro: `supra.conf`

**Path:** `meta-supra/conf/distro/supra.conf`

```bash
DISTRO = "supra"
DISTRO_VERSION = "1.0.0"
DISTRO_FEATURES += "systemd wayland pam wifi"
```

**Core Highlights**

* 🧩 `systemd` — init & service management
* 🎨 `wayland` — modern compositor
* 🔒 `pam` — secure authentication
* 📡 `wifi` — wireless networking

Optimized for **ARM64 performance**, with minimal overhead and strong modularity.

---

## 🖼️ Image Recipe: `core-image-supra.bb`

**Path:** `meta-supra/recipes-core/images/core-image-supra.bb`

```bash
IMAGE_FEATURES += "weston splash"
IMAGE_INSTALL  += "openssh openssh-sftp-server python3 bash tcpdump vim"
ENABLE_UART = "1"
IMAGE_FSTYPES = "wic.gz wic.bmap"
```

**Key Components**

| Category     | Packages                       |
| :----------- | :----------------------------- |
| 🧰 Dev Tools | python3 · bash · vim · tcpdump |
| 🔌 Network   | openssh · sftp-server · Wi-Fi  |
| 🖥️ Display  | weston · splash                |
| 🧬 Hardware  | UART + GPIO ready              |

---

## 🧩 Core Features Summary

| Feature              | Description                                                       |
| :------------------- | :---------------------------------------------------------------- |
| **Custom Distro**    | Defined via `supra.conf`, adds Wayland, PAM, and Wi-Fi            |
| **Custom Image**     | `core-image-supra.bb` builds `.wic.gz` + `.bmap` flashable images |
| **GPIO Driver**      | Kernel module for pin read/write and LED control                  |
| **Wi-Fi Config**     | Predefined ConnMan profiles for auto-connect                      |
| **RDP Certificates** | Enables Weston remote desktop backend                             |
| **Qt Integration**   | Builds and installs the Qt dashboard app                          |
| **Systemd Services** | Auto-starts dashboard and background daemons                      |

---

## ⚙️ Build & Flash Guide

```bash
# 1️⃣ Clone Yocto layers
git clone -b metaz-dev https://github.com/ma7moud111/Supra-Dashboard.git supra-layers

# 2️⃣ Add layers to bblayers.conf
BBLAYERS += "/path/to/supra-layers/meta-supra"

# 3️⃣ Configure build
MACHINE = "raspberrypi3-64"
DISTRO  = "supra"

# 4️⃣ Build image
source poky/oe-init-build-env build-supra
bitbake core-image-supra

# 5️⃣ Flash to SD card
sudo bmaptool copy tmp/deploy/images/raspberrypi3-64/core-image-supra-raspberrypi3-64.wic.gz /dev/sdX
```

---

## 🚀 First Boot Overview

| Access      | Description                               |
| :---------- | :---------------------------------------- |
| 🧠 Serial   | UART GPIO 14/15 @ 115200 baud             |
| 🔌 SSH      | `ssh root@<ip>` (OpenSSH)                 |
| 🖥️ Display | Weston compositor auto-starts             |
| 🔄 Services | Managed with `systemctl` and `journalctl` |

---

## 🧩 Visual Architecture

### 🧱 Layer & Recipes Overview

<img width="1559" height="541" alt="image" src="https://github.com/user-attachments/assets/5553abf1-e959-42f7-a987-fae6264b704c" />
<img width="1019" height="249" alt="image" src="https://github.com/user-attachments/assets/9c8af56a-c219-401d-af6f-79180a6f3f5f" />


### 🧰 Component Composition
<img width="1574" height="528" alt="image" src="https://github.com/user-attachments/assets/fb541017-d8f9-4da9-aab3-fd6ac5a93762" />


### 🚀 Build → Flash → Boot Pipeline
<img width="1009" height="968" alt="supra-deployment-diagram" src="https://github.com/user-attachments/assets/6474b84f-11ac-4a1d-aeb8-6b4e53d75e55" />

---

## 🔬 Troubleshooting

| Issue           | Solution                                                          |
| :-------------- | :---------------------------------------------------------------- |
| No GUI (Weston) | Add `wayland` to `DISTRO_FEATURES` and rebuild                    |
| SSH not working | Ensure `openssh` in `IMAGE_INSTALL`, check `systemctl status ssh` |
| Serial silent   | Confirm `ENABLE_UART = "1"` and proper wiring                     |
| Wi-Fi issues    | Validate `/etc/connman` or `/etc/NetworkManager` profiles         |

---

## 🧬 Future Layer — `meta-supra-commonapi`

Reserved for **automotive middleware integration**:

* CommonAPI runtime (DBus abstraction)
* vSomeIP protocol stack
* Franca IDL → Stub/Proxy generation
* Example HelloWorld services

> 🧩 Structure present but recipes disabled by default.

---

## 🧭 Next Steps

1. ✅ Validate `core-image-supra` build
2. 🧱 Integrate Qt Dashboard (`qt-dev` branch)
3. 🔗 Add backend daemons (`backend-dev`)
4. 🏁 Merge into `production` for final release

---

## 📚 References

* [Yocto Project Docs](https://docs.yoctoproject.org/)
* [Meta-Raspberry Pi](https://github.com/agherzan/meta-raspberrypi)
* [Weston Compositor](https://wayland.freedesktop.org/weston/)
* [systemd Manual](https://www.freedesktop.org/wiki/Software/systemd/)
* [OpenSSH Configuration](https://man.openbsd.org/sshd_config)

---

<p align="center"><b>🧩 The <code>metaz-dev</code> branch is the Yocto engine — building the embedded OS that drives the Supra Dashboard.</b></p>
