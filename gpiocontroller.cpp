#include "gpiocontroller.h"
#include "dashboardcontroller.h"
#include "speedcontroller.h"

#include <QFile>
#include <QTextStream>
#include <QThread>
#include <QTimer>
#include <QDebug>

GpioController::GpioController(DashboardController *dc, SpeedController *sc, QObject *parent)
    : QObject(parent), m_dc(dc), m_sc(sc) {
    // List of pins to configure
    const int pins[] = {ENGINE_BUTTON_PIN, ACCEL_BUTTON_PIN, BRAKE_BUTTON_PIN,
                        LEFT_SIGNAL_BUTTON_PIN, RIGHT_SIGNAL_BUTTON_PIN,
                        LEFT_LED_PIN, RIGHT_LED_PIN};
    const int pinCount = sizeof(pins) / sizeof(pins[0]);

    // Attempt to export and configure all pins
    for (int i = 0; i < pinCount; ++i) {
        exportGpio(pins[i]);
        if (i < 5) { // Buttons are inputs
            setDirection(pins[i], "in");
        } else { // LEDs are outputs
            setDirection(pins[i], "out");
        }
    }

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
    const int maxRetries = 3;
    for (int attempt = 0; attempt < maxRetries; ++attempt) {
        QFile file("/sys/class/gpio/export");
        if (file.open(QIODevice::WriteOnly)) {
            QTextStream out(&file);
            out << pin;
            file.close();
            qDebug() << "Successfully exported GPIO" << pin;
            return;
        } else {
            qDebug() << "Failed to export GPIO" << pin << "on attempt" << attempt + 1
                     << "- Error:" << file.errorString();
            if (attempt < maxRetries - 1) {
                QThread::msleep(100); // Wait before retrying
            }
        }
    }
    qWarning() << "Failed to export GPIO" << pin << "after" << maxRetries << "attempts";
}

void GpioController::setDirection(int pin, const QString &dir) {
    QFile file(QString("/sys/class/gpio/gpio%1/direction").arg(pin));
    if (file.open(QIODevice::WriteOnly)) {
        QTextStream out(&file);
        out << dir;
        file.close();
        qDebug() << "Set direction for GPIO" << pin << "to" << dir;
    } else {
        qDebug() << "Failed to set direction for GPIO" << pin << "- Error:" << file.errorString();
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
        qDebug() << "Failed to read GPIO" << pin << "- Error:" << file.errorString();
        return -1;
    }
}

void GpioController::writeGpio(int pin, int val) {
    QFile file(QString("/sys/class/gpio/gpio%1/value").arg(pin));
    if (file.open(QIODevice::WriteOnly)) {
        QTextStream out(&file);
        out << val;
        file.close();
        qDebug() << "Wrote" << val << "to GPIO" << pin;
    } else {
        qDebug() << "Failed to write to GPIO" << pin << "- Error:" << file.errorString();
    }
}
