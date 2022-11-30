#include "objectlistwrapper.h"
#include <QDebug>

ObjectListWrapper::ObjectListWrapper(QObject *parent) : QObject(parent)
{
    qDebug()<<"creating database and connecting in constructor";
    createDB();
    qDebug()<<"creating table in constructoor";
    createTable();
    qDebug()<<"populate method in cnstrudtor";
    populateModelWithData();
}

bool ObjectListWrapper::initialize()
{
    resetModel();
    mEngine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if(mEngine.rootObjects().isEmpty())
        return false;
    return true;
}

void ObjectListWrapper::setValues(const int &pKey, const QString &name,const QString &number)
{
    QSqlQuery query;

    qDebug()<<"old name : "<<pKey<<" new name : "<<name;

    query.prepare("update 'people' set names=:mName,number=:mNumber where pKey=:pKey");
    query.bindValue(":mName",name);
    query.bindValue(":mNumber",number);
    query.bindValue(":pKey",pKey);
    if(query.exec()){
        qDebug()<<"Query executed";
    }
    else{
        qDebug()<<"Error : "<<query.lastError();
    }

    populateModelWithData();
    emit mypersonsChanged(mPersons);




}

//void ObjectListWrapper::setNumber(const QString &oldNumber, const QString &newNumber)
//{
//    QSqlQuery query;
//    qDebug()<<"old number : "<<oldNumber<<" new number : "<<newNumber;
//    query.prepare("update 'people' set number=:newNumber where number=:oldNumber");
//    query.bindValue(":newNumber",newNumber);
//    query.bindValue(":oldNumber",oldNumber);
//    if(query.exec()){
//        qDebug()<<"Query executed";
//    }
//    else{
//        qDebug()<<"Error : "<<query.lastError();
//    }
//    populateModelWithData();
//    emit mypersonsChanged(mPersons);
//}

QList<QObject *> ObjectListWrapper::persons() const
{
    return mPersons;
}

void ObjectListWrapper::addPerson(const QString &names,const QString &number)
{
    QSqlQuery query;
    query.prepare("INSERT INTO people (names,number) VALUES (:names,:number)");
    query.bindValue(":names",names);
    query.bindValue(":number",number);
    if(query.exec()){
        qDebug()<<"query executed";
        qDebug()<<"Contact inserted ...----------------------------";
    }
    else{
        qDebug()<<"add person error :"<<query.lastError();
    }
    populateModelWithData();
    emit mypersonsChanged(mPersons);
}

void ObjectListWrapper::populateModelWithData()
{
    selectQuery();

}

void ObjectListWrapper::resetModel()
{
    mEngine.rootContext()->setContextProperty("Wrapper",this);
    //    mEngine.rootContext()->setContextProperty("myModel",QVariant::fromValue(persons()));
}

void ObjectListWrapper::printPersons()
{
    qDebug()<<"||-------------- Persons -----------------||";
    foreach (QObject * obj, mPersons) {
        Person * person = static_cast<Person*>(obj);
        qDebug()<<"Offline print : "<<person->names()<<" "<<person->number();
    }
}

QList<QObject *> ObjectListWrapper::mypersons() const
{
    return mPersons;
}

void ObjectListWrapper::setMypersons(QList<QObject *> mypersons)
{
    if (mPersons == mypersons)
        return;

    mPersons = mypersons;
    emit mypersonsChanged(mPersons);
}

void ObjectListWrapper::createDB()
{
    m_db=QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName(QCoreApplication::applicationDirPath()+"/"+"contact.db");

    if(!m_db.open()){
        qDebug()<<"Error : connection Error";
    }
    else{
        qDebug()<<"Connection Success";
        qDebug()<<QCoreApplication::applicationDirPath();
    }
}

void ObjectListWrapper::createTable()
{
    QSqlQuery query;

    //    CREATE TABLE if not exists 'people' ('pKey'	INTEGER,'name' TEXT,'number' TEXT,PRIMARY KEY('pKey' AUTOINCREMENT))

    if(!query.exec("CREATE TABLE if not exists 'people' ('pKey'	INTEGER,'names' TEXT,'number' TEXT,PRIMARY KEY('pKey' AUTOINCREMENT))"))
        qDebug()<<"SQLError : "<<query.lastError();
    else
        qDebug()<<"Table created.";

}

void ObjectListWrapper::selectQuery()
{
    mPersons.clear();
    qDebug()<<"selct query called =--------------------- ";
    QSqlQuery query;
    query.exec("SELECT pKey,names,number FROM people order by names ASC ");
    //    int idName=query.record().indexOf("names");
    //    int idNumber=query.record().indexOf("number");
    //    qDebug()<<"selecct qer : "<<idName<<idNumber;
    while(query.next()){
        int pKey = query.value(0).toInt();
        QString names = query.value(1).toString();
        QString number = query.value(2).toString();
        qDebug()<<pKey<<" "<<names<<" "<<number;
        mPersons.append(new Person(pKey,names,number));
    }

}

void ObjectListWrapper::deleteContact(const int &pKey)
{
    QSqlQuery query;

    qDebug()<<"deleting "<<pKey;

    query.prepare("delete from people where pKey=:pKey");
    query.bindValue(":pKey",pKey);
    if(query.exec()){
        qDebug()<<"Query executed";
    }
    else{
        qDebug()<<"Error : "<<query.lastError();
    }

    populateModelWithData();
    emit mypersonsChanged(mPersons);

}

void ObjectListWrapper::searchQuery(const QString &text)
{

    mPersons.clear();
    qDebug()<<"select query called =--------------------- ";
    QSqlQuery query;
    query.exec("SELECT pKey,names,number FROM people WHERE names LIKE '%"+text+"%' order by names ASC ");
//    query.bindValue(":text",text);

    if(query.exec()){
        while(query.next()){
            int pKey = query.value(0).toInt();
            QString names = query.value(1).toString();
            QString number = query.value(2).toString();
            qDebug()<<pKey<<" "<<names<<" "<<number;
            mPersons.append(new Person(pKey,names,number));
        }
    }
    else{
        qDebug()<<"Error : "<<query.lastError();
    }
    emit mypersonsChanged(mPersons);

}
