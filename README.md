# 🚗 Supra Dashboard — Main Branch

> 🧠 A **Raspberry Pi 3B (64-bit)** car dashboard built with **Qt 6 / QML** and the **Yocto Project**.
> This branch provides the **base UI layer** — a functional, lightweight dashboard preview before backend and Yocto integration.

---

<p align="center">
  <a href="https://www.qt.io/"><img src="https://img.shields.io/badge/Qt-6.7-brightgreen?logo=qt&logoColor=white"></a>
  <a href="https://www.yoctoproject.org/"><img src="https://img.shields.io/badge/Yocto%20Project-Custom%20Distro-blue?logo=yocto-project&logoColor=white"></a>
  <img src="https://img.shields.io/badge/Platform-Raspberry-red">
  <img src="https://img.shields.io/badge/Status-Base%20UI-lightgrey">
</p>

## Project Preview

https://github.com/user-attachments/assets/f98ee128-1e69-480a-a708-3073cfccd008

---

## 📘 Overview

* **Frontend:** Qt 6 / QML / C++ gauges (RPM · Speed · Temperature)
* **Backend:** Raspberry Pi GPIO driver for hardware–UI communication
* **Build System:** Yocto Project with custom `distro`, `image`, and `meta` layers

> 🧩 The **main** branch focuses on clarity — it’s a minimal Qt showcase and code base for further development.

---

## 🌿 Branch Map

| Branch                                                                          | Purpose                                   |
| :------------------------------------------------------------------------------ | :---------------------------------------- |
| [`main`](https://github.com/ma7moud111/Supra-Dashboard)                         | Base UI and repo structure (you’re here). |
| [`qt-dev`](https://github.com/ma7moud111/Supra-Dashboard/tree/qt-dev)           | UI design, layout tweaks, animations.     |
| [`metaz-dev`](https://github.com/ma7moud111/Supra-Dashboard/tree/metaz-dev)     | Yocto recipes, services, meta-layer work. |
| [`backend-dev`](https://github.com/ma7moud111/Supra-Dashboard/tree/backend-dev) | Sensor data and IPC backend apps.         |
| [`production`](https://github.com/ma7moud111/Supra-Dashboard/tree/production)   | Final merged Yocto image.                 |

---

## 📂 Repository Layout

```
Supra-Dashboard/
├─ qt-app/        # Qt/QML/C++ dashboard (UI + logic)
├─ meta-supra/    # Lightweight Yocto layer scaffold
└─ docs/          # Screenshots, diagrams, and notes
```

> 🧭 Start with **`qt-app/`** to explore or run the dashboard locally.

---

## 🎛️ Dashboard Highlights

| Gauge               | Description                      |
| :------------------ | :------------------------------- |
| ⚙️ **RPM**          | Smooth needle animation          |
| 🚗 **Speed**        | Large, easy-to-read scale        |
| 🌡️ **Temperature** | Safe / alert range visualization |

✅ Optimized for Raspberry Pi 3B (64-bit)
✅ Built with Qt 6/QML for performance and scalability

> All UI code and assets live under `qt-app/`.

---

<details>
<summary><b>⚡ Quick Start Guide</b></summary>

### ▶️ Run on PC

1. Open **Qt Creator**.
2. Load project from **`qt-app/`**.
3. Build & Run → press `Ctrl + F11` for fullscreen.

### 💻 Run on Raspberry Pi 3B (64-bit)

1. Copy or build from **`qt-app/`**.
2. Deploy to the Pi (`scp` or Yocto image).
3. Execute the app — fullscreen recommended.

> 🧩 The final “flash and run” image is built from the `production` branch.

</details>

---

<details>
<summary><b>🧱 Suggested Development Workflow</b></summary>

1. Prototype gauges in **`qt-app/`**.
2. Polish UI/UX in **`qt-dev`**.
3. Add services & recipes in **`metaz-dev`**.
4. Integrate hardware data in **`backend-dev`**.
5. Merge everything into **`production`** for release.

</details>

---

## 🤝 Contributing

* Keep `main` minimal & educational.
* Submit advanced UI or Yocto updates to their dedicated branches.
* Code or documentation that helps others is always welcome!

---

## ⚙️ Technical Stack

| Component         | Technology                          |
| :---------------- | :---------------------------------- |
| **Target Device** | Raspberry Pi 3B (64-bit)            |
| **Frontend**      | Qt 6 / QML / C++                    |
| **Backend**       | GPIO Driver · IPC (vSomeIP planned) |
| **Build System**  | Yocto Project (meta-supra layer)    |

---

<p align="center"><b>🚀 Think of <code>main</code> as the clean base — other branches build the final Supra experience.</b></p>
