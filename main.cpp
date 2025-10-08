#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
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

    SpeedController speedController;
    SeatController seatController;
    DashboardController dashboardController;
    TachometerController tachometerController;
    TemperatureController temperatureController;
    GpioController gpioController;




    // --- Initialize GPIO ---
    gpioController.init();

    // --- GPIO Button → Dashboard Logic Connections ---
    QObject::connect(&gpioController, &GpioController::engineButtonPressed, [&]() {
        dashboardController.setEngineOn(!dashboardController.engineOn());
    });

    QObject::connect(&gpioController, &GpioController::accelButtonPressed, [&]() {
        // Pressing accelerate increases speed temporarily
        speedController.startAcceleration();
        QTimer::singleShot(200, [&]() { speedController.stopAcceleration(); });
    });

    QObject::connect(&gpioController, &GpioController::brakeButtonPressed, [&]() {
        // Pressing brake decreases speed temporarily
        speedController.startBraking();
        QTimer::singleShot(200, [&]() { speedController.stopBraking(); });
    });

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




    // Engine state connections
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

    engine.rootContext()->setContextProperty("speedController", &speedController);
    engine.rootContext()->setContextProperty("seatController", &seatController);
    engine.rootContext()->setContextProperty("dashboardController", &dashboardController);
    engine.rootContext()->setContextProperty("tachometerController", &tachometerController);
    engine.rootContext()->setContextProperty("temperatureController", &temperatureController);

    const QUrl url(QStringLiteral("qrc:/dashboardhw/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);

    qDebug() << "Starting application. If GPIO export fails, try running with sudo.";
    engine.load(url);
    return app.exec();
}
