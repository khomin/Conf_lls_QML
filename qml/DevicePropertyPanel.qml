import QtQuick 2.4
import QtQuick.Controls 2.3
import Qt.labs.platform 1.0
import QtQuick.Dialogs 1.2
import QtQml.Models 2.11

Rectangle {
    id: projectDevicePanel
    property alias dialogAddDeviceFail : dialogAddDeviceFail
    property alias dialogAddInterfaceFail: dialogAddInterfaceFail
    property alias messageOperationError: messageOperationError
    property DevPropertyProgressTmk24 devPropertyProgressTmk24: devPropertyProgressTmk24
    property DevPropertyNozzle_v_0_00 devPropertyNozzle_v_0_00: devPropertyNozzle

    function setActivePanelType(ioType) {
        switch(ioType) {
        case "serialPort":
            if(devicePropertieslistModel1.currentIndex != 1) { // todo: maybe overink
                console.log("setActivePanelType -" + typeDev)
                devPropertyProgressTmk24.setResetState()
                devicePropertieslistModel1.currentIndex = 1
            }
            break;
        case "progress tmk24":
            console.log("setActivePanelType -" + typeDev)
            devPropertyProgressTmk24.setResetState()
            devicePropertieslistModel1.currentIndex = 2
            break;
        case "nozzle revision 0.00 oct 2018":
            console.log("setActivePanelType -" + typeDev)
            devPropertyNozzle.setResetState()
            devicePropertieslistModel1.currentIndex = 3
            break;
        default:
            console.log("setActivePanelType -unrecognise type dev")
            break;
        }
    }
    function setInterfaceProperites(ioType, propepties) {
        switch(typeDev) {
        case "serialPort":
            projectPanel.devicePanel.devicePropertyPanel.setPropertyToSerialPort(properties)
            break;
        default: break;
        }
    }


    function setPropertyToSerialPort(listData) {
        console.log("setPropertyToSerialPort")
        devPropertySerialPort.setPropertyValues(listData)
    }

    function setReadyProperties(typeDev, data) {
        switch(typeDev) {
        case "progress tmk24":
            devPropertyProgressTmk24.setDevProperty(data)
            projectPanel.devicePanel.devicePropertyPanel.devPropertyProgressTmk24.setReady()
            break;
        case "nozzle revision 0.00 oct 2018":
            devPropertyNozzle.setDevProperty(data)
            projectPanel.devicePanel.devicePropertyPanel.devPropertyNozzle_v_0_00.setReady()
            break;
        default: break;
        }
    }
    function setReadyOtherData(typeDev, data) {
        switch(typeDev) {
        case "progress tmk24":
            projectPanel.devicePanel.devicePropertyPanel.devPropertyProgressTmk24.setUpdateCurrentValues(data)
            break;
        case "nozzle revision 0.00 oct 2018":
            projectPanel.devicePanel.devicePropertyPanel.devPropertyNozzle_v_0_00.setUpdateCurrentValues(data)
            break;
        default: break;
        }
    }

    function setDevDisconnected(typeDev) {
        switch(typeDev) {
        case "progress tmk24":
            projectPanel.devicePanel.devicePropertyPanel.devPropertyProgressTmk24.setNoReady()
            break;
        case "nozzle revision 0.00 oct 2018":
            projectPanel.devicePanel.devicePropertyPanel.devPropertyNozzle_v_0_00.setNoReady()
            break;
        default: break;
        }
    }
    function setDevConnected(typeDev) {
        switch(typeDev) {
        case "progress tmk24":
            projectPanel.devicePanel.devicePropertyPanel.devPropertyProgressTmk24.setReady()
            break;
        case "nozzle revision 0.00 oct 2018":
            projectPanel.devicePanel.devicePropertyPanel.devPropertyNozzle_v_0_00.setReady()
            break;
        default: break;
        }
    }

    function devShowPasswordIncorrect(devType, devNameId) {
        console.log("devShowPasswordIncorrect -unrecognise type dev")
        dialogPasswordError.messageArg = devNameId
        dialogPasswordError.open()
        switch(devType) {
        case "PROGRESS TMK24":
            devicePropertieslistModel1.currentIndex = 2
            devPropertyProgressTmk24.setWriteSettingsIsNoAvailable()
            break;
        default:
            console.log("devShowPasswordIncorrect -unrecognise type dev")
            break;
        }
    }

    // TODO: type!
    function devShowTypeIncorrect(typeDev, devNameId) {
        dialogTypeError.messageArg = devNameId
        dialogTypeError.open()
    }

    Rectangle {
        id: parametersRect
        color: "transparent"
        anchors.fill: parent
        anchors.top: parent.top

        StackView {
            id: portOrDeviceStack
            anchors.fill: parent

            Rectangle {
                id: currentStateRectangle
                color: "#ffffff"
                anchors.fill: parent
                border.width: 1
                border.color: "#9899a7"

                SwipeView {
                    id: devicePropertieslistModel1
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 1
                    anchors.rightMargin: 1
                    interactive: false
                    clip: true

                    Item {
                        Rectangle {
                            id: logoSubPanel
                            anchors.fill: parent
                            height: 500
                            width: 500
                            color: "red"
                            LogoPanel {

                            }
                        }
                    }
                    Item {
                        DevPropertySerialPort {
                            id: devPropertySerialPort
                        }
                    }
                    Item{
                        DevPropertyProgressTmk24 {
                            id: devPropertyProgressTmk24
                        }
                    }
                    Item{
                        DevPropertyNozzle_v_0_00 {
                            id: devPropertyNozzle
                        }
                    }
                }
            }
        }

        Dialog {
            id: dialogAddDeviceFail
            visible: false
            title: "Добавление устройства"
            standardButtons: StandardButton.Close
            Rectangle {
                color: "transparent"
                implicitWidth: 250
                implicitHeight: 100
                Text {
                    text: "Не получилось добавить устройство\nТакой адрес уже используется"
                    color: "navy"
                    anchors.centerIn: parent
                }
            }
        }

        Dialog {
            id: dialogAddInterfaceFail
            visible: false
            title: "Добавление интерфейса"
            standardButtons: StandardButton.Close
            Rectangle {
                color: "transparent"
                implicitWidth: 350
                implicitHeight: 100
                Text {
                    text: "Не получилось добавить интерфейс\nВозможно такой интерфейс уже используется\nили ресурс не доступен"
                    color: "navy"
                    anchors.centerIn: parent
                }
            }
        }

        Dialog {
            id: dialogPasswordError
            visible: false
            title: "Ошибка пароля"
            standardButtons: StandardButton.Apply
            property string messageArg: ""
            width: 500
            height: 150
            Rectangle {
                color: "transparent"
                anchors.fill: parent
                Text {
                    text: qsTr("Настроечный пароль устройства %1 не совпадает\nс установленным в устройстве\nЗапись настроек не возможна!").arg(dialogPasswordError.messageArg)
                    color: "navy"
                    anchors.centerIn: parent
                }
            }
            onApply: {
                close()
            }
        }

        Dialog {
            id: dialogTypeError
            visible: false
            title: "Ошибка типа устройства"
            standardButtons: StandardButton.Apply
            property string messageArg: ""
            width: 500
            height: 150
            Rectangle {
                color: "transparent"
                anchors.fill: parent
                Text {
                    text: qsTr("Тип устройства не совпадает с заявленным при создании [%1]\nЭто устройство удалено из списка!").arg(dialogTypeError.messageArg)
                    color: "navy"
                    anchors.centerIn: parent
                }
            }
            onApply: {
                close()
            }
        }

        Dialog {
            id: messageOperationError
            visible: false
            title: "Ошибка операции"
            standardButtons: StandardButton.Close
            property string message: ""
            Rectangle {
                color: "transparent"
                implicitWidth: 450
                implicitHeight: 100
                Text {
                    text: messageOperationError.message
                    color: "navy"
                    anchors.centerIn: parent
                }
            }
        }

    }
}
