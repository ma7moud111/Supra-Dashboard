#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTimer>

#include "speedcontroller.h"
#include "SeatController.h"
#include "dashboardcontroller.h"
#include "tachometercontroller.h"
#include "temperaturecontroller.h"
#include "gpiocontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // --- Instantiate controllers ---
    SpeedController speedController;
    SeatController seatController;
    DashboardController dashboardController;
    TachometerController tachometerController;
    TemperatureController temperatureController;
    GpioController gpioController;

    // --- Initialize GPIO pins ---
    gpioController.init();

    // --- GPIO Button → Dashboard Logic Connections ---
    QObject::connect(&gpioController, &GpioController::engineButtonPressed, [&]() {
        dashboardController.setEngineOn(!dashboardController.engineOn());
    });

    // Continuous acceleration while button held
    QObject::connect(&gpioController, &GpioController::accelButtonPressed, [&]() {
        speedController.startAcceleration();
    });
    QObject::connect(&gpioController, &GpioController::accelButtonReleased, [&]() {
        speedController.stopAcceleration();
    });

    // Continuous braking while button held
    QObject::connect(&gpioController, &GpioController::brakeButtonPressed, [&]() {
        speedController.startBraking();
    });
    QObject::connect(&gpioController, &GpioController::brakeButtonReleased, [&]() {
        speedController.stopBraking();
    });

    // Left / Right signals toggle
    QObject::connect(&gpioController, &GpioController::leftSignalButtonPressed, [&]() {
        dashboardController.toggleLeftSignal();
    });
    QObject::connect(&gpioController, &GpioController::rightSignalButtonPressed, [&]() {
        dashboardController.toggleRightSignal();
    });

    // --- Dashboard LED ↔ Physical GPIO LED Sync ---
    QObject::connect(&dashboardController, &DashboardController::leftSignalOnChanged,
                     &gpioController, &GpioController::handleLeftSignal);
    QObject::connect(&dashboardController, &DashboardController::rightSignalOnChanged,
                     &gpioController, &GpioController::handleRightSignal);

    // --- Graceful cleanup on exit ---
    QObject::connect(&app, &QCoreApplication::aboutToQuit, [&]() {
        gpioController.cleanup();
    });

    // --- Engine state ↔ other subsystems ---
    QObject::connect(&dashboardController, &DashboardController::engineOnChanged,
                     [&](bool on) {
                         speedController.setEngineRunning(on);
                         tachometerController.updateRpm(speedController.speed(), on);
                         temperatureController.setEngineOn(on);
                     });

    QObject::connect(&speedController, &SpeedController::speedChanged,
                     [&](int newSpeed) {
                         tachometerController.updateRpm(newSpeed, dashboardController.engineOn());
                     });

    // --- Expose controllers to QML ---
    engine.rootContext()->setContextProperty("speedController", &speedController);
    engine.rootContext()->setContextProperty("seatController", &seatController);
    engine.rootContext()->setContextProperty("dashboardController", &dashboardController);
    engine.rootContext()->setContextProperty("tachometerController", &tachometerController);
    engine.rootContext()->setContextProperty("temperatureController", &temperatureController);

    // --- Load the main dashboard UI ---
    const QUrl url(QStringLiteral("qrc:/dashboardhw/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);

    qDebug() << "Starting application (GPIO press-and-hold mode enabled).";
    engine.load(url);

    return app.exec();
}
