/****************************************************************************
** Meta object code from reading C++ file 'ProjectModel.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/ProjectModel.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ProjectModel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ProjectModel[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      13,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: signature, parameters, type, tag, flags
      28,   18,   14,   13, 0x02,
      58,   18,   53,   13, 0x02,
      92,   18,   84,   13, 0x02,
     124,   18,  115,   13, 0x02,
     154,  143,   13,   13, 0x02,
     180,  143,   13,   13, 0x02,
     207,  143,   13,   13, 0x02,
     291,  236,   13,   13, 0x02,
     392,  331,   13,   13, 0x02,
     527,  462,   13,   13, 0x02,
     634,  581,   13,   13, 0x02,
     699,  692,   13,   13, 0x02,
     718,   18,   53,   13, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_ProjectModel[] = {
    "ProjectModel\0\0int\0indexPath\0"
    "childCount(QVariantList)\0bool\0"
    "hasChildren(QVariantList)\0QString\0"
    "itemType(QVariantList)\0QVariant\0"
    "data(QVariantList)\0indexPaths\0"
    "removeItems(QVariantList)\0"
    "archiveItems(QVariantList)\0"
    "unArchiveItems(QVariantList)\0"
    "projectName,projectStart,projectEnd,projectDescription\0"
    "addProject(QString,QDate,QDate,QString)\0"
    "indexPath,stepName,stepStart,stepDue,members,stepDescription\0"
    "addProjectStep(QVariantList,QString,QDate,QDate,QVariantList,QString)\0"
    "indexPath,projectName,projectStart,projectEnd,projectDescription\0"
    "editProject(QVariantList,QString,QDate,QDate,QString)\0"
    "indexPath,stepName,stepStart,stepEnd,stepDescription\0"
    "editProjectStep(QVariantList,QString,QDate,QDate,QString)\0"
    "filter\0setFilter(QString)\0"
    "isFiltered(QVariantList)\0"
};

void ProjectModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ProjectModel *_t = static_cast<ProjectModel *>(_o);
        switch (_id) {
        case 0: { int _r = _t->childCount((*reinterpret_cast< const QVariantList(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 1: { bool _r = _t->hasChildren((*reinterpret_cast< const QVariantList(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 2: { QString _r = _t->itemType((*reinterpret_cast< const QVariantList(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 3: { QVariant _r = _t->data((*reinterpret_cast< const QVariantList(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 4: _t->removeItems((*reinterpret_cast< const QVariantList(*)>(_a[1]))); break;
        case 5: _t->archiveItems((*reinterpret_cast< const QVariantList(*)>(_a[1]))); break;
        case 6: _t->unArchiveItems((*reinterpret_cast< const QVariantList(*)>(_a[1]))); break;
        case 7: _t->addProject((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QDate(*)>(_a[2])),(*reinterpret_cast< QDate(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4]))); break;
        case 8: _t->addProjectStep((*reinterpret_cast< const QVariantList(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QDate(*)>(_a[3])),(*reinterpret_cast< QDate(*)>(_a[4])),(*reinterpret_cast< QVariantList(*)>(_a[5])),(*reinterpret_cast< QString(*)>(_a[6]))); break;
        case 9: _t->editProject((*reinterpret_cast< const QVariantList(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QDate(*)>(_a[3])),(*reinterpret_cast< QDate(*)>(_a[4])),(*reinterpret_cast< QString(*)>(_a[5]))); break;
        case 10: _t->editProjectStep((*reinterpret_cast< const QVariantList(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QDate(*)>(_a[3])),(*reinterpret_cast< QDate(*)>(_a[4])),(*reinterpret_cast< QString(*)>(_a[5]))); break;
        case 11: _t->setFilter((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 12: { bool _r = _t->isFiltered((*reinterpret_cast< const QVariantList(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ProjectModel::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ProjectModel::staticMetaObject = {
    { &bb::cascades::DataModel::staticMetaObject, qt_meta_stringdata_ProjectModel,
      qt_meta_data_ProjectModel, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ProjectModel::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ProjectModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ProjectModel::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ProjectModel))
        return static_cast<void*>(const_cast< ProjectModel*>(this));
    typedef bb::cascades::DataModel QMocSuperClass;
    return QMocSuperClass::qt_metacast(_clname);
}

int ProjectModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    typedef bb::cascades::DataModel QMocSuperClass;
    _id = QMocSuperClass::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 13)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
