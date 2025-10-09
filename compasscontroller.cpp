#include "compasscontroller.h"
#include <QRandomGenerator>

CompassController::CompassController(QObject *parent)
    : QObject(parent), m_heading(0.0)
{
    connect(&m_timer, &QTimer::timeout, this, &CompassController::updateHeading);
    m_timer.start(1000); // update every second
}

double CompassController::heading() const
{
    return m_heading;
}

void CompassController::updateHeading()
{
    // Simulate random heading change for demo
    m_heading = static_cast<double>(QRandomGenerator::global()->bounded(0, 360));
    emit headingChanged(m_heading);
}
