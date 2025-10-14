# 🚗 Supra Dashboard — `production` Branch

> 🎯 **Final integrated build** of the Supra Dashboard — combining the **Qt/QML application**, **backend controllers**, and **Yocto-based embedded system** for **Raspberry Pi 3B (64-bit)**.
> This is the **release branch** that merges everything from `qt-dev`, `backend-dev`, and `metaz-dev` into a complete, flash-ready system image.

---

<p align="center">
  <img src="https://img.shields.io/badge/Qt-6.7-brightgreen?logo=qt&logoColor=white">
  <img src="https://img.shields.io/badge/Yocto-Kirkstone_LTS-blue?logo=yocto-project&logoColor=white">
  <img src="https://img.shields.io/badge/Platform-RaspberryPI3-red">
  <img src="https://img.shields.io/badge/UI-QML%20Frontend-lightgrey">
  <img src="https://img.shields.io/badge/Status-Production%20Ready-green">
</p>

---

## 🚀 Overview

The Supra Dashboard is a **car instrument cluster simulator** and real embedded dashboard featuring:

* **Speedometer** — Vehicle speed display
* **Tachometer** — Engine RPM indicator
* **Temperature Gauge** — Engine/cabin temperature
* **Seat Position Controller** — Reads from CSV or sensor input
* **GPIO Controller** — Interacts with Raspberry Pi pins or LEDs
* **Dashboard Orchestrator** — Central C++ controller
* **FileSeatReader** — Streams live sensor data from `/home/weston/data.csv`

It can run both on **desktop (simulation)** and **Raspberry Pi (real hardware)** via Yocto integration.

---

## 🧩 System Architecture

```
+-----------------------------------------------------------+
|                     QML Frontend (UI)                     |
|-----------------------------------------------------------|
| SpeedometerView.qml   TachometerView.qml   TempView.qml   |
| - Gauges, animations, bindings via Q_PROPERTY             |
+-----------------------------------------------------------+
|                    C++ Backend (Logic)                    |
|-----------------------------------------------------------|
| SpeedController     TachometerController   SeatController |
| TemperatureController  GpioController  DashboardController |
| FileSeatReader (CSV or sensor data)                       |
+-----------------------------------------------------------+
|                   Data Sources / Hardware                 |
|-----------------------------------------------------------|
|  - /home/weston/data.csv                                  |
|  - GPIO (LEDs, switches)                                  |
|  - UART / QTimer simulations                              |
+-----------------------------------------------------------+
```

Each controller handles one domain.
`DashboardController` connects all sub-modules into one orchestrated system.

---

## ⚙️ Application Flow (main.cpp)

```cpp
QGuiApplication app(argc, argv);
QQmlApplicationEngine engine;

// Controllers
SpeedController speed;
TachometerController tachometer;
TemperatureController temp;
SeatController seat;
GpioController gpio;
DashboardController dashboard;
FileSeatReader fileReader;

// Expose to QML
engine.rootContext()->setContextProperty("speedController", &speed);
engine.rootContext()->setContextProperty("tachometerController", &tachometer);
engine.rootContext()->setContextProperty("temperatureController", &temp);
engine.rootContext()->setContextProperty("seatController", &seat);
engine.rootContext()->setContextProperty("gpioController", &gpio);

// Load QML
engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
return app.exec();
```

---

## 🔧 Core Controllers

| Controller                | Purpose                                       |
| ------------------------- | --------------------------------------------- |
| **SpeedController**       | Simulates vehicle speed using QTimer          |
| **TachometerController**  | Manages RPM value and needle animation        |
| **TemperatureController** | Simulates or reads engine temperature         |
| **SeatController**        | Controls and animates seat position           |
| **GpioController**        | Writes/reads physical Raspberry Pi GPIOs      |
| **DashboardController**   | Central logic hub; updates all subsystems     |
| **FileSeatReader**        | Reads `/home/weston/data.csv` for live inputs |

**Example (SpeedController):**

```cpp
void SpeedController::updateSpeed() {
    m_speed = qMin(m_speed + 5, 240);
    emit speedChanged(m_speed);
}
```

**Example (GPIO Write):**

```cpp
void GpioController::writeGpio(int pin, int value) {
    std::ofstream fs("/sys/class/gpio/gpio" + std::to_string(pin) + "/value");
    fs << value;
}
```

