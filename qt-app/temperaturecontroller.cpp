#include "temperaturecontroller.h"

TemperatureController::TemperatureController(QObject *parent)
    : QObject(parent),
    m_temperature(60), // initial temperature
    m_engineOn(false)
{
    m_updateTimer.setInterval(500); // update every 0.5s

    connect(&m_updateTimer, &QTimer::timeout, this, [this]() {
        if (m_engineOn) {
            if (m_temperature < 110)
                m_temperature += 1;  // warm up gradually
        } else {
            if (m_temperature > 60)
                m_temperature -= 1;  // cool down gradually
        }
        emit temperatureChanged(m_temperature);
    });
}

int TemperatureController::temperature() const {
    return m_temperature;
}

void TemperatureController::setEngineOn(bool on)
{
    m_engineOn = on;
    if (on && !m_updateTimer.isActive())
        m_updateTimer.start();
    else if (!on && !m_updateTimer.isActive())
        m_updateTimer.start(); // keep cooling updates running
}
