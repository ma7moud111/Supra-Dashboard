import QtQuick 2.15
import QtQuick.Shapes 2.15

Item {
    id: root

    property real minValue: 0
    property real maxValue: 100
    property real value: 0
    property color backgroundColor: "gray"
    property color progressColor: value > 120 ? "red" : "cyan"
    property color needleColor: "red"
    property color centerDotColor: "white"
    property real startAngle: 135
    property real sweepAngle: 270
    property int majorTicks: 9

    implicitWidth: 250
    implicitHeight: 250

    property real strokeWidth: Math.min(width, height) * 0.07
    property real radius: Math.min(width, height) / 2 - strokeWidth * 1.5
    property real centerX: width / 2
    property real centerY: height / 2
    property real fraction: maxValue > minValue ? Math.max(0, Math.min(1, (value - minValue) / (maxValue - minValue))) : 0

    Shape {
        anchors.fill: parent
        ShapePath {
            strokeWidth: root.strokeWidth
            strokeColor: root.backgroundColor
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap
            PathAngleArc {
                centerX: root.centerX
                centerY: root.centerY
                radiusX: root.radius
                radiusY: root.radius
                startAngle: root.startAngle
                sweepAngle: root.sweepAngle
            }
        }
    }

    Shape {
        anchors.fill: parent
        ShapePath {
            strokeWidth: root.strokeWidth
            strokeColor: root.progressColor
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap
            PathAngleArc {
                centerX: root.centerX
                centerY: root.centerY
                radiusX: root.radius
                radiusY: root.radius
                startAngle: root.startAngle
                sweepAngle: root.sweepAngle * root.fraction
            }
        }
    }

    Repeater {
        model: root.majorTicks + 1
        delegate: Item {
            width: root.width
            height: root.height
            property real angle: root.startAngle + index * root.sweepAngle / root.majorTicks
            property real labelValue: root.minValue + index * (root.maxValue - root.minValue) / root.majorTicks

            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    var rad = angle * Math.PI / 180;
                    var x1 = root.centerX + (root.radius - 10) * Math.cos(rad);
                    var y1 = root.centerY + (root.radius - 10) * Math.sin(rad);
                    var x2 = root.centerX + (root.radius - 25) * Math.cos(rad);
                    var y2 = root.centerY + (root.radius - 25) * Math.sin(rad);

                    ctx.beginPath();
                    ctx.moveTo(x1, y1);
                    ctx.lineTo(x2, y2);
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = "white";
                    ctx.stroke();
                }
            }

            Text {
                text: Math.round(labelValue)
                color: "white"
                font.pixelSize: 21
                font.bold: true
                z: 10
                x: root.centerX + (root.radius - 45) * Math.cos(angle * Math.PI / 180) - width / 2
                y: root.centerY + (root.radius - 45) * Math.sin(angle * Math.PI / 180) - height / 2
            }
        }
    }

    Canvas {
        id: needleCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            var angle = (root.startAngle + root.sweepAngle * root.fraction) * Math.PI / 180.0;
            var x2 = root.centerX + root.radius * Math.cos(angle);
            var y2 = root.centerY + root.radius * Math.sin(angle);

            ctx.beginPath();
            ctx.moveTo(root.centerX, root.centerY);
            ctx.lineTo(x2, y2);
            ctx.lineWidth = root.strokeWidth * 0.4;
            ctx.strokeStyle = root.needleColor;
            ctx.stroke();
        }
    }

    onValueChanged: needleCanvas.requestPaint()

    // Central dot
    Rectangle {
        width: strokeWidth * 1.5
        height: strokeWidth * 1.5
        radius: width / 2
        color: root.centerDotColor
        anchors.centerIn: parent
        z: 11
        border.color: "black"
        border.width: 2
    }

    // Row for current speed display (moved slightly below center)
    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.verticalCenter
        anchors.topMargin: strokeWidth * 2   // Pushes it below the center dot
        spacing: 4
        z: 12
        Text {
            text: Math.round(root.value)
            font.pixelSize: 28
            font.bold: true
            color: root.value > 120 ? "red" : "white"   // Changes color if > 120
        }
        Text {
            text: "km/h"
            font.pixelSize: 16
            color: "lightgray"
        }
    }


    Behavior on value {
        NumberAnimation { duration: 400 }
    }
}
