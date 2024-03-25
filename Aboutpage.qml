import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: windowid
    property real scalefactor : {
        if(Screen.width > 1920) return 1.2
        else if(Screen.height < 1080) return 0.8
        else return 1
    }
    height: Math.round(800*scalefactor)
    width: Math.round(800*scalefactor)
    visible: true

    Rectangle {
        id:homePage
        anchors.fill: parent
        border.color: "black"
        border.width: 1

        Rectangle {
            height: Math.round(25*scalefactor)
            width: Math.round(800*scalefactor)
            color: "#777F8C"

            Row {
                spacing: parent.width * 0.9
                Text {
                    id: txtid
                    text: qsTr(" About")
                    font.family: "Helvetica"
                    font.pointSize: Screen.height * 0.013
                    color: "white"
                }

                Button {
                    id: closeid
                    height: Math.round(25*scalefactor)
                    width: Math.round(25*scalefactor)
                    anchors.rightMargin: 10

                    Image {
                        id: close
                        source: "qrc:/Image/Close_red.png"
                        height: Math.round(25*scalefactor)
                        width: Math.round(25*scalefactor)
                        anchors.centerIn: closeid
                    }

                    onClicked: {
                        homePage.visible = false
                    }
                }
            }
        }

        Image {
            id: logoid
            source: "qrc:/Image/flash1.png"
            height: Math.round(150*scalefactor)
            width: Math.round(150*scalefactor)

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: Math.round(0.375 * parent.height)
            anchors.leftMargin: Math.round(0.1375 * parent.width)
        }

        Column {
            spacing: 5
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: Math.round(0.375 * parent.height)
            anchors.rightMargin: Math.round(0.1625 * parent.width)

            Label {
                id: textid
                text: "UUU Tool 1.0.0"
                font.family: "Helvetica"
                font.pointSize: Screen.height * 0.016
                font.bold: true
            }
            Label {
                id: text1id
                text: "Built on Nov 15 2023 12:20:33 PM"
                font.family: "Helvetica"
                font.pointSize: Screen.height * 0.016

            }
            Label {
                id: text2id
                text: "Copyright 2024-2025 Airaa Corporates \nLLP. All rights reserved."
                font.family: "Helvetica"
                font.pointSize: Screen.height * 0.016

            }
        }
        Button {
            id: closedid
            text: "Close"
            font.family: "Helvetica"
            height: Math.round(35*scalefactor)
            width: Math.round(150*scalefactor)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Math.round(0.1 * parent.height)
            anchors.right: parent.right
            anchors.rightMargin: Math.round(0.1 * parent.width)
            onClicked: {
                homePage.visible = false
            }
        }
    }
}
