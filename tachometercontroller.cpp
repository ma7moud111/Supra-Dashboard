#include "tachometercontroller.h"
#include <QtMath>

TachometerController::TachometerController(QObject *parent)
    : QObject(parent), m_rpm(0)
{
}

int TachometerController::rpm() const
{
    return m_rpm;
}

void TachometerController::updateRpm(int speed, bool engineOn)
{
    int newRpm = 0;

    if (engineOn) {
        // Base idle RPM
        newRpm = 800 + static_cast<int>(speed * 50);

        // Cap RPM
        if (newRpm > 7000)
            newRpm = 7000;
    }

    if (m_rpm != newRpm) {
        m_rpm = newRpm;
        emit rpmChanged(m_rpm);
    }
}
