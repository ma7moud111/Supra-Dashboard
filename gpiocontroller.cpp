#include "gpiocontroller.h"
#include <iostream>
#include <fstream>
#include <string>
#include <unistd.h>

using namespace std;

GpioController::GpioController(QObject *parent) : QObject(parent) {
    connect(&m_pollTimer, &QTimer::timeout, this, &GpioController::updateInputs);
    m_pollTimer.setInterval(100);
}

GpioController::~GpioController() {
    cleanup();
}

void GpioController::init() {
    int inputPins[] = {ENGINE_BTN, ACCEL_BTN, BRAKE_BTN, LEFT_BTN, RIGHT_BTN};
    int outputPins[] = {LEFT_LED, RIGHT_LED};

    for (int pin : inputPins) {
        exportGpio(pin);
        setDirection(pin, "in");
    }

    for (int pin : outputPins) {
        exportGpio(pin);
        setDirection(pin, "out");
        writeGpioValue(pin, 0);
    }

    m_pollTimer.start();
}

void GpioController::cleanup() {
    int allPins[] = {ENGINE_BTN, ACCEL_BTN, BRAKE_BTN, LEFT_BTN, RIGHT_BTN, LEFT_LED, RIGHT_LED};
    for (int pin : allPins)
        unexportGpio(pin);
}

void GpioController::exportGpio(int pin) {
    ofstream exportFile("/sys/class/gpio/export");
    if (exportFile.is_open()) {
        exportFile << pin;
        exportFile.close();
        usleep(100000);
    }
}

void GpioController::unexportGpio(int pin) {
    ofstream unexportFile("/sys/class/gpio/unexport");
    if (unexportFile.is_open()) {
        unexportFile << pin;
        unexportFile.close();
    }
}

void GpioController::setDirection(int pin, const string &direction) {
    string path = "/sys/class/gpio/gpio" + to_string(pin) + "/direction";
    ofstream dirFile(path);
    if (dirFile.is_open()) {
        dirFile << direction;
        dirFile.close();
    } else {
        cerr << "Failed to set direction for GPIO" << pin << endl;
    }
}

int GpioController::readGpioValue(int pin) {
    string path = "/sys/class/gpio/gpio" + to_string(pin) + "/value";
    ifstream valFile(path);
    int value = 1;
    if (valFile.is_open()) {
        valFile >> value;
        valFile.close();
    }
    return value;
}

void GpioController::writeGpioValue(int pin, int value) {
    string path = "/sys/class/gpio/gpio" + to_string(pin) + "/value";
    ofstream valFile(path);
    if (valFile.is_open()) {
        valFile << value;
        valFile.close();
    }
}

void GpioController::updateInputs() {
    int engine = readGpioValue(ENGINE_BTN);
    int accel  = readGpioValue(ACCEL_BTN);
    int brake  = readGpioValue(BRAKE_BTN);
    int left   = readGpioValue(LEFT_BTN);
    int right  = readGpioValue(RIGHT_BTN);

    if (engine == 0 && lastEngineState == 1) emit engineButtonPressed();
    if (accel  == 0 && lastAccelState  == 1) emit accelButtonPressed();
    if (brake  == 0 && lastBrakeState  == 1) emit brakeButtonPressed();
    if (left   == 0 && lastLeftState   == 1) emit leftSignalButtonPressed();
    if (right  == 0 && lastRightState  == 1) emit rightSignalButtonPressed();

    lastEngineState = engine;
    lastAccelState  = accel;
    lastBrakeState  = brake;
    lastLeftState   = left;
    lastRightState  = right;
}

void GpioController::handleLeftSignal(bool on) {
    writeGpioValue(LEFT_LED, on ? 1 : 0);
}

void GpioController::handleRightSignal(bool on) {
    writeGpioValue(RIGHT_LED, on ? 1 : 0);
}
