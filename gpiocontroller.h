#ifndef GPIOCONTROLLER_H
#define GPIOCONTROLLER_H

#include <QObject>

class DashboardController;
class SpeedController;

constexpr int ENGINE_BUTTON_PIN = 17;
constexpr int ACCEL_BUTTON_PIN = 18;
constexpr int BRAKE_BUTTON_PIN = 27;
constexpr int LEFT_SIGNAL_BUTTON_PIN = 22;
constexpr int RIGHT_SIGNAL_BUTTON_PIN = 23;
constexpr int LEFT_LED_PIN = 24;
constexpr int RIGHT_LED_PIN = 25;

// constexpr int ENGINE_BUTTON_PIN = 5;
// constexpr int ACCEL_BUTTON_PIN = 6;
// constexpr int BRAKE_BUTTON_PIN = 13;
// constexpr int LEFT_SIGNAL_BUTTON_PIN = 19;
// constexpr int RIGHT_SIGNAL_BUTTON_PIN = 26;

// constexpr int LEFT_LED_PIN = 24;
// constexpr int RIGHT_LED_PIN = 25;


class GpioController : public QObject {
    Q_OBJECT
public:
    explicit GpioController(DashboardController *dc, SpeedController *sc, QObject *parent = nullptr);

private slots:
    void pollButtons();

private:
    void exportGpio(int pin);
    void setDirection(int pin, const QString &dir);
    int readGpio(int pin);
    void writeGpio(int pin, int val);

    DashboardController *m_dc;
    SpeedController *m_sc;

    int m_prevEngine;
    int m_prevAccel;
    int m_prevBrake;
    int m_prevLeftSig;
    int m_prevRightSig;
};

#endif // GPIOCONTROLLER_H
