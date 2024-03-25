import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: item
    property real scalefactor : {
        if(Screen.width > 1920) return 1.2
        else if(Screen.height < 1080) return 0.8
        else return 1
    }
    height: Math.round(800*scalefactor)
    width: Math.round(800*scalefactor)
    visible: true
    implicitWidth: pdfview.visible ? pdfview.width: parent.width
    implicitHeight: pdfview.visible ? pdfview.height: parent.height

    Rectangle {
        id:homePage
        anchors.fill: parent
        border.color: "black"
        border.width: 1

        Rectangle {
            id: rect1
            height: Math.round(25*scalefactor)
            width: Math.round(800*scalefactor)
            color: "#777f8c"

            Row {
                anchors.fill: parent
                spacing: 5

                Text {
                    id: txtid
                    text: qsTr(" Help")
                    font.family: "Helvetica"
                    font.pointSize: Screen.height * 0.013
                    color: "white"
                    anchors.left: parent.left
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
                        anchors.centerIn: parent
                    }

                    onClicked: {
                        homePage.visible = false
                    }
                }
            }
        }

        Rectangle {
            id: textrect
            width: parent.width
            height: t1.height
            anchors.top: rect1.bottom
            anchors.topMargin: rect1.height

            color: mouseArea.containsMouse ? "#cdcdcd" : "transparent"

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    homePage.visible=false;
                    pdfview.visible=true;
                }
            }

            Text {
                id: t1
                font.pixelSize: 24
                text: qsTr("User Guidelines")
            }
        }
    }

    Rectangle {
        id: pdfview
        visible: false;
        width: 1500
        height: 900
        anchors.centerIn: parent
        anchors.topMargin: 50 // Adjust the top margin as needed

        Flickable {
            anchors.fill: parent
            contentHeight: columnRects.height
            clip: true
            flickableDirection: Flickable.VerticalFlick

            Column {
                id: columnRects
                width: parent.width
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

                Image {
                    id: i1
                    source: "qrc:/Image/1.png"
                    width: columnRects.width
                    horizontalAlignment: Qt.AlignHCenter
                }
                Image {
                    id: i2
                    source: "qrc:/Image/2.png"
                    width: columnRects.width
                    horizontalAlignment: Qt.AlignHCenter
                }
                Image {
                    id: i3
                    source: "qrc:/Image/3.png"
                    width: columnRects.width
                    horizontalAlignment: Qt.AlignHCenter
                }
            }
        }

        Button {
            id: pdfcloseid
            width: 30
            height: 30
            anchors.right: parent.right
            anchors.top: parent.top

            Image {
                id: pdfclose
                source: "qrc:/Image/Close_red.png"
                width: 30
                height: 30
                anchors.centerIn: parent
            }

            onClicked: {
                pdfview.visible = false
                console.log("Closed")
            }
        }
    }
}
