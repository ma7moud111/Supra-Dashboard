#include "gpiocontroller.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>

GpioController::GpioController(QObject *parent)
    : QObject(parent),
    m_button1(true),
    m_button2(true),
    m_button3(true),
    m_button4(true),
    m_button5(true),
    m_filePath("/home/weston/buttons_log.csv")
{
    // Set up polling (simulate input pull-up, 1 = released, 0 = pressed)
    connect(&m_pollTimer, &QTimer::timeout, this, &GpioController::readButtonsFromFile);
    m_pollTimer.start(200);  // 5 Hz polling rate
}

void GpioController::readButtonsFromFile()
{
    QFile file(m_filePath);
    if (!file.exists()) {
        qWarning() << "Button log file not found at" << m_filePath;
        return;
    }

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Unable to open button log file";
        return;
    }

    QTextStream in(&file);
    QString headerLine = in.readLine(); // Skip header
    QString dataLine = in.readLine();

    if (dataLine.isEmpty()) {
        qWarning() << "Button log file is empty or malformed";
        file.close();
        return;
    }

    QStringList values = dataLine.split(',', Qt::SkipEmptyParts);
    if (values.size() < 5) {
        qWarning() << "Invalid button CSV format, expecting 5 values";
        file.close();
        return;
    }

    // Convert to bool (1 = pressed/LOW, 0 = released/HIGH)
    bool newButton1 = values[0].trimmed().toInt() == 0 ? false : true;
    bool newButton2 = values[1].trimmed().toInt() == 0 ? false : true;
    bool newButton3 = values[2].trimmed().toInt() == 0 ? false : true;
    bool newButton4 = values[3].trimmed().toInt() == 0 ? false : true;
    bool newButton5 = values[4].trimmed().toInt() == 0 ? false : true;

    bool changed = (m_button1 != newButton1) || (m_button2 != newButton2) ||
                   (m_button3 != newButton3) || (m_button4 != newButton4) ||
                   (m_button5 != newButton5);

    m_button1 = newButton1;
    m_button2 = newButton2;
    m_button3 = newButton3;
    m_button4 = newButton4;
    m_button5 = newButton5;

    file.close();

    if (changed)
        emit buttonsUpdated();
}
