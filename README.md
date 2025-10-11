## 🚀 **Overview**

Our project is a **Car Dashboard (Instrument Cluster)** built using **C++ + Qt + QML**.
It simulates the car’s key dashboard functions such as:

* **Speedometer** (vehicle speed)
* **Tachometer** (engine RPM)
* **Temperature Gauge**
* **Seat Position Controller**
* **GPIO Controller** (to interact with physical Raspberry Pi pins or LEDs)
* **Dashboard Orchestrator** (main controller connecting all subsystems)
* **Data Reader** (`FileSeatReader`) that reads live sensor values from a file or real input

This can be run on a PC for simulation or on an **embedded target (like Raspberry Pi)** for real car hardware integration.

---

## 🧩 **Architecture Overview**

Here’s the system structure in layers:

```
+-----------------------------------------------------------+
|                    QML Frontend (UI)                      |
|-----------------------------------------------------------|
|   SpeedometerView.qml     TachometerView.qml     etc...   |
|   - Animations, gauges, needles, digital displays          |
|   - Communicates with C++ via Q_PROPERTY / signals         |
+-----------------------------------------------------------+
|                    C++ Backend (Controllers)              |
|-----------------------------------------------------------|
|  SpeedController        TachometerController              |
|  TemperatureController  SeatController                    |
|  GpioController         DashboardController               |
|  FileSeatReader (for input data)                           |
+-----------------------------------------------------------+
|                    Data Sources / Hardware                |
|-----------------------------------------------------------|
|  - CSV file (/home/weston/data.csv)                       |
|  - Physical GPIO (on RPi)                                 |
|  - Simulated timers (QTimer)                              |
+-----------------------------------------------------------+
```

Each controller handles **one domain**, and the **DashboardController** ties them together.

---

## ⚙️ **Main Application Flow**

### **`main.cpp`**

Here’s what happens step by step:

1. **Initialize Qt Application**

   ```cpp
   QGuiApplication app(argc, argv);
   QQmlApplicationEngine engine;
   ```

2. **Create Controllers**

   ```cpp
   SpeedController speedController;
   SeatController seatController;
   DashboardController dashboardController;
   TachometerController tachometerController;
   TemperatureController temperatureController;
   GpioController gpioController;
   FileSeatReader fileSeatReader;
   ```

3. **Expose to QML**

   ```cpp
   engine.rootContext()->setContextProperty("speedController", &speedController);
   engine.rootContext()->setContextProperty("tachometerController", &tachometerController);
   engine.rootContext()->setContextProperty("temperatureController", &temperatureController);
   engine.rootContext()->setContextProperty("seatController", &seatController);
   engine.rootContext()->setContextProperty("gpioController", &gpioController);
   ```

4. **Load the QML UI**

   ```cpp
   engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
   ```

5. **Start the Application**

   ```cpp
   return app.exec();
   ```

So the backend C++ objects are **registered in the QML context**, and the **UI can directly bind** to them via properties and signals.

---

## ⚡ **Main Controllers Explained**

### 🏎️ **SpeedController**

* Controls the **car’s current speed**.
* Uses a **QTimer** to simulate speed increase/decrease.
* Exposes a **Q_PROPERTY(int speed READ speed NOTIFY speedChanged)**.
* Can be connected to QML’s speedometer needle rotation.

**Example logic:**

```cpp
void SpeedController::updateSpeed() {
    m_speed = qMin(m_speed + 5, 240);
    emit speedChanged(m_speed);
}
```

### 🔧 **TachometerController**

* Handles **engine RPM** (revolutions per minute).
* Similar timer-based simulation.
* Q_PROPERTY exposes `rpm` value to QML.
* In QML, it animates the **needle** of the tachometer.

```cpp
void TachometerController::updateRPM() {
    m_rpm = (m_rpm + 100) % 8000;
    emit rpmChanged(m_rpm);
}
```

### 🌡️ **TemperatureController**

* Monitors engine or cabin temperature.
* Gradually increases with time (or input from a file).
* Emits `temperatureChanged()` signal.
* Connected to a **QML temperature gauge**.

### 💺 **SeatController**

* Controls **seat position** (e.g., forward/backward, up/down).
* Provides **setSeatPosition(x, y)** methods and `positionChanged` signals.
* Could receive data from **FileSeatReader** or **QML buttons**.
* Used for UI sliders or seat adjustment animations.

### ⚙️ **GpioController**

* Manages **real GPIO pins** (on Raspberry Pi or similar).
* Used for controlling external devices like **LEDs** or **relays**.
* Example actions:

  * Turn LED on/off
  * Read input from switches

It uses C++ file I/O on `/sys/class/gpio` (pure C++, not QFile) for performance.

```cpp
void GpioController::writeGpio(int pin, int value) {
    std::ofstream fs("/sys/class/gpio/gpio" + std::to_string(pin) + "/value");
    fs << value;
}
```

### 🧠 **DashboardController**

* Central orchestrator: coordinates between other controllers.
* Example: when speed increases, RPM and temperature also rise.
* Could also manage “modes” (e.g., eco/sport).

```cpp
void DashboardController::updateAll() {
    speedController->updateSpeed();
    tachometerController->updateRPM();
    temperatureController->updateTemperature();
}
```

### 📄 **FileSeatReader**

* Reads `/home/weston/data.csv` periodically.
* Parses sensor/seat data.
* Emits signals to update the SeatController.
* Uses **QTimer + std::ifstream**.

Example:

```
timestamp,seatX,seatY
0,10,15
1,12,18
...
```

```cpp
void FileSeatReader::readData() {
    std::ifstream file("/home/weston/data.csv");
    // Parse last line and emit seatDataRead(x, y)
}
```

---

## 🎨 **QML Layer**

The QML layer defines **the UI visuals and animations**, bound to the C++ backend.

### Example — Tachometer UI

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

---

## 🔄 **Data Flow Example**

Example sequence when running:

1. QTimer in `SpeedController` ticks every 500 ms.
2. `m_speed` increases → emits `speedChanged()`.
3. QML gauge bound to `speedController.speed` updates needle rotation.
4. DashboardController might adjust `TachometerController` and `TemperatureController` based on speed.
5. `GpioController` might blink an LED at high speed.
6. `FileSeatReader` updates seat data → signals `SeatController` → QML animates seat position.

---

## 🧱 **Typical Class Relationships**

```
DashboardController
 ├── SpeedController
 ├── TachometerController
 ├── TemperatureController
 ├── SeatController
 ├── GpioController
 └── FileSeatReader
```

Each subcontroller is modular, so you can replace or simulate them independently.

---

## 🧠 **Key Qt Concepts Used**

| Concept                             | Role in the Project                        |
| ----------------------------------- | ------------------------------------------ |
| **Q_PROPERTY**                      | Exposes C++ variables to QML bindings      |
| **signals/slots**                   | Event communication between backend and UI |
| **QTimer**                          | Periodic updates for simulation            |
| **QQmlApplicationEngine**           | Loads and runs the QML UI                  |
| **QQmlContext::setContextProperty** | Makes C++ controllers accessible to QML    |
| **std::ifstream / std::ofstream**   | Efficient file access for GPIO and CSV     |
| **QGuiApplication**                 | Main Qt app for QML GUIs                   |

---

## 💡 **Possible Enhancements**

* Add **fuel gauge** and **battery voltage** meters
* Integrate **real sensor data** over CAN bus or serial
* Store historical speed data and draw graphs
* Implement **warning lights** using GPIO
* Add **settings menu** in QML to toggle units (km/h, mph)

---