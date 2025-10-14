#include "compasscontroller.h"
#include <QDebug>

CompassController::CompassController(QObject *parent)
    : QObject(parent), m_heading(0.0)
{
    // Update every second
    connect(&m_timer, &QTimer::timeout, this, &CompassController::updateHeading);
    m_timer.start(1000);
}

double CompassController::heading() const
{
    return m_heading;
}

void CompassController::updateHeading()
{
    QFile file(m_filePath);
    if (!file.exists()) {
        qWarning() << "[CompassController] File not found:" << m_filePath;
        return;
    }

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "[CompassController] Unable to open file:" << m_filePath;
        return;
    }

    QTextStream in(&file);
    QString line = in.readLine();
    file.close();

    if (line.isEmpty()) {
        qWarning() << "[CompassController] File is empty.";
        return;
    }

    //format: compass,angle,time,hour:min:sec
    QStringList tokens = line.split(',');
    if (tokens.size() < 4) {
        qWarning() << "[CompassController] Invalid line format:" << line;
        return;
    }

    bool ok = false;
    double angle = tokens[1].toDouble(&ok);

    if (ok && angle >= 0.0 && angle <= 360.0) {
        if (!qFuzzyCompare(angle, m_heading)) {
            m_heading = angle;
            emit headingChanged(m_heading);
            qDebug() << "[CompassController] Heading updated to:" << m_heading;
        }
    } else {
        qWarning() << "[CompassController] Invalid angle value:" << tokens[1];
    }
}
