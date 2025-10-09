import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 2.15
import QtQuick.Shapes 2.15

Window {
    visible: true
    visibility: "FullScreen"
    title: qsTr("Car Dashboard")

    // ---------- Splash Screen ----------
    Rectangle {
        id: splashScreen
        anchors.fill: parent
        color: "black"
        z: 100
        opacity: 1.0

        // Center Gauge Animation
        CircularGauge {
            id: splashGauge
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 300
            height: 300
            maxValue: 180
            value: 0
            opacity: 0.0

            SequentialAnimation on opacity {
                PauseAnimation { duration: 300 }
                NumberAnimation { from: 0; to: 1; duration: 500 }
            }

            SequentialAnimation on value {
                PauseAnimation { duration: 500 }
                NumberAnimation { from: 0; to: 180; duration: 1200; easing.type: Easing.OutCubic }
                NumberAnimation { from: 180; to: 0; duration: 900; easing.type: Easing.InCubic }
            }
        }

        // Label Under Gauge
        Text {
            id: splashTitle
            text: "TOYOTA  SUPRA"
            color: "red"
            font.pixelSize: 64
            font.bold: true
            anchors.horizontalCenter: splashGauge.horizontalCenter
            anchors.top: splashGauge.bottom
            anchors.topMargin: 40
            opacity: 0.0

            SequentialAnimation on opacity {
                PauseAnimation { duration: 400 }
                NumberAnimation { from: 0; to: 1; duration: 800; easing.type: Easing.OutQuad }
                PauseAnimation { duration: 1000 }
                NumberAnimation { from: 1; to: 0; duration: 800; easing.type: Easing.InQuad }
            }
        }

        // Welcome Message at Bottom
        Text {
            id: welcomeMessage
            text: "Welcome, Mahmoud Sayed"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 130
            font.pixelSize: 36
            color: "white"
            opacity: 0.0

            Behavior on opacity {
                NumberAnimation { duration: 1500; easing.type: Easing.InOutQuad }
            }
            Component.onCompleted: opacity = 1.0
        }

        // Timer to trigger dashboard after splash
        Timer {
            id: startDashboardTimer
            interval: 4000    // total splash duration
            repeat: false
            onTriggered: {
                // Hide splash and start dashboard animation directly
                splashScreen.visible = false
                dashboardStartup.start()
            }
        }

        // Start splash + timer automatically
        Component.onCompleted: startDashboardTimer.start()

        // Fade out splash
        SequentialAnimation on opacity {
            PauseAnimation { duration: 3200 }
            NumberAnimation { from: 1; to: 0; duration: 800 }
        }
    }


    // ---------- Dashboard ----------
    Rectangle {
        id: dashboard
        anchors.fill: parent
        color: "black"
        focus: true

        // ---------- Weather Box ----------
        Rectangle {
            id: weatherBox
            width: 180
            height: 70
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: 25
            anchors.leftMargin: 40
            radius: 12
            color: "#101820"
            border.color: "#00eaff"
            border.width: 2
            opacity: 0.9

            Column {
                anchors.centerIn: parent
                spacing: 2
                Text {
                    text: "Outside"
                    font.pixelSize: 14
                    color: "#aaaaaa"
                }

                Row {
                    anchors.centerIn: parent
                    spacing: 8
                    Text {
                        text: weatherTemp > 30 ? "☀️" :
                              weatherTemp > 15 ? "🌤️" :
                              weatherTemp > 5  ? "☁️" : "❄️"
                        font.pixelSize: 30
                    }
                    Text {
                        text: weatherTemp.toFixed(1) + " °C"
                        font.pixelSize: 26
                        font.bold: true
                        color: "#00eaff"
                    }
                }
            }
        }

        // ---------- LEDs Row ----------
        Row {
            spacing: 40
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 30

            Column { spacing: 5
                Rectangle { width: 30; height: 30; radius: 15; color: dashboardController.engineOn ? "#0af01d" : "gray" }
                Text { text: "Engine"; color: "white"; font.bold: true }
            }
            Column { spacing: 5
                Rectangle { width: 30; height: 30; radius: 15; color: dashboardController.batteryLow ? "red" : "gray" }
                Text { text: "Battery"; color: "white"; font.bold: true }
            }
            Column { spacing: 5
                Rectangle { width: 30; height: 30; radius: 15; color: dashboardController.oilLow ? "red" : "gray" }
                Text { text: "Oil"; color: "white"; font.bold: true }
            }
            Column { spacing: 5
                Rectangle { width: 30; height: 30; radius: 15; color: dashboardController.seatbeltOn ? "yellow" : "gray" }
                Text { text: "Seatbelt"; color: "white"; font.bold: true }
            }
            Column { spacing: 5
                Rectangle { width: 30; height: 30; radius: 15; color: dashboardController.leftSignalOn ? "yellow" : "gray" }
                Text { text: "Left"; color: "white"; font.bold: true }
            }
            Column { spacing: 5
                Rectangle { width: 30; height: 30; radius: 15; color: dashboardController.rightSignalOn ? "yellow" : "gray" }
                Text { text: "Right"; color: "white"; font.bold: true }
            }
        }

        // ---------- Compass ----------
        Compass {
            id: dashboardCompass
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 40
            anchors.topMargin: 40
            width: 140
            height: 140
            heading: compassController.heading
        }

        // ---------- Tachometer (Left) ----------
        CircularGauge {
            id: tachometer
            value: tachometerController.rpm / 1000.0
            minValue: 0
            maxValue: 8
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.08
            width: parent.width * 0.22
            height: parent.height * 0.45
            progressColor: value > 6.5 ? "red" : "lime"
            needleColor: "orange"
            centerDotColor: "gray"
            unitLabel: "RPM"
            majorTicks: 4
            visible: false
            opacity: 0
            x: -parent.width * 0.2

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.verticalCenter
                anchors.topMargin: strokeWidth * 2
                spacing: 4
                Text { text: value.toFixed(1); font.pixelSize: 20; font.bold: true; color: root.value > 6.5 ? "red" : "white" }
                Text { text: "x1000 RPM"; font.pixelSize: 14; color: "lightgray" }
            }
        }

        // ---------- Digital Clock (Bottom Right) ----------
        DigitalClock {
            id: dashboardClock
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 20
            anchors.bottomMargin: 20
            glowColor: "#00eaff"
            textColor: "white"
            fontSize: 40
            opacity: 0.1
        }

        // ---------- Speedometer (Center) ----------
        CircularGauge {
            id: speedometer
            value: speedController.speed
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.35
            height: parent.height * 0.6
            maxValue: 180
            progressColor: value > 120 ? "red" : "cyan"
            needleColor: "red"
            unitLabel: "km/h"
            visible: false
            opacity: 0
            scale: 0.6

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.verticalCenter
                anchors.topMargin: strokeWidth * 2
                spacing: 4
                Text { text: Math.round(root.value); font.pixelSize: 30; font.bold: true; color: root.value > 120 ? "red" : "white" }
                Text { text: "km/h"; font.pixelSize: 18; color: "lightgray" }
            }
        }

        // ---------- Temperature Gauge (Right) ----------
        CircularGauge {
            id: tempGauge
            value: temperatureController.temperature
            minValue: 0
            maxValue: 130
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.08
            width: parent.width * 0.22
            height: parent.height * 0.45
            progressColor: value > 110 ? "red" : "cyan"
            needleColor: "orange"
            centerDotColor: "white"
            unitLabel: "°C"
            majorTicks: 4
            visible: false
            opacity: 0
            x: parent.width * 1.2

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.verticalCenter
                anchors.topMargin: strokeWidth * 2
                spacing: 4
                Text { text: Math.round(root.value); font.pixelSize: 20; font.bold: true; color: root.value > 110 ? "red" : "white" }
                Text { text: "°C"; font.pixelSize: 14; color: "lightgray" }
            }
        }

        // ---------- Seat Control ----------
        Item {
            id: seatGroup
            width: 240
            height: 220
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 80
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: seatBase
                width: 140
                height: 25
                radius: 8
                color: "#3a8fd1"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                id: seatBack
                width: 20
                height: 130
                radius: 10
                color: "#888"
                anchors.bottom: seatBase.top
                anchors.right: seatBase.right
                transform: Rotation {
                    id: seatBackRotation
                    origin.x: seatBack.width
                    origin.y: seatBack.height
                    angle: seatController.seatBackAngle
                }
                Behavior on transform { NumberAnimation { duration: 250; easing.type: Easing.InOutQuad } }
            }

            Rectangle {
                id: headRest
                width: 40
                height: 20
                radius: 5
                color: "#2a85c7"
                anchors.bottom: seatBack.top
                anchors.horizontalCenter: seatBack.horizontalCenter
                anchors.bottomMargin: 5
                transform: Rotation {
                    origin.x: headRest.width / 2
                    origin.y: headRest.height + seatBack.height
                    angle: seatController.seatBackAngle
                }
            }

            Text {
                anchors.top: seatBase.bottom
                anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Seat"
                color: "white"
                font.bold: true
                font.pixelSize: 22
            }
        }

        // ---------- Key Events ----------
        Keys.onPressed: {
            if (event.key === Qt.Key_Up) speedController.startAcceleration()
            else if (event.key === Qt.Key_Down) speedController.startBraking()
            else if (event.key === Qt.Key_Right && seatController.seatPosition < 30) seatController.startForward()
            else if (event.key === Qt.Key_Left && seatController.seatPosition > -20) seatController.startBackward()
            else if (event.key === Qt.Key_A) dashboardController.toggleLeftSignal()
            else if (event.key === Qt.Key_D) dashboardController.toggleRightSignal()
            else if (event.key === Qt.Key_E) dashboardController.setEngineOn(!dashboardController.engineOn)
        }

        Keys.onReleased: {
            if (event.key === Qt.Key_Up) speedController.stopAcceleration()
            else if (event.key === Qt.Key_Down) speedController.stopBraking()
            else if (event.key === Qt.Key_Right) seatController.stopForward()
            else if (event.key === Qt.Key_Left) seatController.stopBackward()
        }

        // ---------- Startup Animation ----------
        SequentialAnimation {
            id: dashboardStartup
            running: false
            PropertyAction { target: speedometer; property: "visible"; value: true }

            ParallelAnimation {
                NumberAnimation { target: speedometer; property: "opacity"; from: 0; to: 1; duration: 800; easing.type: Easing.InOutQuad }
                NumberAnimation { target: speedometer; property: "scale"; from: 0.6; to: 1.0; duration: 800; easing.type: Easing.OutBack }
            }

            PauseAnimation { duration: 400 }

            ParallelAnimation {
                PropertyAction { target: tachometer; property: "visible"; value: true }
                PropertyAction { target: tempGauge; property: "visible"; value: true }

                NumberAnimation { target: tachometer; property: "x"; to: parent.width * 0.08; duration: 700; easing.type: Easing.OutCubic }
                NumberAnimation { target: tempGauge; property: "x"; to: parent.width - tempGauge.width - parent.width * 0.08; duration: 700; easing.type: Easing.OutCubic }

                NumberAnimation { target: tachometer; property: "opacity"; from: 0; to: 1; duration: 700 }
                NumberAnimation { target: tempGauge; property: "opacity"; from: 0; to: 1; duration: 700 }
            }

            PauseAnimation { duration: 300 }

            ParallelAnimation {
                NumberAnimation { target: dashboardClock; property: "opacity"; from: 0; to: 1; duration: 600 }
            }
        }
    }
}
