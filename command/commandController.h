#ifndef COMMANDCONTROLLER_H
#define COMMANDCONTROLLER_H

#include <QObject>
#include <QQueue>
#include <QPair>

class CommandController : public QObject
{
    Q_OBJECT
public:
    explicit CommandController(QObject *parent = nullptr);

    typedef enum {
        E_CommandType_Typical, // typical for normal poll
        E_CommandType_OnceSecurityPacket // for check device id before add
    }eCommandType;

    typedef struct {
        eCommandType commandType;
        // uniqual ident device
        QString deviceIdent;
        QString deviceTypeName;
        // dev command
        int devCommand;
        // need ack what command executed?
        bool isNeedAckMessage;
        // bytearray for command buf
        QByteArray commandOptionData;
        // buffer for transmit settings, firmware and other data
        struct {
            QList<QString>key;
            QList<QString>value;
        }args;
        bool isNeedIncreasedDelay;       
        QString operationHeader;
    }sCommandData;

    bool addCommandToStack(sCommandData commandData);
    QPair<bool, CommandController::sCommandData> getCommandFirstCommand();
    void removeFirstCommand();
    bool commandsIsEmpty();

private:

    QQueue<sCommandData> commandQueue;
};

#endif // COMMANDCONTROLLER_H
