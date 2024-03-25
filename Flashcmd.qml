import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Item {
    id: flashcmdid

    property real scalefactor : {
        if(Screen.width > 1920) return 1.2
        else if(Screen.height < 1080) return 0.8
        else return 1
    }

    height: Math.round(800*scalefactor)
    width: Math.round(800*scalefactor)
    visible: true

    Rectangle {
        id: homeid
        anchors.fill: parent
        border.color: "black"
        border.width: 1

        Rectangle {
            id:r1
            height: Math.round(25*scalefactor)
            width: Math.round(800*scalefactor)
            color: "#777f8c"

            Rectangle{
                Text {
                    id: txtid
                    text: qsTr(" Flash File")
                    font.family: "Helvetica"
                    font.pointSize: Screen.height * 0.013
                    color: "white"
                    anchors{
                        left: r1.left
                    }
                }
            }

            Rectangle {
                anchors{
                    right: r1.right
                }
                Button {
                    id: closeid
                    height: Math.round(25*scalefactor)
                    width: Math.round(25*scalefactor)
                    anchors.right: parent.right


                    Image {
                        id: close
                        source: "qrc:/Image/Close_red.png"
                        height: Math.round(25*scalefactor)
                        width: Math.round(25*scalefactor)
                        anchors.centerIn: closeid
                    }

                    onClicked: {
                        homeid.visible = false
                    }
                }
            }
        }

        ColumnLayout {
            spacing: 15
            y: parent.height * 0.04
            x: parent.width * 0.01
            Row {
                spacing: 13

                Label {
                    text: "Options"
                    font.pointSize: Screen.height * 0.013
                    font.family: "Helvetica"
                }

                ComboBox {
                    id: _comb
                    visible: true
                    width: Math.round(200*scalefactor)
                    model: ["Select","Windows", "Linux"]
                    font.family: "Helvetica"

                    onCurrentIndexChanged: {
                        if (currentIndex === 2) {
                            linuxTerminal.visible = true
                            windowsPromt.visible = false
                        } else if (currentIndex === 1) {
                            windowsPromt.visible = true
                            linuxTerminal.visible = false
                        }
                    }
                }
            }

            Rectangle {
                id: linuxTerminal
                visible: false
                height: Math.round(700*scalefactor)
                width: Math.round(785*scalefactor)

                Column {
                    spacing: 15

                    Text {
                        id: linuxid
                        text: qsTr("Linux Terminal")
                    }

                    Row {
                        id: rowid
                        spacing: 15

                        TextField {
                            id: commandInput
                            placeholderText: "Enter command..."
                            font.family: "Helvetica"
                            width: Math.round(630*scalefactor)
                        }

                        Button {
                            text: "Launch Command"
                            font.family: "Helvetica"
                            onClicked: {
                                launcher.launchCommand(commandInput.text);
                            }
                            enabled: commandInput.text.trim().length > 0
                        }
                    }

                    ScrollView {
                        y: parent.height * 0.1 // Adjust the position dynamically, here 0.1 indicates 10% from the top
                        width: parent.width
                        height: parent.height * 0.87

                        TextArea {
                            id: commandOutput
                            width: parent.width
                            height: contentHeight
                            readOnly: true
                            wrapMode: TextEdit.WordWrap
                            anchors.top: parent.top
                            textFormat: TextEdit.PlainText

                            background: Rectangle {
                                color: "black"
                            }
                            color: "white"
                        }
                    }
                }

                Connections {
                    target: launcher
                    onCommandOutputReady: {
                        commandOutput.text = output;
                    }
                }
            }

            Rectangle {
                id: windowsPromt
                visible: false
                height: Math.round(700*scalefactor)
                width: Math.round(785*scalefactor)

                Column {
                    spacing: 15

                    Text {
                        id: cmdpromtid
                        text: qsTr("Command Promt")
                    }

                    Row {
                        id: rowid1
                        spacing: 15

                        TextField {
                            id: promtcommandInput
                            placeholderText: "Enter command..."
                            font.family: "Helvetica"
                            width: Math.round(630*scalefactor)
                        }

                        Button {
                            text: "Launch Command"
                            font.family: "Helvetica"
                            onClicked: {
                                launcher.windowsPromt(promtcommandInput.text);
                            }
                            enabled: promtcommandInput.text.trim().length > 0
                        }
                    }

                    ScrollView {
                        y: parent.height * 0.1 // Adjust the position dynamically, here 0.1 indicates 10% from the top
                        width: parent.width
                        height: parent.height * 0.87

                        TextArea {
                            id: commandOutput1
                            width: parent.width
                            height: contentHeight
                            readOnly: true
                            wrapMode: TextEdit.WordWrap
                            anchors.top: parent.top
                            textFormat: TextEdit.PlainText

                            background: Rectangle {
                                color: "black"
                            }
                            color: "white"
                        }
                    }
                }

                Connections {
                    target: launcher
                    onCommandOutputReady: {
                        commandOutput1.text = output;
                    }
                }
            }
        }
    }
}

