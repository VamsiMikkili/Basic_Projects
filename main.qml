import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 6.6
import Obj 1.0

ApplicationWindow {
    id: windowid
    title: " UUU Tool"
    visible: true

    property real scalefactor : {
        if(Screen.width > 1920) return 1.2
        else if(Screen.height < 1080) return 0.8
        else return 1
    }

    height: Math.round(1080*scalefactor)
    width: Math.round(1920*scalefactor)

    flags: Qt.Window | Qt.FramelessWindowHint

    Rectangle {
        id: _rect
        color: "red"
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#5bccf6" }
            GradientStop { position: 1.0; color: "white" }
        }

        Image {
            id: _image
            source: "qrc:/Image/Airaa_Logo.png"
            x: (_rect.width / 2) - width / 2
            height: Screen.height * 0.1 *scalefactor
            width: Screen.width * 0.2 * scalefactor
            anchors.bottom: _text.top
        }

        Text {
            id: _text
            text: qsTr("MFG FLASH TOOL")
            anchors.centerIn: parent
            font.bold: true
            font.family: "Helvetica"
            font.pointSize: Screen.height * 0.04 * scalefactor//50
        }

        Timer {
            interval: 5000 // 5 seconds (in milliseconds)
            running: true
            repeat: false
            onTriggered: {
                _rect.visible = false; // Hide the Rectangle
                mainwindid.visible = true;
            }
        }

        MouseArea {
            anchors.fill:parent
            onClicked: {
                mainwindid.visible = true
                _rect.visible = false
            }
        }
    }
    Rectangle {
        id: popupRect1
        height: Math.round(200*scalefactor)
        width: Math.round(300*scalefactor)
        visible: false
        anchors.centerIn: parent

        Objref {
            id: ref
        }

        function handleStatus(changePopup, notifyConnect, rectColor) {
            myPopup.visible = changePopup === "true";
            popuptxt.text = notifyConnect;
            popuprect.color = rectColor;
        }

        Component.onCompleted: {
            ref.status.connect(handleStatus);
        }

        Popup {
            id: myPopup
            visible: false
            height: Math.round(60*scalefactor)
            width: Math.round(160*scalefactor)

            Rectangle {
                id: popuprect
                visible: true
                height: Math.round(61*scalefactor)
                width: Math.round(161*scalefactor)
                anchors.centerIn: parent

                Text {
                    id: popuptxt
                    text: ""
                    color: "black"
                    anchors.centerIn: parent
                }
            }
            modal: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        }
    }


    Item {
        id: mainwindid
        anchors.fill: parent
        visible: false

        Rectangle {
            id: titlebarid
            width: Screen.width * 2
            height: Screen.height * 3
            color: "#F0F0F0"

            Image {
                id: logoid
                source: "qrc:/Image/flash1.png"
                width: Screen.width * 0.015
                height: Screen.height * 0.02
                anchors.left: parent.left
                anchors.leftMargin: Screen.width * 0.008
            }

            Label {
                id: titleid
                text: "UUU Flash Tool"
                font.family: "Helvetica"
                font.pointSize: Screen.height * 0.01
                anchors.left: logoid.right
                anchors.leftMargin: Screen.width * 0.005
            }

            Row {
                x: Screen.width * 0.90
                spacing: Screen.width * 0.01

                Button {
                    id: miniid
                    height: Math.round(30*scalefactor)
                    width: Math.round(25*scalefactor)
                    background: Rectangle {
                        color: "#F0F0F0"
                    }

                    Image {
                        source: "qrc:/Image/minid.png"
                        height: Math.round(30*scalefactor)
                        width: Math.round(25*scalefactor)
                        anchors.centerIn: miniid
                    }

                    onClicked: {
                        windowid.visibility = Window.Minimized

                    }
                }

                Button {
                    id: maxid
                    width: 25
                    height: 30
                    background: Rectangle {
                        color: "#F0F0F0"
                    }

                    Image {
                        source: "qrc:/Image/maxid.png"
                        height: Math.round(30*scalefactor)
                        width: Math.round(25*scalefactor)
                        anchors.centerIn: maxid
                    }

                    onClicked: {
                        windowid.visibility === Window.Maximized ? windowid.showNormal() : windowid.showMaximized()
                    }
                }

                Button {
                    id: closeid
                    height: Math.round(30*scalefactor)
                    width: Math.round(25*scalefactor)
                    background: Rectangle {
                        color: "#F0F0F0"
                    }

                    Image {
                        source: "qrc:/Image/closeid.png"
                        height: Math.round(20*scalefactor)
                        width: Math.round(20*scalefactor)
                        anchors.centerIn: closeid
                    }

                    onClicked: {
                        confirmationDialog.open()
                    }

                    Dialog {
                        id: confirmationDialogid
                        x: (parent.width - width) / 2
                        y: (parent.height - height) / 2
                        parent: Overlay.overlay

                        modal: true
                        title: "Closing Application"
                        font.pointSize: Screen.height * 0.010
                        font.family: "Helvetica"
                        standardButtons: Dialog.Ok | Dialog.Cancel

                        onAccepted: {
                            Qt.quit()
                        }

                        onRejected: {
                            confirmationDialogid.close()
                        }

                        Row {
                            spacing: 2
                            Image {
                                id: questmark1id
                                source: "qrc:/Image/QuestionMark.png"
                                height: Math.round(30*scalefactor)
                                width: Math.round(30*scalefactor)
                            }

                            Label {
                                text: "Are you sure?"
                                font.family: "Helvetica"
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: homepageid
            y: Screen.height * 0.04 * scalefactor// 40
            color: "#000064"
            width: Screen.width * 2
            height: Screen.height * 3

            TabBar {
                id: tabBarid
                currentIndex: 6
                width: Screen.width * 2

                TabButton {
                    id: tb1
                    width: Screen.width / 7.3
                    height: Math.round(40*scalefactor)

                    Label {
                        id: lblid1
                        text: "Open"
                        color: "black"
                        font.pointSize: Screen.height * 0.016
                        font.family: "Helvetica"
                        anchors.centerIn: tb1
                    }

                    background: Rectangle {
                        id: rectid0
                        color: "#d9d9d9"
                        width: tabBarid.width
                    }

                    onClicked: {
                        rectid0.color = "#777f8c"
                        lblid1.color = "white"

                        lblid2.color = "black"
                        rectid1.color = "#d9d9d9"
                        lblid3.color = "black"
                        rectid2.color = "#d9d9d9"
                        lblid4.color = "black"
                        rectid3.color = "#d9d9d9"
                        lblid5.color = "black"
                        rectid4.color = "#d9d9d9"
                        lblid6.color = "black"
                        rectid5.color = "#d9d9d9"
                        cmnchan.color = "#d9d9d9"
                        cmnch.color = "black"

                        mstackid.push("qrc:/Openfile.qml")
                    }
                }

                TabButton {
                    property int i: 0
                    id: tb2
                    width: Screen.width / 7.3
                    height: Math.round(40*scalefactor)

                    Label {
                        id: lblid2
                        text: "Setting"
                        color: "black"
                        font.family: "Helvetica"
                        font.pointSize: Screen.height * 0.016
                        anchors.centerIn: tb2
                    }

                    background: Rectangle {
                        id: rectid1
                        color: "#d9d9d9"
                        width: tabBarid.width
                    }

                    onClicked: {
                        rectid1.color = "#777f8c"
                        lblid2.color = "white"

                        lblid1.color = "black"
                        rectid0.color = "#d9d9d9"
                        lblid3.color = "black"
                        rectid2.color = "#d9d9d9"
                        lblid4.color = "black"
                        rectid3.color = "#d9d9d9"
                        lblid5.color = "black"
                        rectid4.color = "#d9d9d9"
                        lblid6.color = "black"
                        rectid5.color = "#d9d9d9"
                        cmnchan.color = "#d9d9d9"
                        cmnch.color = "black"

                        if (i == 0) {
                            mstackid.push("qrc:/Settingspage.qml")
                        }
                        else {
                            mstackid.pushExit
                        }
                    }
                }

                TabButton {
                    id: tb3
                    width: Screen.width / 7.3
                    height: Math.round(40*scalefactor)

                    Label {
                        id: lblid3
                        text: "Flash Command"
                        color: "black"
                        font.family: "Helvetica"
                        font.pointSize: Screen.height * 0.016
                        anchors.centerIn: tb3
                    }

                    background: Rectangle {
                        id: rectid2
                        color: "#d9d9d9"
                        width: tabBarid.width
                    }

                    onClicked: {
                        rectid2.color = "#777f8c"
                        lblid3.color = "white"

                        lblid2.color = "black"
                        rectid1.color = "#d9d9d9"
                        lblid1.color = "black"
                        rectid0.color = "#d9d9d9"
                        lblid4.color = "black"
                        rectid3.color = "#d9d9d9"
                        lblid5.color = "black"
                        rectid4.color = "#d9d9d9"
                        lblid6.color = "black"
                        rectid5.color = "#d9d9d9"
                        cmnchan.color = "#d9d9d9"
                        cmnch.color = "black"

                        mstackid.push("qrc:/Flashcmd.qml")
                    }
                }

                TabButton {
                    id: tb9
                    width: Screen.width / 7.3
                    height: Math.round(40*scalefactor)

                    Label {
                        id: cmnch
                        text: "Communication Channel"
                        color: "black"
                        font.family: "Helvetica"
                        font.pointSize: Screen.height * 0.016
                        anchors.centerIn: tb9
                    }

                    background: Rectangle {
                        id: cmnchan
                        color: "#d9d9d9"
                        width: tabBarid.width
                    }

                    onClicked: {
                        cmnchan.color = "#777f8c"
                        cmnch.color = "white"

                        lblid2.color = "black"
                        rectid1.color = "#d9d9d9"
                        lblid1.color = "black"
                        rectid0.color = "#d9d9d9"
                        lblid4.color = "black"
                        rectid3.color = "#d9d9d9"
                        lblid5.color = "black"
                        rectid4.color = "#d9d9d9"
                        lblid6.color = "black"
                        rectid5.color = "#d9d9d9"
                        rectid2.color = "#d9d9d9"
                        lblid3.color = "black"

                        mstackid.push("qrc:/Communication.qml")

                    }
                }

                TabButton {
                    id: tb4
                    width: Screen.width / 7.3
                    height: Math.round(40*scalefactor)
                    Label {
                        id: lblid4
                        text: "Help"
                        font.family: "Helvetica"
                        color: "black"
                        font.pointSize: Screen.height * 0.016
                        anchors.centerIn: tb4
                    }

                    background: Rectangle {
                        id: rectid3
                        color: "#d9d9d9"
                        width: tabBarid.width
                    }

                    onClicked: {
                        rectid3.color = "#777f8c"
                        lblid4.color = "white"

                        lblid2.color = "black"
                        rectid1.color = "#d9d9d9"
                        lblid3.color = "black"
                        rectid2.color = "#d9d9d9"
                        lblid1.color = "black"
                        rectid0.color = "#d9d9d9"
                        lblid5.color = "black"
                        rectid4.color = "#d9d9d9"
                        lblid6.color = "black"
                        rectid5.color = "#d9d9d9"
                        cmnchan.color = "#d9d9d9"
                        cmnch.color = "black"

                        mstackid.push("qrc:/Helppage.qml")
                    }
                }

                TabButton {
                    id: tb5
                    width: Screen.width / 7.3
                    height: Math.round(40*scalefactor)

                    Label {
                        id: lblid5
                        text: "About"
                        color: "black"
                        font.family: "Helvetica"
                        font.pointSize: Screen.height * 0.016
                        anchors.centerIn: tb5
                    }

                    background: Rectangle {
                        id: rectid4
                        color: "#d9d9d9"
                        width: tabBarid.width
                    }

                    onClicked: {
                        rectid4.color = "#777f8c"
                        lblid5.color = "white"

                        lblid2.color = "black"
                        rectid1.color = "#d9d9d9"
                        lblid3.color = "black"
                        rectid2.color = "#d9d9d9"
                        lblid4.color = "black"
                        rectid3.color = "#d9d9d9"
                        lblid1.color = "black"
                        rectid0.color = "#d9d9d9"
                        lblid6.color = "black"
                        rectid5.color = "#d9d9d9"
                        cmnchan.color = "#d9d9d9"
                        cmnch.color = "black"

                        mstackid.push("qrc:/Aboutpage.qml")
                    }
                }

                TabButton {
                    id: tb6
                    width: Screen.width / 7.3
                    height: Math.round(40*scalefactor)

                    Label {
                        id: lblid6
                        text: "Exit"
                        color: "black"
                        font.family: "Helvetica"
                        font.pointSize: Screen.height * 0.016
                        anchors.centerIn: tb6
                    }

                    background: Rectangle {
                        id: rectid5
                        color: "#d9d9d9"
                        width: tabBarid.width
                    }

                    onClicked: confirmationDialog.open()

                    Dialog {
                        id: confirmationDialog
                        height: Math.round(150*scalefactor)
                        width: Math.round(310*scalefactor)

                        x: (parent.width - width) / 2
                        y: (parent.height - height) / 2
                        parent: Overlay.overlay

                        modal: true
                        title: "Closing Application"
                        font.family: "Helvetica"
                        font.pointSize: Screen.height * 0.012
                        standardButtons: Dialog.Ok | Dialog.Cancel

                        onAccepted: {
                            Qt.quit()
                        }

                        onRejected: {
                            confirmationDialog.close()
                        }


                        Row {
                            spacing: 10
                            Image {
                                id: questmarkid
                                source: "qrc:/Image/QuestionMark.png"
                                height: Math.round(30*scalefactor)
                                width: Math.round(30*scalefactor)
                            }

                            Label {
                                text: "Are you sure?"
                                font.pointSize: Screen.height * 0.012
                                font.family: "Helvetica"
                            }
                        }
                    }
                }
            }
        }
    }

    StackView {
        id: mstackid

        anchors {
            left: parent.left
            top: parent.top
            leftMargin: Math.round(500 * scalefactor)
            topMargin: Math.round(200 * scalefactor)
        }
        pushEnter: Transition {
            NumberAnimation {
                properties: "opacity"
                easing.type: Easing.Linear
                duration: 100
            }
        }

        pushExit: Transition {
            NumberAnimation {
                properties: "opacity"
                easing.type: Easing.Linear
                duration: 100
            }
        }

        popEnter: Transition {
            NumberAnimation {
                properties: "opacity"
                easing.type: Easing.Linear
                duration: 100
            }
        }

        popExit: Transition {
            NumberAnimation {
                properties: "opacity"
                easing.type: Easing.Linear
                duration: 100
            }
        }
    }
}
