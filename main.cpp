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
    GpioController gpioController;   // Now reads from CSV file

    qDebug() << "Starting Car Dashboard Simulation (CSV GPIO Mode)...";

    // --- Connect CSV-based GPIO events ---
    QObject::connect(&gpioController, &GpioController::buttonsUpdated, [&]() {

        // Engine button (button1)
        if (!gpioController.button1Pressed()) {
            dashboardController.setEngineOn(!dashboardController.engineOn());
        }

        // Accelerate button (button2)
        if (!gpioController.button2Pressed()) {
            speedController.startAcceleration();
            QTimer::singleShot(200, [&]() { speedController.stopAcceleration(); });
        }

        // Brake button (button3)
        if (!gpioController.button3Pressed()) {
            speedController.startBraking();
            QTimer::singleShot(200, [&]() { speedController.stopBraking(); });
        }

        // Left signal (button4)
        if (!gpioController.button4Pressed()) {
            dashboardController.toggleLeftSignal();
        }

        // Right signal (button5)
        if (!gpioController.button5Pressed()) {
            dashboardController.toggleRightSignal();
        }
    });

    // --- Engine on/off → RPM + temperature + speed sync ---
    QObject::connect(&dashboardController, &DashboardController::engineOnChanged,
                     [&](bool on) {
                         speedController.setEngineRunning(on);
                         tachometerController.updateRpm(speedController.speed(), on);
                         temperatureController.setEngineOn(on);
                     });

    // --- Speed change → RPM sync ---
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
    engine.rootContext()->setContextProperty("gpioController", &gpioController);

    // --- Load main QML ---
    const QUrl url(QStringLiteral("qrc:/dashboardhw/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);

    engine.load(url);

    qDebug() << "Dashboard started successfully.";
    qDebug() << "Monitoring button states from /home/weston/buttons_log.csv ...";

    return app.exec();
}
