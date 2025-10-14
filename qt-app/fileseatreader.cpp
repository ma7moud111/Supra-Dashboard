#include "fileseatreader.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>

FileSeatReader::FileSeatReader(QObject *parent)
    : QObject(parent)
{
    // Poll every 200 ms
    connect(&m_pollTimer, &QTimer::timeout, this, &FileSeatReader::readSeatValue);
    m_pollTimer.start(200);
}

void FileSeatReader::readSeatValue()
{
    QFile file(m_filePath);
    if (!file.exists()) {
        qWarning() << "Seat data file not found at" << m_filePath;
        return;
    }

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Failed to open" << m_filePath;
        return;
    }

    QTextStream in(&file);
    QString line = in.readLine();
    file.close();

    if (line.isEmpty()) {
        qWarning() << "Seat data file is empty";
        return;
    }

    // Example: "pot,984,servo,166,temp,30"
    QStringList parts = line.split(',', Qt::SkipEmptyParts);
    int potValue = -1;

    for (int i = 0; i < parts.size(); ++i) {
        if (parts[i].trimmed() == "pot" && i + 1 < parts.size()) {
            potValue = parts[i + 1].trimmed().toInt();
            break;
        }
    }

    if (potValue < 0)
        return;

    // Map potentiometer value (0–1023) to seat angle (0–45°)
    int angle = static_cast<int>((potValue / 1023.0) * 45.0);

    emit seatAngleReceived(angle);
}
