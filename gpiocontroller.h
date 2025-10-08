#ifndef GPIOCONTROLLER_H
#define GPIOCONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QStringList>

class GpioController : public QObject
{
    Q_OBJECT

public:
    explicit GpioController(QObject *parent = nullptr);

    // Button state getters
    bool button1Pressed() const { return m_button1; }
    bool button2Pressed() const { return m_button2; }
    bool button3Pressed() const { return m_button3; }
    bool button4Pressed() const { return m_button4; }
    bool button5Pressed() const { return m_button5; }

signals:
    // Optional signals if you want to notify QML/other controllers
    void buttonsUpdated();

private slots:
    void readButtonsFromFile();

private:
    bool m_button1;
    bool m_button2;
    bool m_button3;
    bool m_button4;
    bool m_button5;

    QTimer m_pollTimer;
    QString m_filePath;
};

#endif // GPIOCONTROLLER_H
