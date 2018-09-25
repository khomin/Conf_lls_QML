import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.10
import Qt.labs.platform 1.0
import QtCharts 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4 as Controls_1_4
import QtQuick.Controls.Styles 1.4
import CustomControls 1.0
import QtGraphicalEffects 1.0

Rectangle {
    anchors.fill: parent

    property alias messageMinMaxWriteOk: messageMinMaxWriteOk
    property alias messageReadSettingsOk: messageReadSettingsOk
    property alias messageWriteSettingsOk: messageWriteSettingsOk
    property alias messageReadErrorsOk: messageReadErrorsOk
    property alias messageReadTarTableOk: messageReadTarTableOk

    property bool isNoiseDetected: false

    function setNoReady() {
        devPropertyProgressTmk24.isReady = false
    }
    function setReady() {
        devPropertyProgressTmk24.isReady = true
    }
    function setResetState() {
        tabProperty.setCurrentIndex(0)
        stackSubProperty.setCurrentIndex(0)
        setNoReady()
        setWriteSettingsIsAvailable()
    }
    function setWriteSettingsIsAvailable() {
        writeSettingsButton_1.enabled = true
        writeSettingsButton_2.enabled = true
        writeSettingsButton_3.enabled = true
        writeSettingsButton_4.enabled = true
        writeSettingsButton_5.enabled = true
    }
    function setWriteSettingsIsNoAvailable() {
        writeSettingsButton_1.enabled = false
        writeSettingsButton_2.enabled = false
        writeSettingsButton_3.enabled = false
        writeSettingsButton_4.enabled = false
        writeSettingsButton_5.enabled = false
    }
    function setDevProperty(listProperty) {
        typeDeviceText.text = listProperty[2]
        snText.text = listProperty[0]
        //netIdText.text = listProperty[1]
        versionFirmwareText.text = listProperty[3]
        // give settings without request to device (copy allready readed)
        viewController.getCurrentDevSettingsWithoutRequest()
    }
    function setUpdateCurrentValues(data) {
        devPropertyProgressTmk24.isReady = true
        var values = viewController.getCurrentDevOtherData()
        if(values.length >0) {
            //levelValue.text = values[0]
            levelProgress.value = values[1]
            levelCnt.value = parseInt(values[2]).toPrecision(3)
            levelFreq.value = values[3]
            levelTemp.value = values[4]
        }
        //-- noise detect
        if(values[5] == true) {
            if(chartTarCurrentValuesMultiple.animateColorUp.running == false
                    & chartTarCurrentValuesMultiple.animateColorDown.running == false) {
                chartTarCurrentValuesMultiple.animateColorUp.start()
            }
        }
        //-- chart
        var list = viewController.getCurrentDevChart()
        currentChartLines.clear();
        chartCurrentValue.graphLength = list.length
        chartCurrentValue.graphAmplitudeMax = 0

        for(var i=0; i<list.length; i++) {
            if(chartCurrentValue.graphAmplitudeMax < list[i]) {
                chartCurrentValue.graphAmplitudeMax = list[i];
            }
        }
        for(i=0; i<list.length; i++) {
            currentChartLines.append(i, list[i]);
        }
        logListView.positionViewAtEnd()
    }
    function addLogMessage(codeMessage, message) {
        if(logListView.model.length > 1000) {
            logListView.model.clear()
        }
        logListView.model.append({"message":message,"status":codeMessage})
    }
    function readSettings(devName, key, settings) {
        for(var i=0; i<settings.length; i++) {
            if(key[i] === "k1_value") {
                k1.text = settings[i]
            } else if(key[i] === "k2_value") {
                k2.text = settings[i]
            } else if(key[i] === "typeTempCompensation_value") {
                typeTempCompensation.currentIndex = settings[i]
            } else if(key[i] === "periodicSendType_value") {
                periodicSendType.currentIndex = settings[i]
            } else if(key[i] === "periodicSendTime_value") {
                periodicSendTime.value = settings[i]
            } else if(key[i] === "typeOutMessage_value") {
                typeOutMessage.currentIndex = settings[i]
            } else if(key[i] === "typeInterpolation_value") {
                typeInterpolation.currentIndex = settings[i]
            } else if(key[i] === "typeFiltration_value") {
                typeFiltration.currentIndex = settings[i]
            } else if(key[i] === "filterLenghtMediana_value") {
                filterLenghtMediana.value = settings[i]
            } else if(key[i] === "filterAvarageValueSec_value") {
                filterAvarageValueSec.value = settings[i]
            } else if(key[i] === "filterValueR_value") {
                filterValueR.value= settings[i]
            } else if(key[i] === "filterValueQ_value") {
                filterValueQ.value = settings[i]
            } else if(key[i] === "minLevelValue_value") {
                minLevelValue.value = settings[i]
            } else if(key[i] === "maxLevelValue_value") {
                maxLevelValue.value = settings[i]
            } else if(key[i] === "masterSlaveModes_value") {
                masterSlaveModes.currentIndex = settings[i]
            } else if(key[i] === "baudrateRs232Values_value") {
                baudrateRs232Values.currentIndex = settings[i]
            } else if(key[i] === "baudrateRs485Values_value") {
                baudrateRs485Values.currentIndex = settings[i]
            } else if(key[i] === "masterSlaveFullCountes_value") {
                masterSlaveFullCountes.value = settings[i]
            } else if(key[i] === "masterSlaveSlaveId_1_value") {
                masterSlaveSlaveId_1.value = settings[i]
            } else if(key[i] === "masterSlaveSlaveId_2_value") {
                masterSlaveSlaveId_2.value = settings[i]
            } else if(key[i] === "masterSlaveSlaveId_3_value") {
                masterSlaveSlaveId_3.value = settings[i]
            } else if(key[i] === "masterSlaveSlaveId_4_value") {
                masterSlaveSlaveId_4.value = settings[i]
            }
        }
    }
    function writeSettings() {
        var settings = [];
        var key = [];
        key.push("k1_value")
        settings.push(k1.text)
        key.push("k2_value")
        settings.push(k2.text)
        key.push("typeTempCompensation_value")
        settings.push(typeTempCompensation.currentIndex)
        key.push("periodicSendType_value")
        settings.push(periodicSendType.currentIndex)
        key.push("periodicSendTime_value")
        settings.push(periodicSendTime.value)
        key.push("typeOutMessage_value")
        settings.push(typeOutMessage.currentIndex)
        key.push("typeInterpolation_value")
        settings.push(typeInterpolation.currentIndex)
        key.push("typeFiltration_value")
        settings.push(typeFiltration.currentIndex)
        key.push("filterLenghtMediana_value")
        settings.push(filterLenghtMediana.value)
        key.push("filterAvarageValueSec_value")
        settings.push(filterAvarageValueSec.value)
        key.push("filterValueR_value")
        settings.push(filterValueR.value)
        key.push("filterValueQ_value")
        settings.push(filterValueQ.value)
        key.push("minLevelValue_value")
        settings.push(minLevelValue.value)
        key.push("maxLevelValue_value")
        settings.push(maxLevelValue.value)
        key.push("masterSlaveModes_value")
        settings.push(masterSlaveModes.currentIndex)
        key.push("baudrateRs232Values_value")
        settings.push(baudrateRs232Values.currentIndex)
        key.push("baudrateRs485Values_value")
        settings.push(baudrateRs485Values.currentIndex)
        key.push("masterSlaveFullCountes_value")
        settings.push(masterSlaveFullCountes.value)
        key.push("masterSlaveSlaveId_1_value")
        settings.push(masterSlaveSlaveId_1.value)
        key.push("masterSlaveSlaveId_2_value")
        settings.push(masterSlaveSlaveId_2.value)
        key.push("masterSlaveSlaveId_3_value")
        settings.push(masterSlaveSlaveId_3.value)
        key.push("masterSlaveSlaveId_4_value")
        settings.push(masterSlaveSlaveId_4.value)

        viewController.setCurrentDevSettings(key, settings)
    }
    function readErrors(devName, errors) {
        error1Label.error1 = errors[0]
        error2Label.error2 = errors[1]
        error3Label.error3 = errors[2]
        error4Label.error4 = errors[3]
        error5Label.error5 = errors[4]
        error6Label.error6 = errors[5]
        error7Label.error7 = errors[6]
        error8Label.error8 = errors[7]
    }
    function remakeTarTableChart() {
        chartTarTableMultiple.removeAllSeries();
        var colorArray = []
        colorArray.push("#f34b4b")
        colorArray.push("#4bd5f3")
        colorArray.push("#f34be1")
        colorArray.push("#4bf3c6")
        colorArray.push("#4b4bf3")
        colorArray.push("#be4bf3")
        colorArray.push("#0d8741")

        var tarSize = viewController.getStayedDevTarrirCount()
        for(var deviceCounter=0; deviceCounter<tarSize; deviceCounter++) {
            var roleLiters = "roleLiters" + deviceCounter
            var roleFuelLevel = "roleFuelLevel" + deviceCounter
            var devId = viewController.getStayedDevTarrir_DevProperty("id")

            var maxvalueFuelLevel = 0;
            var maxValueLitrs = 0;
            var tarArrayLitrs = [];
            var tarArrayFuelLevel = [];

            for(var itemCounter=0; itemCounter<tarTabViewMultiple.rowCount; itemCounter++) {
                var item = tarTabViewMultiple.model.get(itemCounter)
                tarArrayLitrs.push(item[roleLiters])
                tarArrayFuelLevel.push(item[roleFuelLevel])
                if(maxvalueFuelLevel < item[roleFuelLevel]) {
                    maxvalueFuelLevel = item[roleFuelLevel]
                }
                if(maxValueLitrs < item[roleLiters]) {
                    maxValueLitrs = item[roleLiters]
                }
                console.log(roleLiters + " " + item[roleFuelLevel] + "\nValue Litrs=" + item[roleLiters])
            }

            var line = chartTarTableMultiple.createSeries(ChartView.SeriesTypeLine, "ID" + devId[deviceCounter], chartTarTableAxisXMultiple, chartTarTableAxisYMultiple);
            line.color = colorArray[deviceCounter]
            chartTarTableAxisXMultiple.min = 0;
            chartTarTableAxisXMultiple.max = parseInt(maxValueLitrs)
            chartTarTableAxisYMultiple.min = 0;
            chartTarTableAxisYMultiple.max = parseInt(maxvalueFuelLevel)

            chartTarTableMultiple.chartTarTableAmplitudeMax = parseInt(maxvalueFuelLevel)
            chartTarTableMultiple.chartTarTableLength = parseInt(maxValueLitrs)

            console.log("MaxLevel =" + chartTarTableMultiple.chartTarTableAmplitudeMax)
            for(var i=0; i<tarArrayFuelLevel.length; i++) {
                line.append(parseInt(tarArrayLitrs[i]), parseInt(tarArrayFuelLevel[i]));
                console.log("Add=" + i + " " + tarArrayLitrs[i])
            }
        }
    }

    function addTarStepValue(rowIndex) {
        if(rowIndex === -1) {
            rowIndex = 0
        } else {
            rowIndex++
        }
        // если таблица пустая
        // создаем строку и заносим в нее текущие значения по устройствам
        // пока не переберем все уст-ва
        var itemValue = {}
        var devCount = viewController.getStayedDevTarrirCount()
        var devId = viewController.getStayedDevTarrir_DevProperty("id")

        for(var devIndex=0; devIndex<devCount; devIndex++) {
            var valueFuelLevel = 0
            var valueLiters = 0
            var value = viewController.getTarCurrentDeviceData(devIndex)
            var roleLiters = "roleLiters" + devIndex
            var roleFuelLevel = "roleFuelLevel" + devIndex

            valueFuelLevel = value[0]
            if(valueFuelLevel == undefined) {
                valueFuelLevel = "0"
            }
            // попытка взять предыдущее значение литров
            // если есть
            var lastLiter = tarTabViewMultiple.model.get(rowIndex-1)
            if(lastLiter !== undefined) {
                valueLiters = lastLiter[roleLiters]
                if(valueLiters == undefined) {
                    valueLiters = "0"
                }
                if(valueLiters.length === 0) {
                    valueLiters = "0"
                }
            } else {
                valueLiters = value[1]
                if(valueLiters == undefined) {
                    valueLiters = "0"
                }
                if(valueLiters.length === 0) {
                    valueLiters = "0"
                }
            }
            itemValue[roleLiters] = valueLiters;
            itemValue[roleFuelLevel] = valueFuelLevel;
        }
        if(tarTabViewMultiple.model.get(rowIndex) === undefined) {
            tarTabViewMultiple.model.append(itemValue)
        } else {
            tarTabViewMultiple.model.insert(rowIndex, itemValue)
        }
        tarTabViewMultiple.currentRow = tarTabViewMultiple.currentRow+1
        timerAffterRefrashTarTable.start()
    }

    function removeTarStepValue(rowIndex) {
        // если ничего не выбрано выходим
        if(rowIndex >= 0) {
            // удаляем строку
            tarTabViewMultiple.model.remove(rowIndex)
            timerAffterRefrashTarTable.start()
        }
    }

    function remakeTarTable() {
        tarTabViewMultiple.model.clear()
        tarListDevice.model.clear()
        for(var index = tarTabViewMultiple.columnCount-1; index>=0; index--) {
            tarTabViewMultiple.removeColumn(index)
        }
        var tarSize = viewController.getStayedDevTarrirCount()
        var devType = []
        var devId = []
        var devSn = []
        devType = viewController.getStayedDevTarrir_DevProperty("type")
        devId =  viewController.getStayedDevTarrir_DevProperty("id")
        devSn = viewController.getStayedDevTarrir_DevProperty("sn")
        for(var i=0; i<tarSize; i++) { // добавляем на list with current data
            tarListDevice.model.append({"devTyp":devType[i],"devId":devId[i],"devSn":devSn[i],"valueCnt":"0","valueFuelLevel":"0"})
        }
        // добавляем в таблицу как столблец для девайса
        for(var i2=0; i2<tarSize; i2++) {
            var component = {}
            component = Qt.createComponent("DevPropertyProgressTmk24TarTableDelegate.qml");
            var tableViewColumn  = component.createObject(tarTabViewMultiple);
            tableViewColumn.title = qsTr("Объем[ID-%1]").arg(devId[i2])
            tableViewColumn.role = "roleLiters" + i2
            tableViewColumn.width = 100
            tarTabViewMultiple.addColumn(tableViewColumn)
            console.log("addeted1 =" + tableViewColumn.role)
            tableViewColumn.valueIsChanged.connect(function(role, text, modelChanged) {
                var curRow = tarTabViewMultiple.currentRow
                modelChanged[role] = text
                tarTabViewMultiple.model.set(curRow, modelChanged)
                remakeTarTableChart()
            });
            tableViewColumn  = component.createObject(tarTabViewMultiple);
            tableViewColumn.title = qsTr("Ур.топ-ва[ID-%1]").arg(devId[i2])
            tableViewColumn.role = "roleFuelLevel" + i2
            tableViewColumn.width = 100
            tarTabViewMultiple.addColumn(tableViewColumn)

            tableViewColumn.valueIsChanged.connect(function(role, text, modelChanged) {
                var curRow = tarTabViewMultiple.currentRow
                modelChanged[role] = text
                tarTabViewMultiple.model.set(curRow, modelChanged)
                remakeTarTableChart()
            });
            console.log("addeted2 =" + tableViewColumn.role)
        }
    }
    function writeTarTable() {
        var devCount = viewController.getStayedDevTarrirCount()
        var devType = []
        var devId = []
        var devSn = []
        devType = viewController.getStayedDevTarrir_DevProperty("type")
        devId =  viewController.getStayedDevTarrir_DevProperty("id")
        devSn = viewController.getStayedDevTarrir_DevProperty("sn")

        // считываем данные по ролям
        for(var count=0; count<devCount; count++) {
            var valueFuelLevel = 0
            var valueLiters = 0
            var roleLiters = "roleLiters" + count
            var roleFuelLevel = "roleFuelLevel" + count
            var jsonArrayCnt = []
            var jsonArrayLiters = []
            // считываем все шаги для одного устройства
            var modelTarSize = tarTabViewMultiple.model.count
            for(var subCount=0; subCount<modelTarSize; subCount++) {
                var values = tarTabViewMultiple.model.get(subCount)
                if(values !== undefined) {
                    valueLiters = values[roleLiters]
                    valueFuelLevel = values[roleFuelLevel]
                    if(valueLiters == undefined) {
                        valueLiters = "0"
                    }
                    if(valueFuelLevel == undefined) {
                        valueFuelLevel = "0"
                    }
                } else {
                    valueLiters = values[1]
                    if(valueLiters == undefined) {
                        valueLiters = "0"
                    }
                    valueFuelLevel = values[0]
                    if(valueFuelLevel == undefined) {
                        valueFuelLevel = "0"
                    }
                }
                jsonArrayCnt.push(valueFuelLevel)
                jsonArrayLiters.push(valueLiters)
            }
            viewController.setTableFromFrontEnd(devId[count], jsonArrayLiters, jsonArrayCnt)
        }
        viewController.sendReqWriteTarrirAllDev()
    }

    function readTarTable(devCount) {
        console.log("readTarTable = " + devCount)
        var jsonArray = []
        var tarStepMax = viewController.getTarMaxCountStep()
        while(tarStepMax >0) {
            jsonArray.push({});
            tarStepMax--
        }
        // пока не переберем все уст-ва
        for(var devIndex=0; devIndex<devCount; devIndex++) {
            var table = viewController.getTableAtDevice(devIndex)
            var parity = 0
            var rowIndex = 0
            // перебираем таблицу уст-ва
            var valueFuelLevel = 0
            var valueLiters = 0
            var stepCount = viewController.getTarMaxCountStep() *2 // it pair
            if(stepCount === 0 | stepCount === undefined) {
                messageReadTarTableEmpty.open()
            }
            console.log("getTable =" + table.length)

            for(var devTableRow=0; devTableRow<stepCount; devTableRow++) {
                if(parity == 0) {
                    parity = 1;
                    valueLiters = table[devTableRow]
                    if(valueLiters == undefined) {
                        valueLiters = ""
                    }
                } else {
                    parity = 0;
                    valueFuelLevel = table[devTableRow]
                    if(valueFuelLevel == undefined) {
                        valueFuelLevel = ""
                    }

                    var roleLiters = "roleLiters" + devIndex
                    var roleFuelLevel = "roleFuelLevel" + devIndex

                    var itemArray = jsonArray[rowIndex]
                    if(itemArray === undefined) {
                        itemArray = {}
                        jsonArray.push(itemArray)
                    }
                    itemArray[roleLiters] = valueLiters;
                    itemArray[roleFuelLevel] = valueFuelLevel;
                    jsonArray[rowIndex] = itemArray
                    rowIndex ++
                }
            }
        }
        for(var len=0; len<jsonArray.length; len++) {
            if(tarTabViewMultiple.model.get(len) === undefined) {
                tarTabViewMultiple.currentRow = 0
                tarTabViewMultiple.model.append(jsonArray[len])
            } else {
                tarTabViewMultiple.model.set(len, jsonArray[len])
            }
        }
        timerAffterRefrashTarTable.start()
    }

    function changeDeviceUniqId() {
        changeDevId.open()
    }

    Timer {
        id: timerTestRepeat
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            var devCount = viewController.getStayedDevTarrirCount()
            var devId = viewController.getStayedDevTarrir_DevProperty("id")
            var colorArray = []
            colorArray.push("#f34b4b")
            colorArray.push("#4bd5f3")
            colorArray.push("#f34be1")
            colorArray.push("#4bf3c6")
            colorArray.push("#4b4bf3")
            colorArray.push("#be4bf3")
            colorArray.push("#0d8741")
            chartTarCurrentValuesMultiple.removeAllSeries();

            for(var devIter=0; devIter<devCount; devIter++) {
                var res = viewController.getTarCurrentDeviceData(devIter)
                var dataArray = tarListDevice.model.get(devIter)
                if(dataArray !== undefined) {
                    dataArray["valueCnt"] = res[0]
                    dataArray["valueFuelLevel"] = res[2]
                    tarListDevice.model.set(devIter, dataArray)
                }
                //-- chart
                var chartArray = viewController.getTarCurrentDeviceChartData(devIter)

                var line = chartTarCurrentValuesMultiple.createSeries(ChartView.SeriesTypeLine, "ID" + devId[devIter], currentTarChartAxisXMultiple, currentTarChartAxisYMultiple);
                line.color = colorArray[devIter]

                chartTarCurrentValuesMultiple.graphLength = chartArray.length
                chartTarCurrentValuesMultiple.graphAmplitudeMax = 0

                for(var chartIter=0; chartIter<chartArray.length; chartIter++) {
                    if(chartTarCurrentValuesMultiple.graphAmplitudeMax < chartArray[chartIter]) {
                        chartTarCurrentValuesMultiple.graphAmplitudeMax = chartArray[chartIter];
                    }
                }

                currentTarChartAxisXMultiple.min = 0;
                currentTarChartAxisXMultiple.max = chartArray.length
                currentTarChartAxisYMultiple.min = 0;
                currentTarChartAxisYMultiple.max = chartTarCurrentValuesMultiple.graphAmplitudeMax

                for(chartIter=0; chartIter<chartArray.length; chartIter++) {
                    line.append(chartIter, parseInt(chartArray[chartIter]));
                }
            }
        }
    }

    Rectangle {
        id: devPropertyProgressTmk24
        property bool isReady: true
        anchors.fill: parent
        color: "transparent"
        Rectangle {
            id: barup
            color: "#ffffff"
            height: 50
            anchors.left: parent.left
            anchors.right: parent.right

            TabBar {
                id: tabProperty
                height: 25
                anchors.left: barup.left
                anchors.leftMargin: 30
                anchors.top: barup.top
                anchors.topMargin: 20
                spacing: 5
                currentIndex: devStackParam.currentIndex
                font.pointSize: 8

                TabButtonUp {
                    name: "Текущее состояние"
                    textLine:1
                    widthBody: 155
                }
                TabButtonUp {
                    name: "Конфигурирование"
                    textLine:1
                    widthBody: 155
                }
            }
        }

        Rectangle {
            id:spacerList
            anchors.top: barup.bottom
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.right: parent.right
            width: parent.width
            height: 2
            color: "#f0f3f6"
        }

        SwipeView {
            id: devStackParam
            anchors.top: spacerList.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            currentIndex: tabProperty.currentIndex

            Item {
                ScrollView {
                    clip: true
                    anchors.fill: parent
                    Column {
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 10
                        Row {
                            id:currentDataTexted
                            layer.enabled: true
                            width: 800
                            height: 50
                            Row {
                                id:currentDataTexted_1
                                clip: true
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.top: parent.top
                                anchors.topMargin: 13
                                width: 250
                                height: 25
                                Label {
                                    id: lSn
                                    text: qsTr("Завод/ном:")
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                TextField {
                                    id: snText
                                    text: qsTr("")
                                    anchors.left: lSn.right
                                    anchors.leftMargin: 5
                                    anchors.right: parent.right
                                    height: parent.height
                                    enabled: devPropertyProgressTmk24.isReady
                                    readOnly: true
                                }
                            }

                            Row {
                                id: currentDataTexted_2
                                clip: true
                                anchors.left: currentDataTexted_1.right
                                anchors.leftMargin: 10
                                anchors.top: parent.top
                                anchors.topMargin: 13
                                width: 250
                                height: 25
                                Label {
                                    id: lTypeDevice
                                    text: qsTr("Тип датчика:")
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                TextField {
                                    id: typeDeviceText
                                    text: qsTr("")
                                    anchors.left: lTypeDevice.right
                                    anchors.right: parent.right
                                    anchors.leftMargin: 5
                                    readOnly: true
                                    enabled: devPropertyProgressTmk24.isReady
                                    height: parent.height
                                }
                            }

                            Row {
                                id: currentDataTexted_3
                                clip: true
                                anchors.left: currentDataTexted_2.right
                                anchors.leftMargin: 10
                                anchors.top: parent.top
                                anchors.topMargin: 13
                                width: 250
                                height: 25
                                Label {
                                    id: lversionFirmwareText
                                    text: qsTr("Версия ПО:")
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                TextField {
                                    id: versionFirmwareText
                                    text: qsTr("")
                                    enabled: devPropertyProgressTmk24.isReady
                                    anchors.left: lversionFirmwareText.right
                                    anchors.right: parent.right
                                    anchors.leftMargin: 5
                                    readOnly: true
                                    height: parent.height
                                }
                            }
                            layer.effect: DropShadow {
                                transparentBorder: true
                                horizontalOffset: 0
                                verticalOffset: 1
                                color: "#e0e5ef"
                                samples: 10
                                radius: 10
                            }
                        }

                        Column {
                            id: column
                            spacing: 5
                            Row{
                                spacing: 10
                                Rectangle{
                                    width: 200
                                    height: 200
                                    layer.enabled: true
                                    radius: 15
                                    Label {
                                        id: levelValueLabel
                                        text: qsTr("Уровень/Объем:")
                                        anchors.left: parent.left
                                        color: "#888d91"
                                        anchors.leftMargin: 15
                                        anchors.right: parent.right
                                        anchors.rightMargin: 0
                                    }
                                    RadialBar {
                                        id:levelProgress
                                        anchors.top: levelValueLabel.bottom
                                        anchors.topMargin: 15
                                        anchors.left: parent.left
                                        anchors.leftMargin: 20
                                        width: 150
                                        height: 150
                                        penStyle: Qt.RoundCap
                                        dialType: RadialBar.FullDial
                                        progressColor: "#05fff0"
                                        foregroundColor: "transparent"
                                        dialWidth: 15
                                        startAngle: 180
                                        spanAngle: 70
                                        minValue: 0
                                        maxValue: 100
                                        value: 0
                                        textFont {
                                            family: "Halvetica"
                                            italic: false
                                            pointSize: 16
                                        }
                                        suffixText: "%"
                                        textColor: "#888d91"
                                        enabled: devPropertyProgressTmk24.isReady
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 10
                                    }
                                }

                                Rectangle{
                                    width: 200
                                    height: 200
                                    layer.enabled: true
                                    radius: 15
                                    Label {
                                        id: levelCntLabel
                                        text: qsTr("CNT значение:")
                                        anchors.left: parent.left
                                        color: "#888d91"
                                        anchors.leftMargin: 15
                                        anchors.right: parent.right
                                        anchors.rightMargin: 0
                                    }
                                    RadialBar {
                                        id:levelCnt
                                        anchors.top: levelCntLabel.bottom
                                        anchors.topMargin: 15
                                        anchors.left: parent.left
                                        anchors.leftMargin: 20
                                        width: 150
                                        height: 150
                                        penStyle: Qt.RoundCap
                                        dialType: RadialBar.FullDial
                                        progressColor: "#1dc58f"
                                        foregroundColor: "transparent"
                                        dialWidth: 15
                                        startAngle: 180
                                        spanAngle: 70
                                        minValue: 0
                                        maxValue: 5000000
                                        value: 0
                                        textFont {
                                            family: "Halvetica"
                                            italic: false
                                            pointSize: 16
                                        }
                                        suffixText: ""
                                        textColor: "#888d91"
                                        enabled: devPropertyProgressTmk24.isReady
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 10
                                    }
                                }

                                Rectangle{
                                    width: 200
                                    height: 200
                                    layer.enabled: true
                                    radius: 15
                                    Label {
                                        id: levelTempLabel
                                        text: qsTr("Температура:")
                                        anchors.left: parent.left
                                        color: "#888d91"
                                        anchors.leftMargin: 15
                                        anchors.right: parent.right
                                        anchors.rightMargin: 0
                                    }
                                    RadialBar {
                                        id:levelTemp
                                        anchors.top: levelTempLabel.bottom
                                        anchors.topMargin: 15
                                        anchors.left: parent.left
                                        anchors.leftMargin: 20
                                        width: 150
                                        height: 150
                                        penStyle: Qt.RoundCap
                                        dialType: RadialBar.FullDial
                                        progressColor: "#f329b8"
                                        foregroundColor: "transparent"
                                        dialWidth: 15
                                        startAngle: 180
                                        spanAngle: 70
                                        minValue: 0
                                        maxValue: 80
                                        value: 0
                                        textFont {
                                            family: "Halvetica"
                                            italic: false
                                            pointSize: 16
                                        }
                                        suffixText: "°C"
                                        textColor: "#888d91"
                                        enabled: devPropertyProgressTmk24.isReady
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 10
                                    }
                                }

                                Rectangle{
                                    width: 200
                                    height: 200
                                    layer.enabled: true
                                    radius: 15
                                    Label {
                                        id: levelFreqLabel
                                        text: qsTr("Частота:")
                                        anchors.left: parent.left
                                        color: "#888d91"
                                        anchors.leftMargin: 15
                                        anchors.right: parent.right
                                        anchors.rightMargin: 0
                                    }
                                    RadialBar {
                                        id:levelFreq
                                        anchors.top: levelFreqLabel.bottom
                                        anchors.topMargin: 15
                                        anchors.left: parent.left
                                        anchors.leftMargin: 20
                                        width: 150
                                        height: 150
                                        penStyle: Qt.RoundCap
                                        dialType: RadialBar.FullDial
                                        progressColor: "#f3c129"
                                        foregroundColor: "transparent"
                                        dialWidth: 15
                                        startAngle: 180
                                        spanAngle: 70
                                        minValue: 0
                                        maxValue: 15000
                                        value: 0
                                        textFont {
                                            family: "Halvetica"
                                            italic: false
                                            pointSize: 16
                                        }
                                        suffixText: "Hz"
                                        textColor: "#888d91"
                                        enabled: devPropertyProgressTmk24.isReady
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 10
                                    }
                                }
                            }
                        }
                        Column {
                            Rectangle {
                                height: 300
                                width: column.width// - 50
                                color: "#ffffff"
                                radius: 15
                                ChartView {
                                    id: chartCurrentValue
                                    anchors.fill: parent
                                    theme: ChartView.ChartThemeLight
                                    title: "Уровень/Объем"
                                    antialiasing: true
                                    property int graphLength: 1
                                    property int graphAmplitudeMax: 1
                                    ValueAxis {
                                        id: currentChartAxisX
                                        min: 0
                                        max: chartCurrentValue.graphLength
                                        tickCount: 5
                                    }
                                    ValueAxis {
                                        id: currentChartAxisY
                                        min: -0.1
                                        max: chartCurrentValue.graphAmplitudeMax
                                        tickCount: 5
                                    }
                                    LineSeries {
                                        id: currentChartLines
                                        axisX: currentChartAxisX
                                        axisY: currentChartAxisY
                                    }
                                    enabled: devPropertyProgressTmk24.isReady
                                }
                                layer.enabled: true
                                layer.effect: DropShadow {
                                    transparentBorder: true
                                    horizontalOffset: 0
                                    verticalOffset: 1
                                    color: "#e0e5ef"
                                    samples: 10
                                    radius: 10
                                }
                            }
                        }


                        Column {
                            Rectangle {
                                id:errorRectangle
                                height: 400
                                width: column.width
                                color: "#ffffff"
                                layer.enabled: true
                                radius: 15
                                enabled: devPropertyProgressTmk24.isReady
                                Column {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15
                                    spacing: 5

                                    Label {
                                        id: errorsLabel
                                        text: qsTr("Ошибки:")
                                        anchors.left: parent.left
                                        color: "#888d91"
                                    }

                                    ButtonRound {
                                        id:readErrors
                                        textLine: 1
                                        widthBody: 150
                                        name:"Считать ошибки"
                                        enabled: devPropertyProgressTmk24.isReady
                                        onClicked: {
                                            viewController.getCurrentDevErrors()
                                        }
                                    }

                                    Row{
                                        width: 400
                                        height: 30
                                        Label {
                                            id:error1Label
                                            property bool error1: false
                                            text: "Датчик не откалиброван:"
                                        }
                                        Image {
                                            height: 32
                                            width: 32
                                            anchors.left: parent.right
                                            anchors.leftMargin: 20
                                            source: error1Label.error1 !== true ? "/new/icons/images/icon/4149.png" : "/new/icons/images/icon/4372.png"
                                        }
                                    }
                                    Row{
                                        width: 400
                                        height: 30
                                        Label {
                                            id:error2Label
                                            text: "Выход за минимальную границу измерения на 10%:"
                                            property bool error2: false
                                        }
                                        Image {
                                            height: 32
                                            width: 32
                                            anchors.left: parent.right
                                            anchors.leftMargin: 20
                                            source: error2Label.error1 !== true ? "/new/icons/images/icon/4149.png" : "/new/icons/images/icon/4372.png"
                                        }
                                    }
                                    Row{
                                        width: 400
                                        height: 30
                                        Label {
                                            id:error3Label
                                            text: "Выход за максимальную границу измерения на 10%:"
                                            property bool error3: false
                                        }
                                        Image {
                                            height: 32
                                            width: 32
                                            anchors.left: parent.right
                                            anchors.leftMargin: 20
                                            source: error3Label.error1 !== true ? "/new/icons/images/icon/4149.png" : "/new/icons/images/icon/4372.png"
                                        }
                                    }
                                    Row{
                                        width: 400
                                        height: 30
                                        Label {
                                            id:error4Label
                                            text: "Частота измерительного генератора 0 Гц:"
                                            property bool error4: false
                                        }
                                        Image {
                                            height: 32
                                            width: 32
                                            anchors.left: parent.right
                                            anchors.leftMargin: 20
                                            source: error4Label.error1 !== true ? "/new/icons/images/icon/4149.png" : "/new/icons/images/icon/4372.png"
                                        }
                                    }
                                    Row{
                                        width: 400
                                        height: 30
                                        Label {
                                            id:error5Label
                                            text: "Ведомый датчик №1 не отвечает:"
                                            property bool error5: false
                                        }
                                        Image {
                                            height: 32
                                            width: 32
                                            anchors.left: parent.right
                                            anchors.leftMargin: 20
                                            source: error5Label.error1 !== true ? "/new/icons/images/icon/4149.png" : "/new/icons/images/icon/4372.png"
                                        }
                                    }

                                    Row{
                                        width: 400
                                        height: 30
                                        Label {
                                            id:error6Label
                                            text: "Ведомый датчик №2 не отвечает:"
                                            property bool error6: false
                                        }
                                        Image {
                                            height: 32
                                            width: 32
                                            anchors.left: parent.right
                                            anchors.leftMargin: 20
                                            source: error6Label.error1 !== true ? "/new/icons/images/icon/4149.png" : "/new/icons/images/icon/4372.png"
                                        }
                                    }
                                    Row{
                                        width: 400
                                        height: 30
                                        Label {
                                            id:error7Label
                                            text: "Ведомый датчик №3 не отвечает:"
                                            property bool error7: false
                                        }
                                        Image {
                                            height: 32
                                            width: 32
                                            anchors.left: parent.right
                                            anchors.leftMargin: 20
                                            source: error7Label.error1 !== true ? "/new/icons/images/icon/4149.png" : "/new/icons/images/icon/4372.png"
                                        }
                                    }
                                    Row{
                                        width: 400
                                        height: 30
                                        Label {
                                            id:error8Label
                                            text: "Ведомый датчик №4 не отвечает:"
                                            property bool error8: false
                                        }
                                        Image {
                                            height: 32
                                            width: 32
                                            anchors.left: parent.right
                                            anchors.leftMargin: 20
                                            source: error8Label.error1 !== true ? "/new/icons/images/icon/4149.png" : "/new/icons/images/icon/4372.png"
                                        }
                                    }
                                }
                                layer.effect: DropShadow {
                                    transparentBorder: true
                                    horizontalOffset: 0
                                    verticalOffset: 1
                                    color: "#e0e5ef"
                                    samples: 10
                                    radius: 10
                                }
                            }
                        }
                        Column {
                            Rectangle {
                                height: 250
                                width: column.width
                                color: "#ffffff"
                                layer.enabled: true
                                radius: 15
                                Column {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15
                                    spacing: 20

                                    Label {
                                        text: qsTr("Сообщения:")
                                        anchors.left: parent.left
                                        color: "#888d91"
                                    }
                                    ListView {
                                        id: logListView
                                        clip: true
                                        height: 200
                                        width: column.width - 50

                                        ScrollBar.vertical: ScrollBar {
                                            width: 20
                                        }

                                        delegate: Item {
                                            id: logItemDelegate
                                            height: 30
                                            width: parent.width

                                            Rectangle {
                                                width: logItemDelegate.width - 2
                                                anchors.left: parent.left
                                                anchors.leftMargin: 1
                                                height: logItemDelegate.height
                                                color: "transparent"//colorCode
                                                Label {
                                                    id:logMessageText
                                                    text: model.message
                                                    font.bold: false
                                                    anchors.left: parent.left
                                                    anchors.leftMargin: 10
                                                    anchors.verticalCenter: parent.verticalCenter
                                                }
                                            }
                                        }
                                        model: ListModel {
                                            id: logListModel
                                        }
                                    }
                                }
                                layer.effect: DropShadow {
                                    transparentBorder: true
                                    horizontalOffset: 0
                                    verticalOffset: 1
                                    color: "#e0e5ef"
                                    samples: 10
                                    radius: 10
                                }
                            }
                        }
                        Rectangle {
                            height: 100
                            width: column.width
                            color: "#ffffff"
                            layer.enabled: true
                            radius: 15
                        }
                    }
                }
            }

            Item {
                clip: true
                Rectangle {
                    id: subBarup
                    color: "#fdfdfb"
                    height: 45
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    TabBar {
                        id:tabSubProperty
                        height: 25
                        anchors.left: parent.left
                        //                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.topMargin: 17
                        anchors.leftMargin: 30
                        spacing: 5
                        currentIndex: stackSubProperty.currentIndex
                        font.pointSize: 8
                        background: Rectangle {
                            color: "transparent"
                        }

                        TabButtonUp {
                            name: "Общее"
                            textLine:1
                            widthBody: 100
                        }
                        TabButtonUp {
                            name: "Калибровка\nMinMax"
                            textLine:2
                            widthBody: 120
                        }
                        TabButtonUp {
                            name: "Фильтрация"
                            textLine:1
                            widthBody: 115
                        }
                        TabButtonUp {
                            name: "Температурная\nкомпенсация"
                            textLine:2
                            widthBody: 135
                        }
                        TabButtonUp {
                            name: "Ведущий\nведомый"
                            textLine:2
                            widthBody: 110
                        }
                        TabButtonUp {
                            name: "Тарировка"
                            textLine:1
                            widthBody: 110
                        }
                    }
                }

                SwipeView {
                    id: stackSubProperty
                    currentIndex: tabSubProperty.currentIndex
                    clip: true
                    anchors.top: subBarup.bottom
                    anchors.left: subBarup.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom

                    Component{
                        id: columnComponent
                        Controls_1_4.TableViewColumn{width: 30 }
                    }
                    onCurrentIndexChanged: {
                        if(stackSubProperty.currentItem == itemDevTarir) {
                            console.log("tarDev item -active")
                            // сперва добавить всем роли
                            // TODO: hack!!!
                            var connDevId = viewController.getAvailableDevTarrirAdd_DevId()
                            var connDevType = viewController.getAvailableDevTarrirAdd_DevType()
                            for(var i=0; i<connDevId.length; i++) {
                                viewController.addTarrirDev(connDevType[i], connDevId[i])
                            }
                            addTarStepValue(0)
                            // clear tar table
                            var tarirDevType = viewController.getStayedDevTarrir_DevProperty("type")
                            var tarirDevId =  viewController.getStayedDevTarrir_DevProperty("id")
                            var tarirDevSn = viewController.getStayedDevTarrir_DevProperty("sn")
                            for(var tarcount=0; tarcount<tarirDevType.length; tarcount++) {
                                viewController.removeTarrirDev(tarirDevType[tarcount], tarirDevId[tarcount])
                            }
                            var ident = viewController.getCurrentDevProperty()
                            viewController.addTarrirDev(ident[2], ident[6])
                            timerAffterChangeTarTable.start()
                        }
                    }
                    Timer {
                        id: timerAffterChangeTarTable
                        interval: 100
                        running: false
                        repeat: false
                        onTriggered: {
                            remakeTarTable()
                            remakeTarTableChart()
                        }
                    }

                    Item {
                        ScrollView {
                            clip: true
                            anchors.fill: parent
                            Column {
                                spacing: 10
                                anchors.top: parent.top
                                anchors.topMargin: 15
                                Row{
                                    height: 100
                                    width: 500
                                    Rectangle {
                                        id:changeIdRect
                                        width: 500
                                        height: 100
                                        color: "#fdfdfb"
                                        layer.enabled: true
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        Label {
                                            text: "Смена сетевого адреса:"
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                        }
                                        Button {
                                            text: "Сменить адрес"
                                            id: changeIdAddr
                                            width: 300
                                            height: 30
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                            anchors.verticalCenter: parent.verticalCenter
                                            enabled: devPropertyProgressTmk24.isReady
                                            onClicked: {
                                                changeDeviceUniqId()
                                            }
                                        }
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                    }
                                    Button {
                                        text: "Считать настройки"
                                        id:readSetingsButton_1
                                        width: 180
                                        height: 50
                                        anchors.left: changeIdRect.right
                                        anchors.leftMargin: 15
                                        layer.enabled: true
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                        enabled: devPropertyProgressTmk24.isReady
                                        onClicked: {
                                            viewController.getCurrentDevSettings()
                                        }
                                    }
                                    Button {
                                        id:writeSettingsButton_1
                                        text: "Записать настройки"
                                        width: 180
                                        height: 50
                                        anchors.left: changeIdRect.right
                                        anchors.leftMargin: 15
                                        anchors.top: readSetingsButton_1.bottom
                                        anchors.topMargin: 15
                                        layer.enabled: true
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                        enabled: devPropertyProgressTmk24.isReady
                                        onClicked: {
                                            writeSettings()
                                        }
                                    }
                                }

                                Rectangle {
                                    width: 500
                                    height: 100
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15
                                    Label {
                                        text: "Самостоятельная выдача данных:"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    ComboBox {
                                        id: periodicSendType
                                        height: 25
                                        width: 300
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                        model: ListModel {
                                            ListElement {
                                                text: "Выключена"
                                            }
                                            ListElement {
                                                text: "Бинарная"
                                            }
                                            ListElement {
                                                text: "Символьная"
                                            }
                                        }
                                        onCurrentIndexChanged: {
                                            if(periodicSendType.currentIndex != 0) {
                                                periodicSendTime.enabled = true
                                            } else {
                                                periodicSendTime.enabled = false
                                            }
                                        }
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                                Rectangle {
                                    width: 500
                                    height: 100
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15
                                    Label {
                                        text: "Период выдачи данных (0-255), с:"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    SpinBox {
                                        id:periodicSendTime
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                        height: 25
                                        width: 200
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                                Rectangle {
                                    width: 500
                                    height: 100
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15
                                    Label {
                                        text: "Мин. значение уровня (0-1023):"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    SpinBox {
                                        id:minLevelValue
                                        height: 25
                                        width: 200
                                        to: 4095
                                        from: 0
                                        value: 0
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                                Rectangle {
                                    width: 500
                                    height: 100
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        text: "Макс.значение уровня (0-4095):"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    SpinBox {
                                        id:maxLevelValue
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                        height: 25
                                        width: 200
                                        to: 4095
                                        from: 0
                                        value: 0
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                                Rectangle {
                                    width: 500
                                    height: 100
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        text: "Параметр в выходном сообщении датчика:"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    ComboBox {
                                        id: typeOutMessage
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                        height: 25
                                        width: 300
                                        model: ListModel {
                                            ListElement {
                                                text: "Относительный уровень"
                                            }
                                            ListElement {
                                                text: "Объем (по таблице тарировки)"
                                            }
                                        }
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }

                                Rectangle {
                                    width: 500
                                    height: 100
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        text: "Скорость обмена по RS232:"
                                        id: baudrateRs232Label
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    ComboBox {
                                        id: baudrateRs232Values
                                        height: 25
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                        model: ListModel {
                                            ListElement {
                                                text: "2800"
                                            }
                                            ListElement {
                                                text: "4800"
                                            }
                                            ListElement {
                                                text: "9600"
                                            }
                                            ListElement {
                                                text: "19200"
                                            }
                                            ListElement {
                                                text: "28800"
                                            }
                                            ListElement {
                                                text: "38400"
                                            }
                                            ListElement {
                                                text: "57600"
                                            }
                                            ListElement {
                                                text: "115200"
                                            }
                                        }
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }

                                Rectangle {
                                    width: 500
                                    height: 100
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        text: "Скорость обмена по RS485:"
                                        id: baudrateRs485Label
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    ComboBox {
                                        id: baudrateRs485Values
                                        height: 25
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                        model: ListModel {
                                            ListElement {
                                                text: "2800"
                                            }
                                            ListElement {
                                                text: "4800"
                                            }
                                            ListElement {
                                                text: "9600"
                                            }
                                            ListElement {
                                                text: "19200"
                                            }
                                            ListElement {
                                                text: "28800"
                                            }
                                            ListElement {
                                                text: "38400"
                                            }
                                            ListElement {
                                                text: "57600"
                                            }
                                            ListElement {
                                                text: "115200"
                                            }
                                        }
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        ScrollView {
                            clip: true
                            anchors.fill: parent

                            Column {
                                spacing: 10
                                anchors.top: parent.top
                                anchors.topMargin: 15

                                Row{
                                    width: 500
                                    height: 180
                                    Rectangle {
                                        id:setScaleFuelLabel
                                        width: 500
                                        height: 180
                                        color: "#fdfdfb"
                                        layer.enabled: true
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15

                                        Label {
                                            id:emptyFullLabel
                                            text: qsTr("Задание границ измерения:")
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                        }
                                        Button {
                                            id: buttonEmpty
                                            text: "Пустой"
                                            width: 300
                                            height: 30
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                            anchors.top: emptyFullLabel.bottom
                                            anchors.topMargin: 10
                                            onClicked: {
                                                dialogLevelSetEmpty.open()
                                            }
                                            enabled: devPropertyProgressTmk24.isReady
                                        }
                                        Button {
                                            id: buttonFull
                                            text: "Полный"
                                            width: 300
                                            height: 30
                                            anchors.top: buttonEmpty.bottom
                                            anchors.topMargin: 10
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                            onClicked: {
                                                dialogLevelSetFull.open()
                                            }
                                            enabled: devPropertyProgressTmk24.isReady
                                        }
                                        Button {
                                            id: buttonEdit
                                            width: 300
                                            height: 30
                                            text: "Редактировать"
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                            anchors.top: buttonFull.bottom
                                            anchors.topMargin: 10
                                            enabled: false //devPropertyProgressTmk24.isReady
                                        }
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                    }
                                    Button {
                                        text: "Считать настройки"
                                        id:readSetingsButton_2
                                        width: 180
                                        height: 50
                                        anchors.left: setScaleFuelLabel.right
                                        anchors.leftMargin: 15
                                        layer.enabled: true
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                        enabled: devPropertyProgressTmk24.isReady
                                        onClicked: {
                                            viewController.getCurrentDevSettings()
                                        }
                                    }
                                    Button {
                                        id:writeSettingsButton_2
                                        text: "Записать настройки"
                                        width: 180
                                        height: 50
                                        anchors.left: setScaleFuelLabel.right
                                        anchors.leftMargin: 15
                                        anchors.top: readSetingsButton_2.bottom
                                        anchors.topMargin: 15
                                        layer.enabled: true
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                        enabled: devPropertyProgressTmk24.isReady
                                        onClicked: {
                                            writeSettings()
                                        }
                                    }
                                }
                                Rectangle {
                                    width: 500
                                    height: 100
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        text: "Тип жидкости"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    ComboBox {
                                        id: typeFuel
                                        height: 25
                                        width: 300
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                        model: ListModel {
                                            ListElement {
                                                text: "Топливо"
                                            }
                                            ListElement {
                                                text: "Вода"
                                            }
                                        }
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        ScrollView {
                            clip: true
                            anchors.fill: parent
                            Column {
                                spacing: 10
                                anchors.top: parent.top
                                anchors.topMargin: 15
                                Row{
                                    width: 500
                                    height: 80
                                    Rectangle {
                                        id:typeInterpolationRect
                                        width: 500
                                        height: 80
                                        color: "#fdfdfb"
                                        layer.enabled: true
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15

                                        Label {
                                            text: "Тип интерполяции:"
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                        }
                                        ComboBox {
                                            id: typeInterpolation
                                            height: 25
                                            width: 300
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                            anchors.verticalCenter: parent.verticalCenter
                                            model: ListModel {
                                                ListElement {
                                                    text: "Линейная"
                                                }
                                                ListElement {
                                                    text: "Квадратичная"
                                                }
                                                ListElement {
                                                    text: "Сплайновая"
                                                }
                                            }
                                        }
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                    }
                                    Button {
                                        text: "Считать настройки"
                                        id:readSetingsButton_3
                                        width: 180
                                        height: 50
                                        anchors.left: typeInterpolationRect.right
                                        anchors.leftMargin: 15
                                        layer.enabled: true
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                        enabled: devPropertyProgressTmk24.isReady
                                        onClicked: {
                                            viewController.getCurrentDevSettings()
                                        }
                                    }
                                    Button {
                                        id:writeSettingsButton_3
                                        text: "Записать настройки"
                                        width: 180
                                        height: 50
                                        anchors.left: typeInterpolationRect.right
                                        anchors.leftMargin: 15
                                        anchors.top: readSetingsButton_3.bottom
                                        anchors.topMargin: 15
                                        layer.enabled: true
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                        enabled: devPropertyProgressTmk24.isReady
                                        onClicked: {
                                            writeSettings()
                                        }
                                    }
                                }
                                //1
                                Rectangle {
                                    id:typeFiltrationRectangle
                                    width: 500
                                    height: 80
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        text: "Тип фильтрации:"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    ComboBox {
                                        id: typeFiltration
                                        height: 25
                                        width: 300
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.topMargin: 10
                                        model: ListModel {
                                            ListElement {
                                                text: "Выключена"
                                            }
                                            ListElement {
                                                text: "Усреднение"
                                            }
                                            ListElement {
                                                text: "Медиана"
                                            }
                                            ListElement {
                                                text: "Адаптивный"
                                            }
                                        }
                                        onCurrentIndexChanged: {
                                            if(typeFiltration.currentIndex == 0) {
                                                filterAvarageValueSec.enabled = false
                                                filterLenghtMediana.enabled = false
                                                filterValueQ.enabled = false
                                                filterValueR.enabled = false
                                            } else if(typeFiltration.currentIndex == 1) {
                                                filterAvarageValueSec.enabled = true
                                                filterLenghtMediana.enabled = false
                                                filterValueQ.enabled = false
                                                filterValueR.enabled = false
                                            } else if(typeFiltration.currentIndex == 2) {
                                                filterAvarageValueSec.enabled = true
                                                filterLenghtMediana.enabled = true
                                                filterValueQ.enabled = false
                                                filterValueR.enabled = false
                                            } else if(typeFiltration.currentIndex == 3) {
                                                filterAvarageValueSec.enabled = false
                                                filterLenghtMediana.enabled = false
                                                filterValueQ.enabled = true
                                                filterValueR.enabled = true
                                            }
                                        }
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                                //2
                                Rectangle {
                                    id:typeAvarageRectangle
                                    width: 500
                                    height: 80
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        text: "Время усреднения (0-21), с:"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    SpinBox {
                                        id: filterAvarageValueSec
                                        height: 25
                                        width: 200
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.topMargin: 10
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                                //3
                                Rectangle {
                                    id:lenMedianaRectangle
                                    width: 500
                                    height: 80
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        text: "Длина медианы (0-7):"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    SpinBox {
                                        id: filterLenghtMediana
                                        height: 25
                                        width: 200
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                                //4
                                Rectangle {
                                    id:covairachiaRectangle
                                    width: 500
                                    height: 80
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        text: "Ковариация шума процесса (Q):"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    SpinBox {
                                        id: filterValueQ
                                        height: 25
                                        width: 200
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.top: emptyFullLabel.bottom
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.topMargin: 10
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                                //5
                                Rectangle {
                                    width: 500
                                    height: 80
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        text: "Ковариация шума измерения (R):"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    SpinBox {
                                        id: filterValueR
                                        height: 25
                                        width: 200
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.topMargin: 10
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        ScrollView {
                            clip: true
                            anchors.fill: parent
                            Column {
                                spacing: 10
                                anchors.top: parent.top
                                anchors.topMargin: 15
                                //1
                                Row {
                                    width: 500
                                    height: 100
                                    Rectangle {
                                        id:termocomRectangle
                                        width: 500
                                        height: 100
                                        color: "#fdfdfb"
                                        layer.enabled: true
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15

                                        Label {
                                            text: qsTr("Температурная компенсация линейного расширения топлива\nРежим:")
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                        }
                                        ComboBox {
                                            id: typeTempCompensation
                                            width: 300
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                            anchors.top: emptyFullLabel.bottom
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.topMargin: 10
                                            height: 25
                                            model: ListModel {
                                                ListElement {
                                                    text: "Выключен"
                                                }
                                                ListElement {
                                                    text: "АИ-95"
                                                }
                                                ListElement {
                                                    text: "АИ-92"
                                                }
                                                ListElement {
                                                    text: "АИ-80 (лето)"
                                                }
                                                ListElement {
                                                    text: "АИ-80 (зима)"
                                                }
                                                ListElement {
                                                    text: "ДТ (лето)"
                                                }
                                                ListElement {
                                                    text: "ДТ (зима)"
                                                }
                                                ListElement {
                                                    text: "Пользовательский"
                                                }
                                            }
                                            onCurrentIndexChanged: {
                                                if(typeTempCompensation.currentIndex == 7) {
                                                    k1.enabled = true
                                                    k2.enabled = true
                                                } else {
                                                    k1.enabled = false
                                                    k2.enabled = false
                                                }
                                            }
                                        }
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                    }
                                    Button {
                                        text: "Считать настройки"
                                        id:readSetingsButton_4
                                        width: 180
                                        height: 50
                                        anchors.left: termocomRectangle.right
                                        anchors.leftMargin: 15
                                        layer.enabled: true
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                        enabled: devPropertyProgressTmk24.isReady
                                        onClicked: {
                                            viewController.getCurrentDevSettings()
                                        }
                                    }
                                    Button {
                                        id:writeSettingsButton_4
                                        text: "Записать настройки"
                                        width: 180
                                        height: 50
                                        anchors.left: termocomRectangle.right
                                        anchors.leftMargin: 15
                                        anchors.top: readSetingsButton_4.bottom
                                        anchors.topMargin: 15
                                        layer.enabled: true
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                        enabled: devPropertyProgressTmk24.isReady
                                        onClicked: {
                                            writeSettings()
                                        }
                                    }
                                }
                                //2
                                Rectangle {
                                    width: 500
                                    height: 80
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        text: qsTr("K1:")
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    TextField {
                                        id: k1
                                        text: "0.0"
                                        height: 25
                                        width: 300
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.top: emptyFullLabel.bottom
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.topMargin: 10
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                                //3
                                Rectangle {
                                    width: 500
                                    height: 80
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        text: qsTr("K2:")
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    TextField {
                                        id: k2
                                        text: "0.0"
                                        height: 25
                                        width: 300
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.top: emptyFullLabel.bottom
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.topMargin: 10
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        ScrollView {
                            clip: true
                            anchors.fill: parent
                            Column {
                                spacing: 10
                                anchors.top: parent.top
                                anchors.topMargin: 15
                                //1
                                Row {
                                    width: 500
                                    height: 150

                                    Rectangle {
                                        id:setSlaveMasterModeRectangle
                                        width: 500
                                        height: 150
                                        color: "#fdfdfb"
                                        layer.enabled: true
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15

                                        Label {
                                            text: "Режим ведущий/ведомый:"
                                            id:labelSlaveModes
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                        }
                                        ComboBox {
                                            id: masterSlaveModes
                                            width: 200
                                            height: 30
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                            anchors.top: labelSlaveModes.bottom
                                            anchors.topMargin: 15
                                            model: ListModel {
                                                ListElement {
                                                    text: "Выключен"
                                                }
                                                ListElement {
                                                    text: "Ведомый"
                                                }
                                                ListElement {
                                                    text: "Ведущий"
                                                }
                                                ListElement {
                                                    text: "Трансляция"
                                                }
                                            }
                                            onCurrentIndexChanged: {
                                                if(masterSlaveModes.currentIndex == 2) {
                                                    //masterSlavesAddresRectange.enabled = true
                                                } else {
                                                    //masterSlavesAddresRectange.enabled = false
                                                    masterSlaveFullCountes.value = 0
                                                }
                                            }
                                        }

                                        Label {
                                            id: masterSlaveModeCountAllLabel
                                            text: "Количество ведомых:"
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                            anchors.top: masterSlaveModes.bottom
                                            anchors.topMargin: 15
                                        }
                                        SpinBox {
                                            id: masterSlaveFullCountes
                                            width: 200
                                            height: 25
                                            anchors.left: parent.left
                                            anchors.leftMargin: 15
                                            anchors.topMargin: 15
                                            anchors.top: masterSlaveModeCountAllLabel.bottom
                                            from: 0
                                            to: 4
                                            onValueChanged: {
                                                if(masterSlaveFullCountes.value >= 1) {
                                                    masterSlaveSlaveId_1.enabled = true
                                                } else {
                                                    masterSlaveFullCountes.value = 0
                                                    masterSlaveModes.currentIndex = 0
                                                    masterSlaveSlaveId_1.enabled = false
                                                    masterSlaveSlaveId_2.enabled = false
                                                    masterSlaveSlaveId_3.enabled = false
                                                    masterSlaveSlaveId_4.enabled = false
                                                }
                                                if(masterSlaveFullCountes.value >= 2) {
                                                    masterSlaveSlaveId_2.enabled = true
                                                } else {
                                                    masterSlaveSlaveId_2.enabled = false
                                                }
                                                if(masterSlaveFullCountes.value >= 3) {
                                                    masterSlaveSlaveId_3.enabled = true
                                                } else {
                                                    masterSlaveSlaveId_3.enabled = false
                                                }
                                                if(masterSlaveFullCountes.value >= 4) {
                                                    masterSlaveSlaveId_4.enabled = true
                                                } else {
                                                    masterSlaveSlaveId_4.enabled = false
                                                }
                                            }
                                        }
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                    }
                                    Button {
                                        text: "Считать настройки"
                                        id:readSetingsButton_5
                                        width: 180
                                        height: 50
                                        anchors.left: setSlaveMasterModeRectangle.right
                                        anchors.leftMargin: 15
                                        layer.enabled: true
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                        enabled: devPropertyProgressTmk24.isReady
                                        onClicked: {
                                            viewController.getCurrentDevSettings()
                                        }
                                    }
                                    Button {
                                        id:writeSettingsButton_5
                                        text: "Записать настройки"
                                        width: 180
                                        height: 50
                                        anchors.left: setSlaveMasterModeRectangle.right
                                        anchors.leftMargin: 15
                                        anchors.top: readSetingsButton_5.bottom
                                        anchors.topMargin: 15
                                        layer.enabled: true
                                        layer.effect: DropShadow {
                                            transparentBorder: true
                                            horizontalOffset: 0
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            samples: 10
                                            radius: 20
                                        }
                                        enabled: devPropertyProgressTmk24.isReady
                                        onClicked: {
                                            writeSettings()
                                        }
                                    }
                                }
                                Rectangle {
                                    width: 500
                                    height: 300
                                    color: "#fdfdfb"
                                    layer.enabled: true
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Label {
                                        id: masterSlaveAddress_1
                                        text: "Адрес ведомого №1"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                    }
                                    SpinBox {
                                        id: masterSlaveSlaveId_1
                                        from: 1
                                        to: 254
                                        height: 25
                                        width: 200
                                        anchors.top: masterSlaveAddress_1.bottom
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.topMargin: 15
                                    }
                                    Label {
                                        text: "Адрес ведомого №2"
                                        id: masterSlaveAddress_2
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.top: masterSlaveSlaveId_1.bottom
                                        anchors.topMargin: 15
                                    }
                                    SpinBox {
                                        id: masterSlaveSlaveId_2
                                        height: 25
                                        from: 1
                                        to: 254
                                        width: 200
                                        anchors.top: masterSlaveAddress_2.bottom
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.topMargin: 15
                                    }
                                    Label {
                                        text: "Адрес ведомого №3"
                                        id: masterSlaveAddress_3
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.top: masterSlaveSlaveId_2.bottom
                                        anchors.topMargin: 15
                                    }
                                    SpinBox {
                                        id: masterSlaveSlaveId_3
                                        height: 25
                                        from: 1
                                        to: 254
                                        width: 200
                                        anchors.top: masterSlaveAddress_3.bottom
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.topMargin: 15
                                    }
                                    Label {
                                        text: "Адрес ведомого №4"
                                        id: masterSlaveAddress_4
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.top: masterSlaveSlaveId_3.bottom
                                        anchors.topMargin: 15
                                    }
                                    SpinBox {
                                        id: masterSlaveSlaveId_4
                                        height: 25
                                        from: 1
                                        width: 200
                                        to: 254
                                        anchors.top: masterSlaveAddress_4.bottom
                                        anchors.left: parent.left
                                        anchors.leftMargin: 15
                                        anchors.topMargin: 15
                                    }
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 1
                                        color: "#e0e5ef"
                                        samples: 10
                                        radius: 20
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        id:itemDevTarir
                        ScrollView {
                            clip: true
                            anchors.fill: parent

                            Column {
                                spacing: 10
                                anchors.top: parent.top
                                anchors.topMargin: 15
                                anchors.left: parent.left
                                anchors.leftMargin: 15
                                Row {
                                    id:tarRowRoot1
                                    spacing: 10
                                    Rectangle {
                                        radius: 20
                                        width: stackSubProperty.width - 30
                                        height: stackSubProperty.height - 10
                                        color: "transparent"
                                        layer.enabled: true
                                        layer.effect: DropShadow {
                                            verticalOffset: 1
                                            color: "#e0e5ef"
                                            radius: 20
                                        }
                                        Rectangle {
                                            id:tarTabRectangleMultiple
                                            anchors.left: parent.left
                                            anchors.top: parent.top
                                            height: parent.height - 70
                                            width: parent.width / 2
                                            Controls_1_4.TableView {
                                                id:tarTabViewMultiple
                                                anchors.left: parent.left
                                                anchors.top: parent.top
                                                height: parent.height / 2
                                                width: parent.width

                                                model: ListModel {
                                                    id: tarTableListModelMultiple
                                                }
                                                onCurrentRowChanged: {
                                                    tarTabViewMultiple.selection.clear()
                                                    tarTabViewMultiple.selection.select(tarTabViewMultiple.currentRow)
                                                }

                                                rowDelegate: Rectangle {
                                                    SystemPalette {
                                                        id: systemPaletteMultiple
                                                        colorGroup: SystemPalette.Active
                                                    }
                                                    color: {
                                                        var baseColor = styleData.alternate ? systemPaletteMultiple.alternateBase : systemPaletteMultiple.base
                                                        return styleData.selected ? "orange" : baseColor
                                                    }
                                                }
                                            }
                                            ChartView {
                                                id: chartTarTableMultiple
                                                anchors.top: tarTabViewMultiple.bottom
                                                anchors.topMargin: 5
                                                anchors.left: parent.left
                                                height: parent.height / 2
                                                width: parent.width
                                                theme: ChartView.ChartThemeBlueCerulean
                                                clip: true
                                                antialiasing: true
                                                title: "Отношение уровня к объему"
                                                property int chartTarTableLength: 1
                                                property int chartTarTableAmplitudeMax: 1
                                                ValueAxis {
                                                    id: chartTarTableAxisXMultiple
                                                    min: 0
                                                    max: chartTarTableMultiple.chartTarTableLength
                                                    tickCount: 5
                                                }
                                                ValueAxis {
                                                    id: chartTarTableAxisYMultiple
                                                    min: 0
                                                    max: chartTarTableMultiple.chartTarTableAmplitudeMax
                                                    tickCount: 5
                                                }
                                            }
                                            Rectangle {
                                                id:tarTabRectangleCurrentValuesMultiple
                                                anchors.left: tarTabRectangleMultiple.right
                                                anchors.leftMargin: 10
                                                anchors.top: parent.top
                                                radius: 20
                                                width: parent.width - 5
                                                height: parent.height / 2// + 40
                                                color: "#ffffff"

                                                ListView {
                                                    id: tarListDevice
                                                    clip: true
                                                    height: parent.height
                                                    width: parent.width - 10
                                                    ScrollBar.vertical: ScrollBar {
                                                        width: 20
                                                    }
                                                    delegate: Item {
                                                        id: tarListDeviceDelegate
                                                        height: 70
                                                        width: parent.width

                                                        Rectangle {
                                                            id:tarTabRectangleCurrLevelMultiple
                                                            anchors.left: parent.left
                                                            anchors.leftMargin: 2
                                                            anchors.top: parent.top
                                                            radius: 20
                                                            width: parent.width / 2 - 15
                                                            height: parent.height
                                                            color: "transparent"

                                                            Label {
                                                                id: levelTarCurrCntLabelMultiple
                                                                text: qsTr("%1\nSN[%2]\nID[%3]").arg(model.devTyp).arg(model.devSn).arg(model.devId)
                                                                anchors.left: parent.left
                                                                color: "#888d91"
                                                                anchors.leftMargin: 15
                                                                anchors.right: parent.right
                                                                anchors.rightMargin: 0
                                                            }
                                                            TextField {
                                                                id:levelTarCurrCntValueMultiple
                                                                anchors.left: levelTarCurrCntLabelMultiple.right
                                                                width: 120
                                                                height: 50
                                                                background: Rectangle {
                                                                    color: "#05fF00"
                                                                    height: parent.height
                                                                }
                                                                text: model.valueCnt
                                                                readOnly: true
                                                            }
                                                            TextField {
                                                                id:levelTarCurrCntValuesMultiple
                                                                anchors.left: levelTarCurrCntValueMultiple.right
                                                                width: 120
                                                                height: 50
                                                                background: Rectangle {
                                                                    color: "#080ff0"
                                                                    height: parent.height
                                                                }
                                                                text: model.valueFuelLevel
                                                                color: "white"
                                                                readOnly: true
                                                            }
                                                        }
                                                    }
                                                    model: ListModel {
                                                        id: logItemModel
                                                    }
                                                }
                                            }
                                            Rectangle {
                                                color: "#ffffff"
                                                anchors.top: tarTabRectangleCurrentValuesMultiple.bottom
                                                anchors.left: tarTabRectangleMultiple.right
                                                anchors.leftMargin: 10
                                                radius: 20
                                                width: parent.width - 5
                                                anchors.topMargin: 10
                                                height: parent.height / 2 - 10
                                                ChartView {
                                                    id: chartTarCurrentValuesMultiple
                                                    anchors.fill: parent
                                                    theme: ChartView.ChartThemeLight
                                                    title: "Уровень/Объем"
                                                    antialiasing: true
                                                    property int graphLength: 1
                                                    property int graphAmplitudeMax: 1
                                                    backgroundColor: "transparent"
                                                    property alias animateColorUp: animateColorUpMultiple
                                                    property alias animateColorDown: animateColorDownMultiple
                                                    PropertyAnimation {id: animateColorUpMultiple; target: chartTarCurrentValuesMultiple; properties: "backgroundColor"; to: "#d9d9d9"; duration: 1000
                                                        onStopped: {
                                                            chartTarCurrentValuesMultiple.animateColorDown.start()
                                                        }
                                                        onStarted: {
                                                            isNoiseDetected = true
                                                        }
                                                    }
                                                    PropertyAnimation {id: animateColorDownMultiple; target: chartTarCurrentValuesMultiple; properties: "backgroundColor"; to: "transparent"; duration: 1000
                                                        onStopped: {
                                                            isNoiseDetected = false
                                                        }
                                                    }

                                                    ValueAxis {
                                                        id: currentTarChartAxisXMultiple
                                                        min: 0
                                                        max: chartCurrentValue.graphLength
                                                        tickCount: 5
                                                    }
                                                    ValueAxis {
                                                        id: currentTarChartAxisYMultiple
                                                        min: -0.1
                                                        max: chartCurrentValue.graphAmplitudeMax
                                                        tickCount: 5
                                                    }
                                                    enabled: devPropertyProgressTmk24.isReady
                                                }
                                            }
                                        }
                                        Rectangle {
                                            anchors.top: tarTabRectangleMultiple.bottom
                                            anchors.topMargin: 10
                                            radius: 20
                                            width: stackSubProperty.width -15
                                            height: 50
                                            color: "transparent"
                                            layer.enabled: true
                                            layer.effect: DropShadow {
                                                transparentBorder: true
                                                horizontalOffset: 0
                                                verticalOffset: 1
                                                color: "#e0e5ef"
                                                samples: 10
                                                radius: 10
                                            }
                                            Row{
                                                ButtonRound {
                                                    id:tarBatButtonsMultiple
                                                    textLine:2
                                                    widthBody: 150
                                                    name: qsTr("Добавить\nтекущее значение")
                                                    enabled: devPropertyProgressTmk24.isReady
                                                    onClicked: {
                                                        if(!isNoiseDetected) {
                                                            addTarStepValue(tarTabViewMultiple.currentRow)
                                                        } else {
                                                            dialogAddTarValueWhenNoiseDetectedMultiple.open()
                                                        }
                                                    }
                                                    Dialog {
                                                        id: dialogAddTarValueWhenNoiseDetectedMultiple
                                                        title: "Добавление значения в таблицу"
                                                        standardButtons: StandardButton.Close | StandardButton.Apply
                                                        Rectangle {
                                                            color: "transparent"
                                                            implicitWidth: 500
                                                            implicitHeight: 50
                                                            Text {
                                                                text: "Обнаружен шум показаний\nДействительно добавить это значение?"
                                                                color: "black"
                                                                anchors.centerIn: parent
                                                            }
                                                        }
                                                        onApply: {
                                                            addTarStepValue(tarTabViewMultiple.currentRow)
                                                            close()
                                                        }
                                                    }
                                                }
                                                ButtonRound {
                                                    id:tarTabRemoveStepMultiple
                                                    textLine:2
                                                    widthBody: 100
                                                    name: qsTr("Удалить\nзначение")
                                                    Dialog {
                                                        id: dialogRemoveTarTableRowMultiple
                                                        title: "Удаление записи таблицы"
                                                        standardButtons: StandardButton.Apply
                                                        Rectangle {
                                                            color: "transparent"
                                                            implicitWidth: 500
                                                            implicitHeight: 50
                                                            Text {
                                                                text: "Для удаления сначала кликните по удалялемой строке в таблице"
                                                                color: "black"
                                                                anchors.centerIn: parent
                                                            }
                                                        }
                                                        onApply: {
                                                            close()
                                                        }
                                                    }
                                                    onClicked: {
                                                        if(tarTabViewMultiple.currentRow === -1) {
                                                            dialogRemoveTarTableRowMultiple.open()
                                                        } else {
                                                            removeTarStepValue(tarTabViewMultiple.currentRow)
                                                            timerAffterRefrashTarTable.start()
                                                        }
                                                    }
                                                }
                                                ButtonRound {
                                                    id:tarTabRemoveAddDeviceMultiple
                                                    textLine:2
                                                    widthBody: 165
                                                    name: qsTr("Добавить/Удалить\nустройство")
                                                    onClicked: {
                                                        addDeviceTarirDialog.parent = devPropertyProgressTmk24
                                                        addDeviceTarirDialog.open()
                                                    }
                                                    AddDeviceTarirDialog {
                                                        id:addDeviceTarirDialog
                                                        onAccepted: {
                                                            console.log("AddDeviceTarirDialog-accepted = " + deviceTypeName.length + deviceId.length + deviceSerialNumber.length)
                                                            var tarirDevType = viewController.getStayedDevTarrir_DevProperty("type")
                                                            var tarirDevId =  viewController.getStayedDevTarrir_DevProperty("id")
                                                            var tarirDevSn = viewController.getStayedDevTarrir_DevProperty("sn")
                                                            // обновляем таблицу dev
                                                            for(var tarcount=0; tarcount<tarirDevType.length; tarcount++) {
                                                                viewController.removeTarrirDev(tarirDevType[tarcount], tarirDevId[tarcount])
                                                            }
                                                            for(var devcount=0; devcount<deviceId.length; devcount++) {
                                                                viewController.addTarrirDev(deviceTypeName[devcount], deviceId[devcount])
                                                            }
                                                            timerAffterAddRemoveDevTarTable.start()
                                                        }
                                                    }
                                                    Timer {
                                                        id: timerAffterAddRemoveDevTarTable
                                                        interval: 100
                                                        running: false
                                                        repeat: false
                                                        onTriggered: {
                                                            remakeTarTable()
                                                            remakeTarTableChart()
                                                        }
                                                    }
                                                }
                                                ButtonRound {
                                                    id:tarTabReadTableMultiple
                                                    textLine: 2
                                                    name:"Считать\nтаблицу"
                                                    enabled: devPropertyProgressTmk24.isReady
                                                    onClicked: {
                                                        dialogReadTarTableMultiple.open()
                                                    }
                                                    Dialog {
                                                        id: dialogReadTarTableMultiple
                                                        visible: false
                                                        title: "Чтение записей таблицы из устройства"
                                                        standardButtons: StandardButton.Close | StandardButton.Apply
                                                        Rectangle {
                                                            color: "transparent"
                                                            implicitWidth: 500
                                                            implicitHeight: 50
                                                            Text {
                                                                text: "Считать данные?\nВсе не сохраненные изменения будут утеряны!\nВы уверены?"
                                                                color: "black"
                                                                anchors.centerIn: parent
                                                            }
                                                        }
                                                        onApply: {
                                                            remakeTarTable()
                                                            viewController.sendReqGetTarrirAllDev()
                                                            close()
                                                        }
                                                    }
                                                }
                                                ButtonRound {
                                                    id:tarTabWriteTableMultiple
                                                    textLine: 2
                                                    name:"Записать\nтаблицу"
                                                    enabled: devPropertyProgressTmk24.isReady
                                                    Dialog {
                                                        id: dialogWriteTarTableMultipleRequest
                                                        visible: false
                                                        title: "Запись таблицы"
                                                        standardButtons: StandardButton.Close | StandardButton.Apply
                                                        Rectangle {
                                                            color: "transparent"
                                                            implicitWidth: 500
                                                            implicitHeight: 50
                                                            Text {
                                                                text: "Записать таблицу в устройство!\nВы уверены?"
                                                                color: "black"
                                                                anchors.centerIn: parent
                                                            }
                                                        }
                                                        onApply: {
                                                            writeTarTable()
                                                            close()
                                                        }
                                                    }
                                                    Dialog {
                                                        id: dialogWriteTarTableMultipleWarningOverSize
                                                        visible: false
                                                        title: "Запись таблицы"
                                                        standardButtons: StandardButton.Apply
                                                        Rectangle {
                                                            color: "transparent"
                                                            implicitWidth: 500
                                                            implicitHeight: 50
                                                            Text {
                                                                text: "Данных больше размера памяти в устройстве\nЗапись не возможна"
                                                                color: "black"
                                                                anchors.centerIn: parent
                                                            }
                                                        }
                                                        onApply: {
                                                            close()
                                                        }
                                                    }
                                                    Dialog {
                                                        id: dialogWriteTarTableMultipleWarningEmpty
                                                        visible: false
                                                        title: "Запись таблицы"
                                                        standardButtons: StandardButton.Apply
                                                        Rectangle {
                                                            color: "transparent"
                                                            implicitWidth: 500
                                                            implicitHeight: 50
                                                            Text {
                                                                text: "Нет данных для записи!"
                                                                color: "black"
                                                                anchors.centerIn: parent
                                                            }
                                                        }
                                                        onApply: {
                                                            close()
                                                        }
                                                    }
                                                    onClicked: {
                                                        if(tarTabViewMultiple.model.count > 0) {
                                                            if(tarTabViewMultiple.model.count < 30) {
                                                                dialogWriteTarTableMultipleRequest.open()
                                                            } else {
                                                                dialogWriteTarTableMultipleWarningOverSize.open()
                                                            }
                                                        } else {
                                                            dialogWriteTarTableMultipleWarningEmpty.open()
                                                        }
                                                    }
                                                }
                                                ButtonRound {
                                                    id:tarTabTableExportMultiple
                                                    textLine: 2
                                                    name:"Выгрузить\n.csv"
                                                    widthBody: 110
                                                    FileDialog {
                                                        id: dialogExportTarTableMultiple
                                                        folder: shortcuts.home
                                                        selectMultiple: false
                                                        selectFolder: false
                                                        title: "Save to file"
                                                        nameFilters: [ "All files (*)" ]
                                                        selectExisting: false
                                                        onAccepted: {
                                                            if(dialogExportTarTableMultiple.selectExisting == true) {
                                                                console.log(dialogExportTarTableMultiple.fileUrl)
                                                            }
                                                            else {
                                                                console.log(dialogExportTarTableMultiple.fileUrl)
                                                                console.log("You chose: " + dialogExportTarTableMultiple.fileUrls)
                                                                var tarArrayLiters = [];
                                                                var tarArrayFuelLevel = [];
                                                                for(var i=0; i<tarTabView.rowCount; i++) {
                                                                    var item = tarTabView.model.get(i)
                                                                    tarArrayLiters.push(item.Level)
                                                                    tarArrayFuelLevel.push(item.Value)
                                                                }
                                                                viewController.setCurrentDevExportTarTable(dialogExportTarTableMultiple.fileUrls, tarArrayLiters,tarArrayFuelLevel)
                                                            }
                                                        }
                                                    }
                                                    onClicked: {
                                                        dialogExportTarTableMultiple.open()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id:busyIndicator
        width: 350
        height: 200
        radius: 20
        property string message: "Ожидание ответа..."
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: devPropertyProgressTmk24.isReady ? false : true
        BusyIndicator {
            id:waitReadyIndicator
            width: 96
            height: 96
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        Label {
            text: busyIndicator.message
            anchors.top: waitReadyIndicator.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 1
            color: "#e0e5ef"
            samples: 10
            radius: 10
        }
    }

    ChangeDevIdName {
        id:changeDevId
    }

    Dialog {
        id: dialogLevelSetEmpty
        visible: false
        title: "Смена уровня Min-Max"
        standardButtons: StandardButton.Close | StandardButton.Apply
        Rectangle {
            color: "transparent"
            implicitWidth: 250
            implicitHeight: 100
            Text {
                text: "Присвоить уровень \"Минимум\""
                color: "black"
                anchors.centerIn: parent
            }
        }
        onApply: {
            viewController.setCurrentDevLevelAsEmpty()
            close()
        }
    }
    Dialog {
        id: dialogLevelSetFull
        visible: false
        title: "Смена уровня Min-Max"
        standardButtons: StandardButton.Close | StandardButton.Apply
        Rectangle {
            color: "transparent"
            implicitWidth: 250
            implicitHeight: 100
            Text {
                text: "Присвоить уровень \"Максимум\""
                color: "black"
                anchors.centerIn: parent
            }
        }
        onApply: {
            viewController.setCurrentDevLevelAsFull()
            close()
        }
    }
    Dialog {
        id: messageMinMaxWriteOk
        visible: false
        title: "Задание границ измерения"
        standardButtons: StandardButton.Apply
        width: 500
        height: 150
        Rectangle {
            color: "transparent"
            anchors.fill: parent
            Text {
                text: qsTr("Задание границы измерения успешно выполнено")
                color: "black"
                anchors.centerIn: parent
            }
        }
        onApply: {
            close()
        }
    }
    Dialog {
        id: messageReadSettingsOk
        visible: false
        title: "Чтение настроек"
        standardButtons: StandardButton.Apply
        width: 500
        height: 150
        Rectangle {
            color: "transparent"
            anchors.fill: parent
            Text {
                text: qsTr("Чтение настроек успешно выполнено")
                color: "black"
                anchors.centerIn: parent
            }
        }
        onApply: {
            close()
        }
    }
    Dialog {
        id: messageWriteSettingsOk
        visible: false
        title: "Запись настроек"
        standardButtons: StandardButton.Apply
        width: 500
        height: 150
        Rectangle {
            color: "transparent"
            anchors.fill: parent
            Text {
                text: qsTr("Запись настроек успешно выполнена")
                color: "black"
                anchors.centerIn: parent
            }
        }
        onApply: {
            close()
        }
    }
    Dialog {
        id: messageReadErrorsOk
        visible: false
        title: "Чтение ошибок"
        standardButtons: StandardButton.Apply
        width: 500
        height: 150
        Rectangle {
            color: "transparent"
            anchors.fill: parent
            Text {
                text: qsTr("Ошибки считаны успешно")
                color: "black"
                anchors.centerIn: parent
            }
        }
        onApply: {
            close()
        }
    }
    Dialog {
        id: messageReadTarTableOk
        property var message: ""
        visible: false
        title: "Запись таблицы"
        standardButtons: StandardButton.Apply
        width: 500
        height: 150
        Rectangle {
            color: "transparent"
            anchors.fill: parent
            Text {
                text: qsTr("Результат:\n" + messageReadTarTableOk.message)
                color: "black"
                anchors.centerIn: parent
            }
        }
        onApply: {
            close()
        }
    }
    Dialog {
        id: messageReadTarTableEmpty
        visible: false
        title: "Чтение таблицы"
        standardButtons: StandardButton.Apply
        width: 500
        height: 150
        Rectangle {
            color: "transparent"
            anchors.fill: parent
            Text {
                text: qsTr("Для этого/этих устройств нет данных о таблице\nВозможно ее нет\nТогда ее требуется создать!")
                color: "black"
                anchors.centerIn: parent
            }
        }
        onApply: {
            close()
        }
    }
    Timer {
        id: timerAffterRefrashTarTable
        interval: 100
        running: false
        repeat: false
        onTriggered: {
            remakeTarTableChart()
        }
    }
}