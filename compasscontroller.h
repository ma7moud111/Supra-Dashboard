#ifndef COMPASSCONTROLLER_H
#define COMPASSCONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QFile>
#include <QTextStream>

class CompassController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double heading READ heading NOTIFY headingChanged)

public:
    explicit CompassController(QObject *parent = nullptr);

    double heading() const;

public slots:
    void updateHeading();  // read compass angle from sensors.csv

signals:
    void headingChanged(double heading);

private:
    double m_heading;
    QTimer m_timer;

    QString m_filePath = "/home/weston/sensors.csv";
};

#endif // COMPASSCONTROLLER_H
