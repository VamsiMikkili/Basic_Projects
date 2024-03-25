import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15

Item {
    id: settid

    property real scalefactor : {
        if(Screen.width > 1920) return 1.2
        else if(Screen.height < 1080) return 0.8
        else return 1
    }
    height: Math.round(800*scalefactor)
    width: Math.round(800*scalefactor)
    visible: true

    property var previousSerialPortInfoList: []  //to store the data

    function clearData() {
        serialPortInfoViewer.clearData();
    }

    function openTerminalBasedOnOS() {
        var selectedOS = _comb.currentText;
        console.log("Selected OS: " + selectedOS);

        if (selectedOS === "Windows") {
            terminalController.openTerminal("Windows");
        } else if (selectedOS === "Linux") {
            terminalController.openTerminal("Linux");
        }
    }

    Rectangle {
        id: homeid
        anchors.fill: parent
        border.color: "black"
        border.width: 1

        Rectangle {
            height: Math.round(25*scalefactor)
            width: Math.round(800*scalefactor)
            visible: true
            id:one
            color: "#777f8c"

            Row {
                spacing: parent.width * 0.890

                Text {
                    id: txtid
                    text: qsTr(" Setting")
                    font.family: "Helvetica"
                    font.pointSize: Screen.height * 0.013
                    color: "white"
                }

                Button {
                    id: closeid
                    height: Math.round(25*scalefactor)
                    width: Math.round(25*scalefactor)

                    Image {
                        id: close
                        source: "qrc:/Image/Close_red.png"
                        height: Math.round(25*scalefactor)
                        width: Math.round(25*scalefactor)
                        anchors.centerIn: closeid
                    }
                    onClicked: {
                        settid.visible = false
                    }
                }
            }
        }

        Text {
            anchors {
                top: one.bottom
                left: parent.left
                topMargin: Math.round(35 * scalefactor)
                leftMargin: Math.round(20 * scalefactor)
            }


            id: deviceInfoRect
            text: qsTr("Device Info")
            font.pointSize: Screen.height * 0.013
            font.family: "Helvetica"
        }
        Rectangle {
            height: Math.round(450*scalefactor)
            width: Math.round(700*scalefactor)
            anchors {
                left: parent.left
                leftMargin: Math.round(20 * scalefactor)
                top: deviceInfoRect.bottom
                topMargin: Math.round(40 * scalefactor)
            }

            border.color: "black"
            Repeater {
                model: serialPortInfoViewer ? serialPortInfoViewer.serialPortInfoList : []
                MouseArea {

                    anchors.fill: parent
                    onClicked: {
                        serialPortInfoViewer.showDeviceInfo(modelData["portName"]);
                    }

                    Text {
                        anchors.centerIn: parent
                        textFormat: Text.RichText
                        text: {
                            var info = modelData;
                            var serialNumber = info["serialNumber"] || "Not Available";
                            return "Port Name: " + info["portName"] +
                                    "<br>Operating System: " + serialPortInfoViewer.serialPortInfoList[0].os +
                                    "<br>Location: " + info["location"] +
                                    "<br>Description: " + info["description"] +
                                    "<br>Manufacturer: " + info["manufacturer"] +
                                    "<br>Serial number: " + serialNumber +
                                    "<br>Vendor Identifier: " + info["vendorIdentifier"] +
                                    "<br>Product Identifier: " + info["productIdentifier"];
                        }
                    }
                }
            }
        }

        RowLayout {
            spacing: 5
            anchors {
                bottom: parent.bottom
                bottomMargin: Math.round(20 * scalefactor)
                horizontalCenter: parent.horizontalCenter
            }

            Button {
                text: "OK"
                font.family: "Helvetica"
                height: Math.round(30*scalefactor)
                width: Math.round(150*scalefactor)
                onClicked: {
                }
            }

            Button {
                text: "Cancel"
                font.family: "Helvetica"
                height: Math.round(30*scalefactor)
                width: Math.round(150*scalefactor)
                onClicked: {
                    settid.visible = false;
                }
            }
        }

        Connections {
            target: serialPortInfoViewer
            onSerialPortInfoChanged: {
                // Check if the data has changed before updating the UI
                if (serialPortInfoViewer.serialPortInfoList !== previousSerialPortInfoList) {
                    console.log("Serial port info changed");
                    // Update UI or emit signals here
                    previousSerialPortInfoList = serialPortInfoViewer.serialPortInfoList;
                }
            }

            onConnectionStateChanged: {
                //connection state changes here
                if (serialPortInfoViewer.isConnected) {
                    console.log("Device connected");
                } else {
                    console.log("Device disconnected");
                }
            }
        }
    }
}
