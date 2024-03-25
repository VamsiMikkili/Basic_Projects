import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 6.6
import com.airaacorporates

Rectangle {
    id: protocolid
    property real scalefactor : {
        if(Screen.width > 1920) return 1.2
        else if(Screen.height < 1080) return 0.8
        else return 1
    }
    height: Math.round(800*scalefactor)
    width: Math.round(800*scalefactor)

    function showPopup(message, color) {
        popupText.text = message
        popup.color = color
        popup.visible = true
        popupTimer.restart()
    }

    Rectangle {
        id: rectid1
        height: Math.round(800*scalefactor)
        width: Math.round(800*scalefactor)
        visible: true
        anchors.centerIn: parent

        Popup {
            onClosed: {
                dynamicTextField.text = "";
                errorLabelContainer.visible = false;
            }
        }

        SerialCommunication {
            id: serialComm
        }

        Rectangle {
            id: homePage
            anchors.fill: parent
            border.color: "black"
            border.width: 1

            Rectangle {
                height: Math.round(25*scalefactor)
                width: Math.round(800*scalefactor)
                color: "#777f8c"

                Button {
                    id: closeId
                    height: Math.round(25*scalefactor)
                    width: Math.round(25*scalefactor)
                    x: Math.round(775 * scalefactor)

                    Image {
                        id: closeImage
                        source: "qrc:/Image/Close_red.png"
                        height: Math.round(25*scalefactor)
                        width: Math.round(25*scalefactor)
                        anchors.right: parent.right
                    }

                    onClicked: {
                        homePage.visible = false
                    }
                }

                Text {
                    id: protocolTextId
                    text: qsTr("Communication Channels")
                    font.family: "Helvetica"
                    color: "white"
                    font.pointSize: Screen.height * 0.013
                }

                Text {
                    x: 10
                    id: protocolTextId1
                    text: qsTr("Please Choose Your Communication Channel...")
                    font.family: "Helvetica"
                    font.pointSize: Screen.height * 0.017
                    anchors.top: protocolTextId.bottom
                    anchors.topMargin: Math.round(50 * scalefactor)
                }

                ComboBox {
                    id: protocolComboId
                    visible: true
                    width: Math.round(200*scalefactor)
                    anchors.left: protocolTextId1.right
                    anchors.top: protocolTextId.bottom
                    anchors.topMargin: Math.round(50* scalefactor)
                    anchors.leftMargin: Math.round(20 * scalefactor)
                    anchors.rightMargin: Math.round(10 * scalefactor)
                    model: ["Select", "RS232", "I2C", "SPI"]
                    font.family: "Helvetica"
                    font.pointSize: Screen.height * 0.014
                }

                Button {
                    id: proceedButton
                    text: "Proceed"
                    font.family: "Helvetica"
                    height: Math.round(40*scalefactor)
                    width: Math.round(170*scalefactor)
                    anchors {
                        right: deviceRect.right
                        bottom: deviceRect.bottom
                        rightMargin: Math.round(100 * scalefactor)
                        bottomMargin: Math.round(10 * scalefactor)
                    }

                    onClicked: {
                        if (protocolComboId.currentIndex === 0) {
                            showPopup("Please select any Communiation channel...", "red")
                        } else {
                            deviceRect.visible = true
                        }
                    }
                }

                Rectangle {
                    id: deviceRect
                    height: Math.round(600*scalefactor)
                    width: Math.round(800*scalefactor)
                    y: Math.round(26 * scalefactor)
                    visible: false

                    Button {
                        id:bb
                        height: 25;
                        width: 25;
                        y:27
                        ToolTip.delay: 1000
                        ToolTip.visible: hovered
                        ToolTip.text: "GO back one page "
                        background: Rectangle {
                            color: "#777f8c"
                            border.color: "black"
                            radius: 5
                        }
                        Image {
                            id: bbimage
                            height: 25;
                            width: 25;
                            source: "qrc:/Image/BackButton.png"
                        }

                        contentItem: Text {
                            text: bb.text
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                        }
                        onClicked: {
                            homePage.visible = true
                            deviceRect.visible = false
                        }
                    }

                    Text {
                        id: deviceText
                        text: qsTr("Connect your device")
                        font.pointSize: Screen.height * 0.040
                        font.family: "Helvetica"
                        x: Math.round(170 * scalefactor)
                        y: Math.round(100 * scalefactor)
                    }

                    Column {
                        spacing: Math.round(10 * scalefactor)
                        anchors.centerIn: parent
                        anchors {
                            top: deviceText.bottom
                            horizontalCenter: parent.horizontalCenter
                        }

                        Row {
                            spacing: Math.round(5 * scalefactor)

                            Text {
                                text: "Port Number:"
                                font.family: "Helvetica"
                                font.pointSize: Screen.height * 0.020
                                width: Math.round(190*scalefactor)
                            }

                            TextField {
                                id: portNameTextField
                                height: Math.round(60*scalefactor)
                                width: Math.round(260*scalefactor)
                                placeholderText: "Enter Port Number"
                                font.family: "Helvetica"
                                font.pointSize: Screen.height * 0.017
                            }
                        }

                        Row {
                            spacing: Math.round(5 * scalefactor)

                            Text {
                                text: "Frequency:"
                                font.family: "Helvetica"
                                font.pointSize: Screen.height * 0.020
                                width: Math.round(190*scalefactor)
                            }

                            TextField {
                                id: baudRateTextField
                                height: Math.round(60*scalefactor)
                                width: Math.round(260*scalefactor)
                                placeholderText: "Enter Frequency Rate"
                                font.family: "Helvetica"
                                font.pointSize: Screen.height * 0.017
                            }
                        }
                    }

                    Button {
                        id: connectButton
                        text: "Connect"
                        font.family: "Helvetica"
                        height: Math.round(60*scalefactor)
                        width: Math.round(260*scalefactor)
                        y: Math.round(550 * scalefactor)
                        x: Math.round(270 * scalefactor)

                        onClicked: {
                            if (portNameTextField.text.trim() === "" || baudRateTextField.text.trim() === "") {
                                showPopup("Please provide PORT NUMBER AND FREQUENCY", "red")
                            } else {
                                serialComm.connectSerial(portNameTextField.text,baudRateTextField.text);
                                sendDataButton.visible = true
                                closeSerialButton.visible = true
                                connectButton.visible = false
                            }
                        }
                    }

                    Row {
                        spacing: Math.round(15 * scalefactor)
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.bottom
                            bottomMargin: Math.round(10 * scalefactor)
                        }

                        Button {
                            id: sendDataButton
                            text: "Send Data"
                            font.family: "Helvetica"
                            height: Math.round(60*scalefactor)
                            width: Math.round(160*scalefactor)
                            visible: serialComm.isPortConnected()
                            onClicked: {
                                rowId1.visible = true
                            }
                        }
                        Button {
                            id: closeSerialButton
                            text: "Close SerialPort"
                            font.family: "Helvetica"
                            height: Math.round(60*scalefactor)
                            width: Math.round(160*scalefactor)
                             visible: serialComm.isPortConnected()
                            onClicked: {
                                serialComm.closeSerial()
                            }
                        }
                    }

                    Popup {
                        onClosed: {
                            dynamicTextField.text = ""
                        }
                    }
                }
            }

            Button {
                id: closeId1
                height: Math.round(25*scalefactor)
                width: Math.round(25*scalefactor)
                x: Math.round(775 * scalefactor)

                Image {
                    id: close1
                    source: "qrc:/Image/Close_red.png"
                    height: Math.round(25*scalefactor)
                    width: Math.round(25*scalefactor)
                    anchors.centerIn: closeId1
                }

                onClicked: {
                    protocolid.visible = false
                }
            }
        }
    }

    Rectangle {
        id: popup
        width: 450
        height: 50
        color: "transparent"
        border.color: "black"
        radius: 10
        visible: false

        y: Math.round(-85 * scalefactor)
        x: Math.round(200 * scalefactor)

        Text {
            id: popupText
            anchors.centerIn: parent
            font.bold: true
            font.pixelSize: 18
            color: "white"
            text: ""
        }

        Timer {
            id: popupTimer
            interval: 1500
            onTriggered: popup.visible = false
        }
    }

    Item {
        id: errorLabelContainer
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: Math.round(-90 * scalefactor)
        }
        visible: false

        Rectangle {
            height: Math.round(50*scalefactor)
            width: Math.round(530*scalefactor)
            color: "#ff6347"
            radius: 8

            Text {
                id: errorLabel
                text: errorLabel.text
                color: "black"
                anchors.centerIn: parent
                font.bold: parent
                font.pointSize: Screen.height * 0.014
            }
        }
    }

    Row {
        id: rowId1
        spacing: Math.round(12 * scalefactor)
        visible: false
        anchors.top: protocolid.bottom
        anchors.topMargin: Math.round(10 * scalefactor)

        TextField {
            id: filePathInput
            width: 500
            placeholderText: "Enter file path(s)"
        }

        Button {
            id: sendFileButton
            width: 150
            height: 30
            text: "Send File(s)"
            onClicked: {
                var paths = filePathInput.text.trim().split(","); // Split input by comma to get multiple paths

                for (var i = 0; i < paths.length; i++) {
                    var path = paths[i].trim();
                    console.log("Path:", path); // Debug statement

                    if (path !== "" && path !== undefined) {
                        console.log("Sending file or folder:", path); // Debug statement
                        serialComm.sendFile(path); // Send the file or folder
                    } else {
                        console.log("Please enter a valid file path."); // Log error message
                    }
                }
            }
        }
    }
}
