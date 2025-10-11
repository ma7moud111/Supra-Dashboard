# Supra Dashboard — **backend-dev**

Backend apps that talk to real hardware and feed the **Qt dashboard**.

**Folders in this branch**

* `arduino_control`
* `buttons_control`
* `gpio_driver`
* `servo_temp_control`  ([GitHub][1])

These apps are small and focused. You can run them alone, or together, depending on your setup.

---

## Big picture

```
[Hardware: Buttons / Servo / Temp sensor / Arduino]
                │
                ▼
   [backend-dev apps write/read data or GPIO]
                │
     CSV (/home/weston/data.csv) ──► FileSeatReader (Qt)
           or direct GPIO actions  └─► Visible effects (LEDs, servo)
                │
                ▼
         Qt Dashboard (rpm/speed/temp, seat, GPIO)
```

The dashboard’s `FileSeatReader` (in Qt) can read live values from a CSV file like `/home/weston/data.csv`. These backend apps can write to that file (for the UI) and/or touch GPIO directly for LEDs/relays.

---

## Common settings (all apps)

* **Target**: Raspberry Pi 3B (64-bit)
* **GPIO**: Linux sysfs (`/sys/class/gpio/...`) for simple pin read/write
* **CSV path** (if used): `/home/weston/data.csv` (same default the Qt app expects)
* **Run mode**: simulation (timers/constant values) or real pins/sensors

> Tip: Always share **GND** between Pi, Arduino, and any external modules.

---

## 1) `gpio_driver` — low-level GPIO helper

**What it does**

* Small helper that **exports pins**, sets **direction** (in/out), and **reads/writes** GPIO values via sysfs.
* Other apps use this instead of duplicating GPIO code.

**Inputs / Outputs**

* **Input**: pin number, mode (in/out), value (0/1)
* **Output**: pin value (when reading) or side-effect (set pin high/low)

**How the UI benefits**

* Used by other backends to light LEDs, read switches, or trigger relays that reflect states shown in the UI.

**Example usage (concept)**

```bash
# Set GPIO 17 as output and turn it on
echo 17 | sudo tee /sys/class/gpiomod/export
echo out | sudo tee /sys/class/gpiomod/gpio17/direction
echo 1 | sudo tee /sys/class/gpiomod/gpio17/value
```

(Your helper wraps the above in code.)

---

## 2) `buttons_control` — read physical buttons / switches

**What it does**

* Polls one or more **GPIO inputs** (e.g., seat forward/back, mode buttons).
* Optional **debounce** (ignore noise).
* Can write **events** or **positions** to the CSV so the Qt app shows changes, or it can directly toggle GPIO outputs (LEDs) via `gpio_driver`.

**Inputs / Outputs**

* **Input**: GPIO pins for buttons
* **Output**:

  * CSV updates (e.g., `timestamp,seatX,seatY`) if feeding the UI
  * or GPIO output changes (LED on/off) for quick feedback

**How the UI benefits**

* When a button is pressed, the dashboard can update **seat position**, toggle **modes**, or show **status**.

**Run (example)**

```bash
# Example: poll every 50 ms, two input pins, write CSV
./buttons_control --pins 17,27 --poll 50 --csv /home/weston/data.csv
```

---

## 3) `servo_temp_control` — move a servo based on temperature

**What it does**

* Reads a **temperature source** (CPU temp file or an external sensor you choose) and maps it to a **servo angle**.
* Outputs a **PWM signal** on a GPIO pin to move the servo (fan flap, gauge needle, or demo mechanism).
* Can also **log temperature** to CSV so the Qt **Temperature gauge** moves in sync.

**Inputs / Outputs**

* **Input**: temp input path (e.g., `/sys/class/thermal/thermal_zone0/temp`) or a sensor reader
* **Output**: PWM on a **servo pin**, optional CSV (`timestamp,temp`)

**How the UI benefits**

* The dashboard temperature gauge shows the same values written by this app.
* You can demo “real world → UI” feedback easily.

**Run (example)**

