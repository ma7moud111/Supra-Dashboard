import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 2.15
import QtQuick.Shapes 2.15

Window {
    visible: true
    visibility: "Maximized"
    title: qsTr("Car Dashboard")

    // ---------- Splash Screen ----------
    Rectangle {
        id: splashScreen
        anchors.fill: parent
        color: "black"
        z: 100
        opacity: 1.0

        Text {
            id: splashTitle
            text: "  Car Dashboard                  Mahmoud Sayed"
            color: "white"
            font.pixelSize: 80
            font.bold: true
            anchors.centerIn: parent
            opacity: 0.0

            SequentialAnimation on opacity {
                NumberAnimation { from: 0; to: 0.4; duration: 900; easing.type: Easing.InOutQuad }
                PauseAnimation { duration: 1000 }
                NumberAnimation { from: 0.4; to: 0; duration: 900; easing.type: Easing.InOutQuad }
            }
        }

        CircularGauge {
            id: splashGauge
            anchors.centerIn: parent
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

        SequentialAnimation {
            running: true
            NumberAnimation { target: splashScreen; property: "opacity"; from: 1; to: 1; duration: 2800 }
            NumberAnimation { target: splashScreen; property: "opacity"; from: 1; to: 0; duration: 800 }
            onStopped: splashScreen.visible = false
        }
    }

    // ---------- Dashboard ----------
    Rectangle {
        id: dashboard
        anchors.fill: parent
        color: "black"
        focus: true

        // ---------- LEDs Row ----------
        Row {
            spacing: 40
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 30

            // Engine LED
            Column {
                spacing: 5
                Rectangle { width: 30; height: 30; radius: 15; color: dashboardController.engineOn ? "green" : "gray" }
                Text { text: "Engine"; color: "white"; font.bold: true }
            }

            // Battery LED
            Column {
                spacing: 5
                Rectangle { width: 30; height: 30; radius: 15; color: dashboardController.batteryLow ? "red" : "gray" }
                Text { text: "Battery"; color: "white"; font.bold: true }
            }

            // Oil LED
            Column {
                spacing: 5
                Rectangle { width: 30; height: 30; radius: 15; color: dashboardController.oilLow ? "red" : "gray" }
                Text { text: "Oil"; color: "white"; font.bold: true }
            }

            // Seatbelt LED
            Column {
                spacing: 5
                Rectangle { width: 30; height: 30; radius: 15; color: dashboardController.seatbeltOn ? "yellow" : "gray" }
                Text { text: "Seatbelt"; color: "white"; font.bold: true }
            }

            // Left Signal LED
            Column {
                spacing: 5
                Rectangle { width: 30; height: 30; radius: 15; color: dashboardController.leftSignalOn ? "orange" : "gray" }
                Text { text: "Left"; color: "white"; font.bold: true }
            }

            // Right Signal LED
            Column {
                spacing: 5
                Rectangle { width: 30; height: 30; radius: 15; color: dashboardController.rightSignalOn ? "orange" : "gray" }
                Text { text: "Right"; color: "white"; font.bold: true }
            }
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
            needleColor: "white"
            centerDotColor: "gray"
            majorTicks: 4

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.verticalCenter
                anchors.topMargin: strokeWidth * 2
                spacing: 4
                Text {
                    text: value.toFixed(1)
                    font.pixelSize: 20
                    font.bold: true
                    color: root.value > 6.5 ? "red" : "white"
                }
                Text {
                    text: "x1000 RPM"
                    font.pixelSize: 14
                    color: "lightgray"
                }
            }
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
            needleColor: "white"

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.verticalCenter
                anchors.topMargin: strokeWidth * 2
                spacing: 4
                Text {
                    text: Math.round(root.value)
                    font.pixelSize: 30
                    font.bold: true
                    color: root.value > 120 ? "red" : "white"
                }
                Text {
                    text: "km/h"
                    font.pixelSize: 18
                    color: "lightgray"
                }
            }
        }

        // ---------- Temperature Gauge (Right) ----------
        CircularGauge {
            id: tempGauge
            value: temperatureController.temperature
            minValue: 50
            maxValue: 130
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.08
            width: parent.width * 0.22
            height: parent.height * 0.45
            progressColor: value > 110 ? "red" : "cyan"
            needleColor: "orange"
            centerDotColor: "white"
            majorTicks: 4

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.verticalCenter
                anchors.topMargin: strokeWidth * 2
                spacing: 4
                Text {
                    text: Math.round(root.value)
                    font.pixelSize: 20
                    font.bold: true
                    color: root.value > 110 ? "red" : "white"
                }
                Text {
                    text: "c"
                    font.pixelSize: 14
                    color: "lightgray"
                }
            }
        }

        // ---------- Seat Control (Bottom Center) ----------
        Item {
            id: seatGroup
            width: 240
            height: 220
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 80
            anchors.horizontalCenter: parent.horizontalCenter

            // Seat Base (fixed)
            Rectangle {
                id: seatBase
                width: 140
                height: 25
                radius: 8
                color: "#3a8fd1"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Seat Back (controlled from C++)
            Rectangle {
                id: seatBack
                width: 20
                height: 130
                radius: 10
                color: "#888"
                anchors.bottom: seatBase.top
                anchors.right: seatBase.right  // fixed to back-right edge
                transform: Rotation {
                    id: seatBackRotation
                    origin.x: seatBack.width
                    origin.y: seatBack.height
                    angle: seatController.seatBackAngle
                }

                Behavior on transform {
                    NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
                }
            }

            // Headrest moves with the back
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

            // Seat label
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
    }
}
