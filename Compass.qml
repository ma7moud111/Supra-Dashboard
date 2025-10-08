// Compass.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

Item {
    id: compass
    width: 150
    height: 150

    property real heading: 0        // in degrees (0 = North)
    property color needleColor: "red"
    property color dialColor: "lightgray"
    property color textColor: "white"

    // Outer dial
    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: "transparent"
        border.color: dialColor
        border.width: 2
    }

    // Cardinal points
    Repeater {
        model: ["N", "E", "S", "W"]
        delegate: Text {
            text: modelData
            font.pixelSize: 16
            font.bold: true
            color: textColor
            anchors.centerIn: parent
            transform: Rotation {
                origin.x: 0
                origin.y: 0
                angle: index * 90
            }
            x: compass.width / 2 - width / 2 + Math.sin(Math.radians(index * 90)) * (compass.width / 2 - 20)
            y: compass.height / 2 - height / 2 - Math.cos(Math.radians(index * 90)) * (compass.height / 2 - 20)
        }
    }

    // Needle (rotates based on heading)
    Rectangle {
        id: needle
        width: 4
        height: compass.height / 2 - 10
        color: needleColor
        radius: 2
        anchors.centerIn: parent
        transform: Rotation {
            origin.x: needle.width / 2
            origin.y: needle.height
            angle: -compass.heading
        }
    }

    // Heading text
    Text {
        text: Math.round(compass.heading) + "°"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        font.pixelSize: 18
        color: textColor
    }
}
