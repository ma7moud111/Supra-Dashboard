import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 300
    height: 100

    property color glowColor: "#00eaff"
    property color textColor: "grey"
    property int fontSize: 56
    property bool showSeconds: true

    anchors.topMargin: 60

    Timer {
        id: clockTimer
        interval: 1000
        repeat: true
        running: true
        onTriggered: timeText.text = Qt.formatTime(new Date(), showSeconds ? "hh:mm:ss" : "hh:mm")
    }

    Repeater {
        model: 2
        delegate: Text {
            anchors.centerIn: parent
            text: Qt.formatTime(new Date(), showSeconds ? "hh:mm:ss" : "hh:mm")
            font.pixelSize: root.fontSize
            font.bold: true
            font.family: "Consolas"
            color: Qt.rgba(0.0, 0.8, 1.0, 0.25 / (index + 1))
            scale: 1.03 + (index *0.02)
            opacity: 0.4 / (index + i)
        }
    }

    Text {
        id: timeText
        anchors.centerIn: parent
        text: Qt.formatTime(new Date(), showSeconds ? "hh:mm:ss" : "hh:mm")
        font.pixelSize: root.fontSize
        font.bold: true
        font.family: "Consolas"
        color: root.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    SequentialAnimation on opacity {
        loops: Animation.Infinite
        NumberAnimation { from: 1.0; to: 0.8; duration: 1000; easing.type: Easing.InOutQuad }
        NumberAnimation { from: 0.8; to: 1.0; duration: 1000; easing.type: Easing.InOutQuad }
    }

    SequentialAnimation on scale {
        loops: Animation.Infinite
        NumberAnimation { from: 1.0; to: 1.05; duration: 1500; easing.type: Easing.InOutQuad }
        NumberAnimation { from: 1.05; to: 1.0; duration: 1500; easing.type: Easing.InOutQuad }
    }
}
