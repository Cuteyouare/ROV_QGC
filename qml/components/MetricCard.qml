import QtQuick
import QtQuick.Controls

Rectangle {
    required property string title
    required property string value
    property string unit: ""
    property color accent: "#28b9d7"
    radius: 10; color: "#182735"; border.color: "#294256"; border.width: 1
    implicitWidth: 185; implicitHeight: 112
    Rectangle { width: 4; height: parent.height - 28; anchors.left: parent.left; anchors.verticalCenter: parent.verticalCenter; radius: 2; color: parent.accent }
    Column {
        anchors { left: parent.left; leftMargin: 22; verticalCenter: parent.verticalCenter }
        spacing: 7
        Label { text: parent.title; color: "#9cb1c1"; font.pixelSize: 14 }
        Row { spacing: 5
            Label { text: parent.value; color: "#f1f7fb"; font.pixelSize: 30; font.bold: true }
            Label { text: parent.unit; anchors.baseline: parent.children[0].baseline; color: "#7f98aa"; font.pixelSize: 13 }
        }
    }
}
