#ifndef GPIOCONTROLLER_H
#define GPIOCONTROLLER_H

#include <QObject>
#include <QTimer>

class GpioController : public QObject {
    Q_OBJECT

public:
    explicit GpioController(QObject *parent = nullptr);
    ~GpioController();

    void init();
    void cleanup();

signals:
    void engineButtonPressed();
    void accelButtonPressed();
    void brakeButtonPressed();
    void leftSignalButtonPressed();
    void rightSignalButtonPressed();

public slots:
    void updateInputs();
    void handleLeftSignal(bool on);
    void handleRightSignal(bool on);

private:
    void exportGpio(int pin);
    void unexportGpio(int pin);
    void setDirection(int pin, const std::string &direction);
    int readGpioValue(int pin);
    void writeGpioValue(int pin, int value);

    const int ENGINE_BTN = 26;
    const int ACCEL_BTN  = 13;
    const int BRAKE_BTN  = 19;
    const int LEFT_BTN   = 6;
    const int RIGHT_BTN  = 5;

    const int LEFT_LED   = 23;
    const int RIGHT_LED  = 24;

    int lastEngineState = 1;
    int lastAccelState  = 1;
    int lastBrakeState  = 1;
    int lastLeftState   = 1;
    int lastRightState  = 1;

    QTimer m_pollTimer;
};

#endif // GPIOCONTROLLER_H
