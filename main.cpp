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
#include "fileseatreader.h"   // reads /home/weston/data.csv periodically

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
    FileSeatReader seatReader;  // polls file in ctor

    // --- Initialize GPIO subsystem (if using real GPIO path) ---
    gpioController.init();

    // --- Connect CSV reader -> SeatController ---
    // Note: FileSeatReader already maps pot (0..1023) -> angle (0..45) and emits it.
    QObject::connect(&seatReader, &FileSeatReader::seatAngleReceived,
                     [&](int angle) {
                         // angle is expected in degrees (0..45) from FileSeatReader
                         seatController.setSeatBackAngleFromSensor(angle);
                     });

    // --- GPIO Button -> Dashboard logic ---
    QObject::connect(&gpioController, &GpioController::engineButtonPressed, [&]() {
        dashboardController.setEngineOn(!dashboardController.engineOn());
    });

    // Acceleration: start on press, stop on release
    QObject::connect(&gpioController, &GpioController::accelButtonPressed, [&]() {
        speedController.startAcceleration();
    });
    QObject::connect(&gpioController, &GpioController::accelButtonReleased, [&]() {
        speedController.stopAcceleration();
    });

    // Braking: start on press, stop on release
    QObject::connect(&gpioController, &GpioController::brakeButtonPressed, [&]() {
        speedController.startBraking();
    });
    QObject::connect(&gpioController, &GpioController::brakeButtonReleased, [&]() {
        speedController.stopBraking();
    });

    // Turn signals (toggle)
    QObject::connect(&gpioController, &GpioController::leftSignalButtonPressed, [&]() {
        dashboardController.toggleLeftSignal();
    });
    QObject::connect(&gpioController, &GpioController::rightSignalButtonPressed, [&]() {
        dashboardController.toggleRightSignal();
    });

    // --- Dashboard LED <-> GPIO LED sync ---
    QObject::connect(&dashboardController, &DashboardController::leftSignalOnChanged,
                     &gpioController, &GpioController::handleLeftSignal);
    QObject::connect(&dashboardController, &DashboardController::rightSignalOnChanged,
                     &gpioController, &GpioController::handleRightSignal);

    // --- Graceful cleanup on exit ---
    QObject::connect(&app, &QCoreApplication::aboutToQuit, [&]() {
        gpioController.cleanup();
    });

    // --- Engine state -> subsystems ---
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

    // --- Load main QML ---
    const QUrl url(QStringLiteral("qrc:/dashboardhw/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);

    qDebug() << "Dashboard running with file-based seat angle input (/home/weston/data.csv).";
    engine.load(url);

    return app.exec();
}
