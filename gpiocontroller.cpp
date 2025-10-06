// gpiocontroller.cpp (new file)
#include "gpiocontroller.h"
#include "dashboardcontroller.h"
#include "speedcontroller.h"

#include <QFile>
#include <QTextStream>
#include <QTimer>
#include <QDebug>

GpioController::GpioController(DashboardController *dc, SpeedController *sc, QObject *parent)
    : QObject(parent), m_dc(dc), m_sc(sc) {
    // Export GPIOs
    exportGpio(ENGINE_BUTTON_PIN);
    exportGpio(ACCEL_BUTTON_PIN);
    exportGpio(BRAKE_BUTTON_PIN);
    exportGpio(LEFT_SIGNAL_BUTTON_PIN);
    exportGpio(RIGHT_SIGNAL_BUTTON_PIN);
    exportGpio(LEFT_LED_PIN);
    exportGpio(RIGHT_LED_PIN);

    // Set directions
    setDirection(ENGINE_BUTTON_PIN, "in");
    setDirection(ACCEL_BUTTON_PIN, "in");
    setDirection(BRAKE_BUTTON_PIN, "in");
    setDirection(LEFT_SIGNAL_BUTTON_PIN, "in");
    setDirection(RIGHT_SIGNAL_BUTTON_PIN, "in");
    setDirection(LEFT_LED_PIN, "out");
    setDirection(RIGHT_LED_PIN, "out");

    // Initial LED states
    writeGpio(LEFT_LED_PIN, 0);
    writeGpio(RIGHT_LED_PIN, 0);

    // Connect signals for physical LEDs
    connect(m_dc, &DashboardController::leftSignalOnChanged, [this](bool on) {
        writeGpio(LEFT_LED_PIN, on ? 1 : 0);
    });
    connect(m_dc, &DashboardController::rightSignalOnChanged, [this](bool on) {
        writeGpio(RIGHT_LED_PIN, on ? 1 : 0);
    });

    // Poll timer for buttons
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &GpioController::pollButtons);
    timer->start(50);

    // Initial button states (assuming active low with pull-up)
    m_prevEngine = readGpio(ENGINE_BUTTON_PIN);
    m_prevAccel = readGpio(ACCEL_BUTTON_PIN);
    m_prevBrake = readGpio(BRAKE_BUTTON_PIN);
    m_prevLeftSig = readGpio(LEFT_SIGNAL_BUTTON_PIN);
    m_prevRightSig = readGpio(RIGHT_SIGNAL_BUTTON_PIN);
}

void GpioController::pollButtons() {
    // Engine toggle on falling edge
    int currEngine = readGpio(ENGINE_BUTTON_PIN);
    if (currEngine == 0 && m_prevEngine == 1) {
        m_dc->setEngineOn(!m_dc->engineOn());
    }
    m_prevEngine = currEngine;

    // Accelerate on press (falling), stop on release (rising)
    int currAccel = readGpio(ACCEL_BUTTON_PIN);
    if (currAccel == 0 && m_prevAccel == 1) {
        m_sc->startAcceleration();
    } else if (currAccel == 1 && m_prevAccel == 0) {
        m_sc->stopAcceleration();
    }
    m_prevAccel = currAccel;

    // Brake on press (falling), stop on release (rising)
    int currBrake = readGpio(BRAKE_BUTTON_PIN);
    if (currBrake == 0 && m_prevBrake == 1) {
        m_sc->startBraking();
    } else if (currBrake == 1 && m_prevBrake == 0) {
        m_sc->stopBraking();
    }
    m_prevBrake = currBrake;

    // Left signal toggle on falling edge
    int currLeft = readGpio(LEFT_SIGNAL_BUTTON_PIN);
    if (currLeft == 0 && m_prevLeftSig == 1) {
        m_dc->toggleLeftSignal();
    }
    m_prevLeftSig = currLeft;

    // Right signal toggle on falling edge
    int currRight = readGpio(RIGHT_SIGNAL_BUTTON_PIN);
    if (currRight == 0 && m_prevRightSig == 1) {
        m_dc->toggleRightSignal();
    }
    m_prevRightSig = currRight;
}

void GpioController::exportGpio(int pin) {
    QFile file("/sys/class/gpio/export");
    if (file.open(QIODevice::WriteOnly)) {
        QTextStream out(&file);
        out << pin;
        file.close();
    } else {
        qDebug() << "Failed to export GPIO" << pin;
    }
}

void GpioController::setDirection(int pin, const QString &dir) {
    QFile file(QString("/sys/class/gpio/gpio%1/direction").arg(pin));
    if (file.open(QIODevice::WriteOnly)) {
        QTextStream out(&file);
        out << dir;
        file.close();
    } else {
        qDebug() << "Failed to set direction for GPIO" << pin;
    }
}

int GpioController::readGpio(int pin) {
    QFile file(QString("/sys/class/gpio/gpio%1/value").arg(pin));
    if (file.open(QIODevice::ReadOnly)) {
        QTextStream in(&file);
        QString val;
        in >> val;
        file.close();
        return val.toInt();
    } else {
        qDebug() << "Failed to read GPIO" << pin;
        return -1;
    }
}

void GpioController::writeGpio(int pin, int val) {
    QFile file(QString("/sys/class/gpio/gpio%1/value").arg(pin));
    if (file.open(QIODevice::WriteOnly)) {
        QTextStream out(&file);
        out << val;
        file.close();
    } else {
        qDebug() << "Failed to write to GPIO" << pin;
    }
}
