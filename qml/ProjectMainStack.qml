import QtQuick 2.9
import QtQuick.Controls 2.4

Component {
    id:projectMainStack

//    function updatePortList() {
//        console.log("Opened")
//        var interfaceList = connectionFactory.getAvailableInterfacesToSerialPort()
//        console.log("SerialPorts: " + interfaceList);

//        portList.model.clear()
//        baudRateList.model.clear()

//        for(var it = 0; it<interfaceList.length; it++) {
//            portList.model.append({text: interfaceList[it]})
//        }
//        portList.currentIndex = 0

//        if(interfaceList.length > 0) {
//            baudRateList.model.append({text: "4800"})
//            baudRateList.model.append({text: "9600"})
//            baudRateList.model.append({text: "19200"})
//            baudRateList.model.append({text: "38400"})
//            baudRateList.model.append({text: "115200"})
//            baudRateList.model.append({text: "256000"})
//        }
//        baudRateList.currentIndex = 0;
//        onUpdated(interfaceList)
//    }

    Rectangle {
        id: projectDevicePanel
        color: "#ffffff"

        Rectangle {
            id: deviceList
            border.color: "#E0ECF8"
            height: parent.height - menuMain.height - viewForm.statusBarRecangle.height - deviceList.anchors.topMargin
            width: 200

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10

            ListView {
                id: listView
                clip: true
                maximumFlickVelocity: 0
                highlightFollowsCurrentItem: true
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.left: deviceList.left
                anchors.leftMargin: 5
                width: deviceList.width
                height: deviceList.height -5

                ScrollBar.vertical: ScrollBar {
                    id:scrollDeviceList
                    width: 20
                }

                spacing: 0
                delegate: Item {
                    id:item
                    height: 50
                    width: deviceList.width

                    MouseArea {
                        id:mouseArea
                        width: item.width
                        height: item.height
                        pressAndHoldInterval: 1000
                        Rectangle {
                            id:rect
                            width: item.width - 10
                            height: item.height
                            color: colorCode
                            gradient: Gradient {
                                GradientStop { position: 0 ; color: mouseArea.pressed ? "#ccc" : colorCode}
                                GradientStop { position: 1 ; color: mouseArea.pressed ? "#aaa" : "#FAFAFA" }
                            }
                            Label {
                                id: buttonText
                                text: name
                                font.bold: false
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                visible: false
                                text:identId
                            }
                        }
                        onClicked: {
                            for (var i = 0, l = listView.contentItem.children.length; i < l; i++) {
                                console.log("DeviceList clicked " + i + " " + identId)
                            }
                            if(parametersStackItem.depth <= 0) {
                                parametersStackItem.push(deviceControlLlsTmk24)
                            } else if(parametersStackItem.depth ===1) {
                                parametersStackItem.push(deviceControlLlsTmk24_2)
                            } else {
                                parametersStackItem.pop()
                            }
                        }
                    }
                }
                //                model: ListModel {
                //                    ListElement {
                //                        name: "COM9"
                //                        colorCode: "#81DAF5"
                //                        identId: "0"
                //                    }

                //                    ListElement {
                //                        name: "ТМК3.24 (ID-1)"
                //                        colorCode: "#FAFAFA"
                //                        identId: "1"
                //                    }

                //                    ListElement {
                //                        name: "ТМК3.24 (ID-2)"
                //                        colorCode: "#FAFAFA"
                //                        identId: "2"
                //                    }

                //                    ListElement {
                //                        name: "COM21"
                //                        colorCode: "#81DAF5"
                //                        identId: "3"
                //                    }

                //                    ListElement {
                //                        name: "ТМК3.24 (ID-1)"
                //                        colorCode: "#FAFAFA"
                //                        identId: "4"
                //                    }
                //                    ListElement {
                //                        name: "COM9"
                //                        colorCode: "#81DAF5"
                //                        identId: "5"
                //                    }

                //                    ListElement {
                //                        name: "ТМК3.24 (ID-1)"
                //                        colorCode: "#FAFAFA"
                //                        identId: "6"
                //                    }

                //                    ListElement {
                //                        name: "ТМК3.24 (ID-2)"
                //                        colorCode: "#FAFAFA"
                //                        identId: "7"
                //                    }
                //                }
            }
            function addInterface(arg) {

            }
        }


        Rectangle {
            id: currentStateRectangle
            width: 300
            color: "#fdfdfd"
            radius: 0
            border.width: 1
            border.color: "#9899a7"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10

            StackView {
                id: deviceTabParameters
                initialItem: parametersRectangle
                anchors.bottomMargin: 0
                anchors.fill: parent

                TabBar {
                    id: tabBar
                    anchors.left: parent.left
                    anchors.leftMargin: 1
                    anchors.right: parent.right
                    anchors.rightMargin: 1
                    anchors.top: parent.top
                    anchors.topMargin: 1

                    TabButton {
                        id: currentData
                        text: qsTr("Текущие данные")
                        focusPolicy: Qt.TabFocus
                    }

                    TabButton {
                        id: slaves
                        text: qsTr("Ведомые")
                    }

                    TabButton {
                        id: log
                        text: qsTr("Журнал")
                    }
                }
            }
        }

        Rectangle {
            id: parametersRectangle
            color: "#fdfdfd"
            border.color: "#81a8b9"
            anchors.right: currentStateRectangle.left
            anchors.rightMargin: 10
            anchors.left: deviceList.left
            anchors.leftMargin: -projectDevicePanel.width + deviceList.width + currentStateRectangle.width + 20

            StackView {
                id: parametersStackItem
                anchors.fill: parent
                initialItem: comPortControl
                clip: true

                Control {
                    id: comPortControl
                    Rectangle {
                        anchors.fill: parent
                        color: "#33ffff"
                    }
                }

                Control {
                    id: deviceControlLlsTmk24
                    Rectangle {
                        anchors.fill: parent
                        color: "#ff222f"
                    }
                }

                Control {
                    id: deviceControlLlsTmk24_2
                    Rectangle {
                        anchors.fill: parent
                        color: "#55222f"
                    }
                }
            }
        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
