/****************************************************************************
** Meta object code from reading C++ file 'interfaceBLE.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../interfaces/interfaceBLE.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'interfaceBLE.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_InterfaceBLE_t {
    QByteArrayData data[15];
    char stringdata0[194];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_InterfaceBLE_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_InterfaceBLE_t qt_meta_stringdata_InterfaceBLE = {
    {
QT_MOC_LITERAL(0, 0, 12), // "InterfaceBLE"
QT_MOC_LITERAL(1, 13, 13), // "initInterface"
QT_MOC_LITERAL(2, 27, 0), // ""
QT_MOC_LITERAL(3, 28, 13), // "openInterface"
QT_MOC_LITERAL(4, 42, 6), // "isOpen"
QT_MOC_LITERAL(5, 49, 14), // "closeInterface"
QT_MOC_LITERAL(6, 64, 8), // "sendData"
QT_MOC_LITERAL(7, 73, 11), // "QByteArray&"
QT_MOC_LITERAL(8, 85, 5), // "pData"
QT_MOC_LITERAL(9, 91, 8), // "readData"
QT_MOC_LITERAL(10, 100, 16), // "getInterfaceName"
QT_MOC_LITERAL(11, 117, 20), // "getInterfaceProperty"
QT_MOC_LITERAL(12, 138, 30), // "QPair<QStringList,QStringList>"
QT_MOC_LITERAL(13, 169, 16), // "getAvailableList"
QT_MOC_LITERAL(14, 186, 7) // "getType"

    },
    "InterfaceBLE\0initInterface\0\0openInterface\0"
    "isOpen\0closeInterface\0sendData\0"
    "QByteArray&\0pData\0readData\0getInterfaceName\0"
    "getInterfaceProperty\0"
    "QPair<QStringList,QStringList>\0"
    "getAvailableList\0getType"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_InterfaceBLE[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   64,    2, 0x0a /* Public */,
       3,    0,   65,    2, 0x0a /* Public */,
       4,    0,   66,    2, 0x0a /* Public */,
       5,    0,   67,    2, 0x0a /* Public */,
       6,    1,   68,    2, 0x0a /* Public */,
       9,    1,   71,    2, 0x0a /* Public */,
      10,    0,   74,    2, 0x0a /* Public */,
      11,    0,   75,    2, 0x0a /* Public */,
      13,    0,   76,    2, 0x0a /* Public */,
      14,    0,   77,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Bool, 0x80000000 | 7,    8,
    QMetaType::Bool, 0x80000000 | 7,    8,
    QMetaType::QString,
    0x80000000 | 12,
    QMetaType::QStringList,
    QMetaType::QString,

       0        // eod
};

void InterfaceBLE::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        InterfaceBLE *_t = static_cast<InterfaceBLE *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->initInterface(); break;
        case 1: { bool _r = _t->openInterface();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 2: { bool _r = _t->isOpen();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: _t->closeInterface(); break;
        case 4: { bool _r = _t->sendData((*reinterpret_cast< QByteArray(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 5: { bool _r = _t->readData((*reinterpret_cast< QByteArray(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 6: { QString _r = _t->getInterfaceName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 7: { QPair<QStringList,QStringList> _r = _t->getInterfaceProperty();
            if (_a[0]) *reinterpret_cast< QPair<QStringList,QStringList>*>(_a[0]) = std::move(_r); }  break;
        case 8: { QStringList _r = _t->getAvailableList();
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = std::move(_r); }  break;
        case 9: { QString _r = _t->getType();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject InterfaceBLE::staticMetaObject = {
    { &interfacesAbstract::staticMetaObject, qt_meta_stringdata_InterfaceBLE.data,
      qt_meta_data_InterfaceBLE,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *InterfaceBLE::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *InterfaceBLE::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_InterfaceBLE.stringdata0))
        return static_cast<void*>(this);
    return interfacesAbstract::qt_metacast(_clname);
}

int InterfaceBLE::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = interfacesAbstract::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 10;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE