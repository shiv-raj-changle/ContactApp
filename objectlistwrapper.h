#ifndef OBJECTLISTWRAPPER_H
#define OBJECTLISTWRAPPER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "person.h"

#include <QSqlQuery>
#include <QSqlDatabase>
#include <QCoreApplication>
#include <QSqlError>
#include <QSqlRecord>

class ObjectListWrapper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QObject*> mypersons READ mypersons WRITE setMypersons NOTIFY mypersonsChanged)
public:
    explicit ObjectListWrapper(QObject *parent = nullptr);

    bool initialize();

    //some method for changing data
    Q_INVOKABLE void setValues(const int &pKey,const QString &mName,const QString &mNumber);
//    Q_INVOKABLE void setNumber(const QString &oldNumber , const QString &newNumber);
    Q_INVOKABLE QList<QObject *> persons() const;

    //for adding new persons
    Q_INVOKABLE void addPerson(const QString &names,const QString &number);

    QList<QObject*> mypersons() const;

    void setMypersons(QList<QObject*> mypersons);

    //Queries
    Q_INVOKABLE void createDB();
    Q_INVOKABLE void createTable();
    Q_INVOKABLE void selectQuery();
    Q_INVOKABLE void deleteContact(const int &pKey);
    Q_INVOKABLE void searchQuery(const QString &text);

signals:
    void mypersonsChanged(QList<QObject*> mypersons);

private:
    void populateModelWithData();
    void resetModel();
    void printPersons();

    QList<QObject *>mPersons; //this should be QObject*,Person* is not going to work in QML

    QQmlApplicationEngine mEngine;

    QSqlQuery m_query;
    QSqlDatabase m_db;

//    QList<QObject*> m_mypersons;
};

#endif // OBJECTLISTWRAPPER_H
