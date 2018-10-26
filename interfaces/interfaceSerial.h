#ifndef INTERFACESERIAL_H
#define INTERFACESERIAL_H

#include <QObject>
#include "interfacesAbstract.h"
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QTimer>
#include "device/devicesFactory.h"

class InterfaceSerial : public interfacesAbstract
{
    Q_OBJECT
public:
    InterfaceSerial(QString name, QPair<QStringList,QStringList>param);
    ~InterfaceSerial();
public slots:

    void initInterface() override;
    bool openInterface() override;
    bool isOpen() override;
    void closeInterface() override;
    bool sendData(QByteArray &pData) override;
    bool readData(QByteArray &pData) override;
    QString getInterfaceName() override;
    QPair<QStringList,QStringList> getInterfaceProperty() override;
    QStringList getAvailableList() override;
    QString getType() override;
    DevicesFactory* getDeviceFactory() override;

private slots:
    bool writeData(QByteArray data);
    void readData();
    void errorHanler(QSerialPort::SerialPortError err);
private:
    DevicesFactory *deviceFactory;

private:

    static constexpr char* typeName = "serial";
    QSerialPort *portHandler = nullptr;
    QString name;
    QPair<QStringList,QStringList>param;
};

#endif // INTERFACESERIAL_H
