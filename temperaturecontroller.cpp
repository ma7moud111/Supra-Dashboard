#include "temperaturecontroller.h"
#include <QRandomGenerator>

TemperatureController::TemperatureController(QObject *parent)
    : QObject(parent),
    m_temperature(0),  // Start cold
    m_engineOn(false)
{
    connect(&m_timer, &QTimer::timeout, this, &TemperatureController::updateTemperature);
    m_timer.start(500);  // Update every 0.5 seconds
}

int TemperatureController::temperature() const
{
    return m_temperature;
}

void TemperatureController::setEngineOn(bool on)
{
    m_engineOn = on;
}

void TemperatureController::updateTemperature()
{
    if (m_engineOn) {
        // Warm up gradually until around 90°C
        if (m_temperature < 90) {
            // Random small increase (1–2°C)
            int increase = QRandomGenerator::global()->bounded(1, 3);
            m_temperature += increase;
        } else if (m_temperature < 110) {
            // Simulate small temperature oscillations near normal range
            int delta = QRandomGenerator::global()->bounded(-1, 2);
            m_temperature = qBound(90, m_temperature + delta, 110);
        }
    } else {
        // Cool down slowly toward ambient (around 0–10°C)
        if (m_temperature > 10) {
            m_temperature -= 1;
        }
    }

    emit temperatureChanged(m_temperature);
}