---

## 🎨 QML UI Example

```qml
Rectangle {
    width: 300; height: 300
    Image { source: "tachometer_dial.png" }
    Image {
        id: needle
        source: "needle.png"
        anchors.centerIn: parent
        rotation: tachometerController.rpm / 8000 * 270
        Behavior on rotation { NumberAnimation { duration: 200 } }
    }
    Text {
        anchors.bottom: parent.bottom
        text: tachometerController.rpm + " RPM"
    }
}
```

> Bound via `Q_PROPERTY` to the backend — fully reactive gauges and animations.

---

## 🔄 Data Flow Example

1. `QTimer` in `SpeedController` ticks → emits `speedChanged()`
2. QML gauge updates needle position
3. `DashboardController` syncs RPM and temperature
4. `FileSeatReader` updates seat data → `SeatController` updates UI
5. `GpioController` toggles LED based on state

---

## 🧠 Key Qt Concepts

| Concept           | Use                          |
| :---------------- | :--------------------------- |
| `Q_PROPERTY`      | Bind C++ data to QML UI      |
| `signals/slots`   | Real-time updates            |
| `QQmlContext`     | Expose controllers to QML    |
| `QTimer`          | Simulation tick events       |
| `std::ifstream`   | Efficient CSV parsing        |
| `QGuiApplication` | Lightweight Qt 6 GUI runtime |

---

## 💡 Enhancements Roadmap

* Add **Fuel & Battery gauges**
* Real sensor input via **CAN Bus** or UART
* Historical graphing in QML
* **Warning lights** over GPIO
* **Unit settings** (km/h ↔ mph) in QML menu

---

## 🧱 Yocto Integration

This final branch embeds the Qt app and services into the Yocto image.
Uses recipes from `meta-supra` (`metaz-dev`) and systemd units for auto-start.

**Example Service**

```bash
[Unit]
Description=Supra Dashboard UI
After=weston.service

[Service]
ExecStart=/usr/bin/dashboard
Restart=always
User=weston

[Install]
WantedBy=multi-user.target
```

Built and packaged inside `core-image-supra.bb` in `meta-supra`.

---

## 🖼️ System Build Flow

<p align="center">
  <img src="https://github.com/user-attachments/assets/00000000928c62469534de4ee1123dc0" width="80%" alt="Build to Flash to Boot Diagram">
</p>

---

## ⚡ Build → Flash → Boot

```bash
# Build Yocto image
source poky/oe-init-build-env build-supra
bitbake core-image-supra

# Flash to SD
sudo bmaptool copy \
  tmp/deploy/images/raspberrypi3-64/core-image-supra-raspberrypi3-64.wic.gz /dev/sdX
```

Boot the Pi → systemd launches Weston + Dashboard automatically.

---

## 🧭 Access Summary

| Interface          | Command                              |
| :----------------- | :----------------------------------- |
| **Serial Console** | GPIO 14/15 @ 115200 baud             |
| **SSH**            | `ssh root@<ip>`                      |
| **UI Display**     | Weston (HDMI output)                 |
| **Logs**           | `journalctl -u dashboard.service -f` |

---

## 📦 Full Project Package

🎁 **Download the full working project here:**
👉 [Supra Dashboard — Production Build (Google Drive)](https://drive.google.com/file/d/1aEI9zduPqLGgKbfMTE7OlPWcKegxV7-0/view?usp=drive_link)

Includes:

* Source Code (C++ + QML)
* Yocto Layers (`meta-supra`, `meta-supra-commonapi`)
* Prebuilt Images + Services
* Deployment Guide

---

## 📚 References

* [Qt 6 Documentation](https://doc.qt.io/qt-6/)
* [Yocto Project Docs](https://docs.yoctoproject.org/)
* [Weston Compositor](https://wayland.freedesktop.org/weston/)
* [Raspberry Pi Yocto Layer](https://github.com/agherzan/meta-raspberrypi)
* [systemd Manual](https://www.freedesktop.org/wiki/Software/systemd/)

---

<p align="center"><b>🚗 The <code>production</code> branch delivers the complete embedded experience — from gauges to GPIO — running seamlessly on Raspberry Pi 3B.</b></p>
