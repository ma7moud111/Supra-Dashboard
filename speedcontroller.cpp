#include "speedcontroller.h"
#include <QtMath>

SpeedController::SpeedController(QObject *parent)
    : QObject(parent),
    m_speed(0),
    m_accelFactor(0.0),
    m_brakeFactor(0.0),
    accelerating(false),
    braking(false),
    coasting(false),
    m_updateTimer(new QTimer(this))
{
    m_updateTimer->setInterval(100); // Update every 100 ms

    connect(m_updateTimer, &QTimer::timeout, this, [this]() {
        if (!engineRunning) {
            // Immediately stop when engine is off
            if (m_speed != 0) {
                m_speed = 0;
                emit speedChanged(m_speed);
            }
            return;
        }

        if (accelerating && m_speed < 180) {
            m_accelFactor = qMin(m_accelFactor + 0.1, 3.0);
            m_speed += qRound(1 + m_accelFactor);
            if (m_speed > 180) m_speed = 180;
            emit speedChanged(m_speed);
        } else if (braking && m_speed > 0) {
            m_brakeFactor = qMin(m_brakeFactor + 0.2, 4.0);
            m_speed -= qRound(2 + m_brakeFactor);
            if (m_speed < 0) m_speed = 0;
            emit speedChanged(m_speed);
        } else if (coasting && m_speed > 0) {
            m_speed -= 1;
            if (m_speed < 0) m_speed = 0;
            emit speedChanged(m_speed);
        } else if (!accelerating && !braking && !coasting) {
            if (m_speed == 0 || m_speed == 180)
                m_updateTimer->stop();
        }
    });
}

int SpeedController::speed() const {
    return m_speed;
}

void SpeedController::setEngineRunning(bool running) {
    engineRunning = running;
    if (!engineRunning) {
        // Reset everything when engine stops
        m_speed = 0;
        accelerating = braking = coasting = false;
        emit speedChanged(m_speed);
    }
}

void SpeedController::startAcceleration() {
    if (!engineRunning)
        return;
    accelerating = true;
    braking = false;
    coasting = false;
    m_accelFactor = 0.0;
    if (!m_updateTimer->isActive())
        m_updateTimer->start();
}

void SpeedController::stopAcceleration() {
    if (!engineRunning)
        return;
    accelerating = false;
    coasting = true;
    m_accelFactor = 0.0;
    if (!m_updateTimer->isActive())
        m_updateTimer->start();
}

void SpeedController::startBraking() {
    if (!engineRunning)
        return;
    braking = true;
    accelerating = false;
    coasting = false;
    m_brakeFactor = 0.0;
    if (!m_updateTimer->isActive())
        m_updateTimer->start();
}

void SpeedController::stopBraking() {
    braking = false;
    m_brakeFactor = 0.0;
    if (!accelerating && !coasting)
        m_updateTimer->stop();
}
