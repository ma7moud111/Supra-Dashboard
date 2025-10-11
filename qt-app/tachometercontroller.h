#ifndef TACHOMETERCONTROLLER_H
#define TACHOMETERCONTROLLER_H

#include <QObject>
#include <QTimer>

class TachometerController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int rpm READ rpm NOTIFY rpmChanged)

public:
    explicit TachometerController(QObject *parent = nullptr);

    int rpm() const;

public slots:
    void updateRpm(int speed, bool engineOn);

signals:
    void rpmChanged(int rpm);

private:
    int m_rpm;
};

#endif // TACHOMETERCONTROLLER_H
