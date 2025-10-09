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
#include "fileseatreader.h"
#include "weatherreader.h"

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
    FileSeatReader seatReader;
    WeatherReader weatherReader;

    // --- Initialize GPIO subsystem ---
    gpioController.init();

    // --- Connect FileSeatReader -> SeatController ---
    QObject::connect(&seatReader, &FileSeatReader::seatAngleReceived,
                     [&](int angle) {
                         // Convert potentiometer 0–1023 → 0–45 degrees
                         int mappedAngle = static_cast<int>((angle / 1023.0) * 45.0);
                         seatController.setSeatBackAngleFromSensor(mappedAngle);
                     });

    // --- Connect WeatherReader -> QML property ---
    double currentWeatherTemp = 0.0;
    QObject::connect(&weatherReader, &WeatherReader::temperatureUpdated,
                     [&](double temp) {
                         currentWeatherTemp = temp;
                         engine.rootContext()->setContextProperty("weatherTemp", currentWeatherTemp);
                     });

    // Initialize QML property so it’s available from the start
    engine.rootContext()->setContextProperty("weatherTemp", currentWeatherTemp);

    // --- GPIO Button → Dashboard Logic ---
    QObject::connect(&gpioController, &GpioController::engineButtonPressed, [&]() {
        dashboardController.setEngineOn(!dashboardController.engineOn());
    });

    // Acceleration control
    QObject::connect(&gpioController, &GpioController::accelButtonPressed, [&]() {
        speedController.startAcceleration();
    });
    QObject::connect(&gpioController, &GpioController::accelButtonReleased, [&]() {
        speedController.stopAcceleration();
    });

    // Braking control
    QObject::connect(&gpioController, &GpioController::brakeButtonPressed, [&]() {
        speedController.startBraking();
    });
    QObject::connect(&gpioController, &GpioController::brakeButtonReleased, [&]() {
        speedController.stopBraking();
    });

    // Turn signals
    QObject::connect(&gpioController, &GpioController::leftSignalButtonPressed, [&]() {
        dashboardController.toggleLeftSignal();
    });
    QObject::connect(&gpioController, &GpioController::rightSignalButtonPressed, [&]() {
        dashboardController.toggleRightSignal();
    });

    // --- Dashboard LEDs ↔ GPIO LEDs ---
    QObject::connect(&dashboardController, &DashboardController::leftSignalOnChanged,
                     &gpioController, &GpioController::handleLeftSignal);
    QObject::connect(&dashboardController, &DashboardController::rightSignalOnChanged,
                     &gpioController, &GpioController::handleRightSignal);

    // --- Cleanup on exit ---
    QObject::connect(&app, &QCoreApplication::aboutToQuit, [&]() {
        gpioController.cleanup();
    });

    // --- Engine state ↔ Subsystems ---
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

    qDebug() << "🚗 Dashboard started";
    qDebug() << "   - Monitoring seat angle & temperature from /home/weston/data.csv";
    qDebug() << "   - GPIO buttons active for engine, acceleration, brake, and signals";

    engine.load(url);

    return app.exec();
}
