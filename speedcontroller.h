#ifndef SPEEDCONTROLLER_H
#define SPEEDCONTROLLER_H

#include <QObject>
#include <QTimer>

class SpeedController : public QObject {
    Q_OBJECT
    Q_PROPERTY(int speed READ speed NOTIFY speedChanged)

public:
    explicit SpeedController(QObject *parent = nullptr);

    int speed() const;
    void setEngineRunning(bool running);

    Q_INVOKABLE void startAcceleration();
    Q_INVOKABLE void stopAcceleration();
    Q_INVOKABLE void startBraking();
    Q_INVOKABLE void stopBraking();

signals:
    void speedChanged(int speed);

private:
    int m_speed;
    double m_accelFactor;
    double m_brakeFactor;
    bool accelerating;
    bool braking;
    bool coasting;
    bool engineRunning = false;
    QTimer *m_updateTimer;
};

#endif // SPEEDCONTROLLER_H
