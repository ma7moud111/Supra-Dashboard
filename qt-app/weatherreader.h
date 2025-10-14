#ifndef WEATHERREADER_H
#define WEATHERREADER_H

#include <QObject>
#include <QTimer>

class WeatherReader : public QObject
{
    Q_OBJECT

public:
    explicit WeatherReader(QObject *parent = nullptr);

signals:
    void temperatureUpdated(double temperature);

private slots:
    void readFile();

private:
    QTimer m_timer;
    double m_lastTemp = -999;
};

#endif // WEATHERREADER_H
