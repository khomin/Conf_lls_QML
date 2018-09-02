#ifndef CONNECTIONFACTORY_H
#define CONNECTIONFACTORY_H

#include <QObject>
#include <QMultiMap>
#include "interfaces/interface.h"

class ConnectionFactory : public QObject
{
    Q_OBJECT
public:
    explicit ConnectionFactory();
    ~ConnectionFactory();

public slots:

    bool addConnection(interfacesAbstract::eInterfaceTypes type, QString name, QStringList param);
    QStringList getAvailableName(interfacesAbstract::eInterfaceTypes type);
    void removeConnection(interfacesAbstract::eInterfaceTypes type, QString name);
//    int getCountConnection();

    QString getInteraceNameFromIndex(int index);

    Interface* getInterace(interfacesAbstract::eInterfaceTypes type, QString name);

    void errorFromConnection(interfacesAbstract::eInterfaceTypes, QString name);

signals:
    void connectionIsLost(interfacesAbstract::eInterfaceTypes, QString);

private:

    QVector<Interface*>interface;

};

#endif // CONNECTIONFACTORY_H