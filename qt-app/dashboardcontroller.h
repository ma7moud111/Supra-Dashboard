#ifndef DASHBOARDCONTROLLER_H
#define DASHBOARDCONTROLLER_H

#include <QObject>

class DashboardController : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool engineOn READ engineOn WRITE setEngineOn NOTIFY engineOnChanged)
    Q_PROPERTY(bool batteryLow READ batteryLow WRITE setBatteryLow NOTIFY batteryLowChanged)
    Q_PROPERTY(bool oilLow READ oilLow WRITE setOilLow NOTIFY oilLowChanged)
    Q_PROPERTY(bool seatbeltOn READ seatbeltOn WRITE setSeatbeltOn NOTIFY seatbeltOnChanged)
    Q_PROPERTY(bool leftSignalOn READ leftSignalOn WRITE setLeftSignalOn NOTIFY leftSignalOnChanged)
    Q_PROPERTY(bool rightSignalOn READ rightSignalOn WRITE setRightSignalOn NOTIFY rightSignalOnChanged)

public:
    explicit DashboardController(QObject *parent = nullptr);

    bool engineOn() const { return m_engineOn; }
    bool batteryLow() const { return m_batteryLow; }
    bool oilLow() const { return m_oilLow; }
    bool seatbeltOn() const { return m_seatbeltOn; }
    bool leftSignalOn() const { return m_leftSignalOn; }
    bool rightSignalOn() const { return m_rightSignalOn; }

public slots:
    void setEngineOn(bool on);
    void setBatteryLow(bool low);
    void setOilLow(bool low);
    void setSeatbeltOn(bool on);
    void setLeftSignalOn(bool on);
    void setRightSignalOn(bool on);
    void toggleLeftSignal();
    void toggleRightSignal();

signals:
    void engineOnChanged(bool);
    void batteryLowChanged(bool);
    void oilLowChanged(bool);
    void seatbeltOnChanged(bool);
    void leftSignalOnChanged(bool);
    void rightSignalOnChanged(bool);

private:
    bool m_engineOn = false;
    bool m_batteryLow = false;
    bool m_oilLow = false;
    bool m_seatbeltOn = false;
    bool m_leftSignalOn = false;
    bool m_rightSignalOn = false;
};

#endif // DASHBOARDCONTROLLER_H
