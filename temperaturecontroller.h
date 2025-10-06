#ifndef TEMPERATURECONTROLLER_H
#define TEMPERATURECONTROLLER_H

#include <QObject>
#include <QTimer>

class TemperatureController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int temperature READ temperature NOTIFY temperatureChanged)

public:
    explicit TemperatureController(QObject *parent = nullptr);

    int temperature() const;

public slots:
    void setEngineOn(bool on);

signals:
    void temperatureChanged(int temperature);

private:
    int m_temperature;      // degrees Celsius
    bool m_engineOn;
    QTimer m_updateTimer;
};

#endif // TEMPERATURECONTROLLER_H
