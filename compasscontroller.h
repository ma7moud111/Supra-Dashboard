#ifndef COMPASSCONTROLLER_H
#define COMPASSCONTROLLER_H

#include <QObject>
#include <QTimer>

class CompassController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double heading READ heading NOTIFY headingChanged)

public:
    explicit CompassController(QObject *parent = nullptr);

    double heading() const;

public slots:
    void updateHeading();  // simulate or read sensor

signals:
    void headingChanged(double heading);

private:
    double m_heading;
    QTimer m_timer;
};

#endif // COMPASSCONTROLLER_H
