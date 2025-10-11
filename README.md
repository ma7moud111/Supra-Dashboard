# Supra Dashboard — Main Branch

A Raspberry Pi 3B (64-bit) car dashboard with a **Qt** front end.
This branch is the **base** of the project. It includes the dashboard UI code and a simple layout for the rest of the repo.

---

## What’s inside

* **`qt-app/`** — the main **Qt/QML/C++** app with **3 gauges**:

  * **RPM**
  * **Speed**
  * **Temperature**
    (Open this folder to see code, assets, and build notes.)
* **`meta-supra/`** — light setup used by other branches.
* **`docs/`** — space for screenshots and notes.

> This branch is meant to be clear and simple. The full image and services are finished on other branches.

---

## The Dashboard (Qt)

* Full-screen layout made for RPi.
* **Three gauges**:

  * **RPM** — smooth needle
  * **Speed** — easy to read
  * **Temperature** — shows safe/alert ranges
* Built with **Qt/QML** so it’s fast and easy to extend.

Everything for the UI lives in **`qt-app/`**. Don’t skip it.

---

## Quick start

### Run on your PC

1. Open **Qt Creator**.
2. **Open Project** → select **`qt-app/`**.
3. Build and run.
4. Make the window full screen to see the layout.

### Run on Raspberry Pi 3B (64-bit)

1. Build or copy the app from **`qt-app/`**.
2. Deploy to the Pi.
3. Run the app (prefer full screen).

> The “flash-and-run” image comes from the `production` branch after merge.

---

## Repo map

```
Supra-Dashboard/
├─ qt-app/            # Qt/QML/C++ dashboard
├─ meta-supra/        # Used by other branches
└─ docs/              # Screenshots and notes
```

If you just want to **see the dashboard**, start with **`qt-app/`**.

---

## Branch guide

* **`main`** — you are here (base + UI code).
* **`qt-dev`** — final Qt app polish and behavior.
* **`metaz-dev`** — Yocto/meta layer (recipes, services).
* **`backend-dev`** — backend apps (sensor/IPC data).
* **`production`** — final image after merge.

Think of `main` as the **simple base and UI source**. The other branches make it a full product.

---

## Suggested workflow

1. Try the gauges in **`qt-app/`** on your PC.
2. Tweak UI in **`qt-dev`** (colors, layout, animations).
3. Add packaging and services in **`metaz-dev`**.
4. Hook up data in **`backend-dev`**.
5. Build the final image in **`production`**.

---

## Screens to add (optional)

* `docs/dashboard_overview.png` — full UI
* `docs/gauges_closeup.png` — RPM/Speed/Temp
* `docs/flow.png` — **Backend → IPC → Qt UI**

---

## Contributing

* Keep `main` clean and easy to read.
* UI/code that helps newcomers can live here.
* Bigger changes should go to `qt-dev` or `metaz-dev`.

---

## Notes

* Target: **Raspberry Pi 3B (64-bit)**
* Tech: **Qt/QML/C++**
* Yocto: **Metaz/recipes**