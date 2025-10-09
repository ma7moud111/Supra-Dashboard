#ifndef SEATCONTROLLER_H
#define SEATCONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QtMath>

class SeatController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal seatBackAngle READ seatBackAngle NOTIFY seatBackAngleChanged)

public:
    explicit SeatController(QObject *parent = nullptr);

    qreal seatBackAngle() const { return m_seatBackAngle; }
    qreal seatPosition() const { return m_seatPosition; }

public slots:
    void startForward();
    void startBackward();
    void stopForward();
    void stopBackward();
    void setSeatBackAngleFromSensor(int angle);

signals:
    void seatBackAngleChanged(qreal angle);

private slots:
    void updateSeatPosition();

private:
    qreal m_seatPosition;
    qreal m_seatBackAngle;
    int m_direction;
    QTimer m_timer;
};

#endif // SEATCONTROLLER_H
