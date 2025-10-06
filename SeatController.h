#ifndef SEATCONTROLLER_H
#define SEATCONTROLLER_H

#include <QObject>
#include <QTimer>

class SeatController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int seatPosition READ seatPosition NOTIFY seatPositionChanged)
    Q_PROPERTY(qreal seatBackAngle READ seatBackAngle NOTIFY seatBackAngleChanged)

public:
    explicit SeatController(QObject *parent = nullptr);

    int seatPosition() const { return m_seatPosition; }
    qreal seatBackAngle() const { return m_seatBackAngle; }

public slots:
    void startForward();
    void startBackward();
    void stopForward();
    void stopBackward();

signals:
    void seatPositionChanged(int seatPosition);
    void seatBackAngleChanged(qreal seatBackAngle);

private slots:
    void updateSeatPosition();

private:
    int m_seatPosition;       // seat linear position (optional for future)
    qreal m_seatBackAngle;    // rotation angle
    QTimer m_timer;
    int m_direction;          // 1 for forward (recline), -1 for backward
};

#endif // SEATCONTROLLER_H