```bash
# Map 40°C→0°, 90°C→180°, write UI CSV too
./servo_temp_control --temp-path /sys/class/thermal/thermal_zone0/temp \
                     --servo-pin 18 --min 40 --max 90 \
                     --csv /home/weston/data.csv
```

> If you use an external servo driver (PCA9685, etc.), point the app to that backend or stub.

---

## 4) `arduino_control` — talk to an Arduino over serial

**What it does**

* Opens `/dev/ttyACM0` (typical for Arduino Uno/Nano/Leonardo) at a **baud** you set.
* Sends simple **commands** (e.g., set LED, move servo to `X,Y`).
* Can **read sensor lines** from the Arduino and **append** them to `/home/weston/data.csv` for the Qt app.

**Simple protocol (example)**

```
# PC → Arduino
LED,1
SEAT,120,45

# Arduino → PC
SEAT,118,44
TEMP,72
```

**How the UI benefits**

* Real hardware (potentiometers, sensors) on the Arduino becomes **live data** in the dashboard via the CSV.

**Run (example)**

```bash
./arduino_control --port /dev/ttyACM0 --baud 115200 --csv /home/weston/data.csv
```

---

## How the Qt app sees the data

Your Qt app registers controllers in QML and reads live values. The **FileSeatReader** watches the CSV (default `/home/weston/data.csv`) and emits signals that update gauges/UI bindings (e.g., seat X/Y, temperature). You already use this pattern in the Qt side; these backends just **supply** the data stream.

---

## Build & run (quick patterns)

> Your directories may include their own build files. Use those if present. If not, these generic patterns work for small C++ tools.

**CMake (recommended)**

```bash
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . -j
```

**Single-file g++ (fallback)**

```bash
g++ -O2 -std=c++17 -o buttons_control buttons_control.cpp
g++ -O2 -std=c++17 -o servo_temp_control servo_temp_control.cpp
g++ -O2 -std=c++17 -o arduino_control  arduino_control.cpp
g++ -O2 -std=c++17 -o gpio_driver_test gpio_driver_test.cpp
```

---

## Run them as services (systemd)

Create a service per app so it starts on boot:

```ini
# /etc/systemd/system/buttons_control.service
[Unit]
Description=Buttons Control

[Service]
ExecStart=/usr/bin/buttons_control --pins 17,27 --poll 50 --csv /home/weston/data.csv
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl enable buttons_control
sudo systemctl start  buttons_control
journalctl -u buttons_control -f
```

> Your **`metaz-dev`** layer will carry the BitBake recipes and units when you’re ready to package them into `core-image-supra`.

---

## Pin notes (RPi 3B)

* Use **BCM numbering** in code (not physical header numbers).
* Common examples:

  * GPIO **17/27/22** = inputs (buttons)
  * GPIO **18** = PWM/servo (hardware PWM capable)
* Keep servo power off the Pi’s 3.3V; use **5V + external supply** if needed; tie grounds.

---

## Logs & CSV shape

* CSV is simple, append-only. Keep columns stable so the Qt side parses easily.
* Examples:

  * `timestamp,seatX,seatY`
  * `timestamp,tempC`
  * `timestamp,buttonA,buttonB`
* Use **Unix epoch ms** for `timestamp` if you need ordering across apps.

---

## Future (FYI)

* There’s a **`meta-supra-commonapi`** layer in `metaz-dev` planned for **SOME/IP**. Later, these backends can publish data over CommonAPI/vSomeIP instead of CSV files for tighter, service-based IPC (not enabled now). ([GitHub][2])

---

## What we confirmed vs. inferred

* Confirmed from repo: this branch contains **`arduino_control`**, **`buttons_control`**, **`gpio_driver`**, **`servo_temp_control`**. ([GitHub][1])
* The behaviors above follow your earlier architecture (CSV to `FileSeatReader`, GPIO via sysfs) and the folder names. If any app already has different flags/pins/paths, keep those, and just tweak the README examples.

--

[1]: https://github.com/ma7moud111/Supra-Dashboard/tree/backend-dev "GitHub - ma7moud111/Supra-Dashboard at backend-dev"
[2]: https://github.com/ma7moud111/Supra-Dashboard/branches "Branches · ma7moud111/Supra-Dashboard · GitHub"
