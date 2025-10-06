#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "speedcontroller.h"
#include "SeatController.h"
#include "dashboardcontroller.h"
#include "tachometercontroller.h"
#include "temperaturecontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    SpeedController speedController;
    SeatController seatController;
    DashboardController dashboardController;
    TachometerController tachometerController;
    TemperatureController temperatureController;

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

    engine.load(url);
    return app.exec();
}
