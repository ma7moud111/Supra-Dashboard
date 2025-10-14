#ifndef FILESEATREADER_H
#define FILESEATREADER_H

#include <QObject>
#include <QTimer>

class FileSeatReader : public QObject {
    Q_OBJECT

public:
    explicit FileSeatReader(QObject *parent = nullptr);

signals:
    void seatAngleReceived(int angle);

public slots:
    void readSeatValue();

private:
    QString m_filePath = "/home/weston/data.csv";
    QTimer m_pollTimer;
};

#endif // FILESEATREADER_H
