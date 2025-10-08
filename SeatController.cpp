#include "SeatController.h"

SeatController::SeatController(QObject *parent)
    : QObject(parent),
    m_seatPosition(0),
    m_seatBackAngle(0),
    m_direction(0)
{
    connect(&m_timer, &QTimer::timeout, this, &SeatController::updateSeatPosition);
    m_timer.setInterval(50);
}

void SeatController::startForward()
{
    m_direction = 1;
    m_timer.start();
}

void SeatController::startBackward()
{
    m_direction = -1;
    m_timer.start();
}

void SeatController::stopForward()
{
    m_timer.stop();
}

void SeatController::stopBackward()
{
    m_timer.stop();
}

void SeatController::updateSeatPosition()
{
    qreal newAngle = m_seatBackAngle + m_direction * 2;  // 2 degrees per step

    // Clamp the recline angle between 0° and 35°
    if (newAngle < 0)
        newAngle = 0;
    else if (newAngle > 35)
        newAngle = 35;

    if (!qFuzzyCompare(newAngle, m_seatBackAngle)) {
        m_seatBackAngle = newAngle;
        emit seatBackAngleChanged(m_seatBackAngle);
    }
}

void SeatController::setSeatBackAngleFromSensor(int angle)
{
    // Clamp and apply smoothing (to prevent jumpy seat motion)
    qreal targetAngle = qBound(0.0, static_cast<qreal>(angle), 45.0);

    // Optional smoothing: interpolate toward target
    qreal smoothedAngle = m_seatBackAngle + (targetAngle - m_seatBackAngle) * 0.2;

    if (!qFuzzyCompare(smoothedAngle, m_seatBackAngle)) {
        m_seatBackAngle = smoothedAngle;
        emit seatBackAngleChanged(m_seatBackAngle);
    }
}
