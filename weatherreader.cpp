#include "weatherreader.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>

WeatherReader::WeatherReader(QObject *parent)
    : QObject(parent)
{
    connect(&m_timer, &QTimer::timeout, this, &WeatherReader::readFile);
    m_timer.start(1000); // read every second
}

void WeatherReader::readFile()
{
    QFile file("/home/weston/data.csv");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Cannot open /home/weston/data.csv";
        return;
    }

    QTextStream in(&file);
    QString line = in.readLine().trimmed();
    file.close();

    if (line.isEmpty())
        return;

    // Example: pot,984,servo,166,temp,30
    QStringList parts = line.split(",");
    if (parts.size() < 6)
        return;

    bool ok = false;
    double tempValue = 0.0;

    for (int i = 0; i < parts.size() - 1; ++i) {
        if (parts[i] == "temp" && i + 1 < parts.size()) {
            tempValue = parts[i + 1].toDouble(&ok);
            break;
        }
    }

    if (ok && tempValue != m_lastTemp) {
        m_lastTemp = tempValue;
        emit temperatureUpdated(tempValue);
    }
}
