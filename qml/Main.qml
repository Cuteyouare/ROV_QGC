import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    visible: true; width: 1440; height: 900; minimumWidth: 1080; minimumHeight: 680
    title: "ROV 岸端操作与监控系统"
    color: "#0c1721"
    property string notice: "系统就绪：等待连接"

    Connections { target: rovStatus; function onCommandSent(message) { window.notice = message } }
    header: ToolBar {
        height: 68; background: Rectangle { color: "#101f2c"; border.color: "#253d4e" }
        RowLayout { anchors.fill: parent; anchors.leftMargin: 26; anchors.rightMargin: 26
            Label { text: "ROV  岸端操作与监控系统"; color: "#f5fbff"; font.pixelSize: 22; font.bold: true }
            Item { Layout.fillWidth: true }
            Label { text: rovStatus.linkState; color: rovStatus.connected ? "#42d392" : "#ffb84d"; font.pixelSize: 14 }
            Button { text: rovStatus.connected ? "断开连接" : "连接 ROV"; onClicked: rovStatus.toggleConnection() }
        }
    }
    footer: Rectangle { height: 32; color: "#101f2c"; Label { anchors.centerIn: parent; text: window.notice; color: "#98adbd"; font.pixelSize: 13 } }

    RowLayout { anchors.fill: parent; anchors.margins: 22; spacing: 18
        Rectangle { Layout.preferredWidth: 190; Layout.fillHeight: true; radius: 10; color: "#101f2c"
            Column { anchors.fill: parent; anchors.margins: 14; spacing: 8
                Label { text: "导航"; color: "#71899b"; font.pixelSize: 13 }
                Repeater { model: ["实时监控", "任务与航迹", "视频监控", "报警与日志", "设备设置"]
                    delegate: Rectangle { width: 162; height: 44; radius: 7; color: index === 0 ? "#16455b" : "transparent"
                        Label { anchors.centerIn: parent; text: modelData; color: index === 0 ? "#e8f9ff" : "#a8bdcb"; font.pixelSize: 15 }
                    }
                }
            }
        }
        ColumnLayout { Layout.fillWidth: true; Layout.fillHeight: true; spacing: 18
            RowLayout { Layout.fillWidth: true
                Label { text: "实时监控"; color: "#eaf5fb"; font.pixelSize: 25; font.bold: true }
                Item { Layout.fillWidth: true }
                Label { text: rovStatus.connected ? "遥测刷新 4 Hz" : "离线模式"; color: "#71899b" }
            }
            GridLayout { columns: width > 900 ? 4 : 2; Layout.fillWidth: true; columnSpacing: 14; rowSpacing: 14
                MetricCard { title: "深度"; value: rovStatus.depth.toFixed(1); unit: "m"; accent: "#28b9d7" }
                MetricCard { title: "航向"; value: rovStatus.heading.toFixed(0); unit: "°"; accent: "#7d9cff" }
                MetricCard { title: "电池电压"; value: rovStatus.voltage.toFixed(1); unit: "V"; accent: "#42d392" }
                MetricCard { title: "电流"; value: rovStatus.current.toFixed(1); unit: "A"; accent: "#ffb84d" }
            }
            RowLayout { Layout.fillWidth: true; Layout.fillHeight: true; spacing: 18
                Rectangle { Layout.fillWidth: true; Layout.fillHeight: true; radius: 10; color: "#101f2c"; border.color: "#294256"
                    Column { anchors.centerIn: parent; spacing: 10
                        Label { anchors.horizontalCenter: parent.horizontalCenter; text: "姿态与深度"; color: "#b9ccd8"; font.pixelSize: 17 }
                        Label { anchors.horizontalCenter: parent.horizontalCenter; text: "ROLL  %1°     PITCH  %2°".arg(rovStatus.roll.toFixed(1)).arg(rovStatus.pitch.toFixed(1)); color: "#eaf5fb"; font.pixelSize: 22 }
                        Label { anchors.horizontalCenter: parent.horizontalCenter; text: "◉"; color: "#28b9d7"; font.pixelSize: 105 }
                    }
                }
                Rectangle { Layout.preferredWidth: 300; Layout.fillHeight: true; radius: 10; color: "#101f2c"; border.color: "#294256"
                    Column { anchors.fill: parent; anchors.margins: 18; spacing: 16
                        Label { text: "快捷控制"; color: "#eaf5fb"; font.pixelSize: 18; font.bold: true }
                        Repeater { model: ["解锁 / 上锁", "保持深度", "返航", "紧急停止"]
                            delegate: Button { width: 264; height: 48; text: modelData; enabled: rovStatus.connected; onClicked: rovStatus.sendCommand(modelData) }
                        }
                    }
                }
            }
        }
    }
}
