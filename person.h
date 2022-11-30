#ifndef PERSON_H
#define PERSON_H

#include <QObject>

class Person : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int pKey READ pKey WRITE setPKey NOTIFY pKeyChanged)
    Q_PROPERTY(QString names READ names WRITE setNames NOTIFY namesChanged)
    Q_PROPERTY(QString number READ number WRITE setNumber NOTIFY numberChanged)
public:
    explicit Person(QObject *parent = nullptr);

    Person(const int &pKey,const QString &names,const QString &number,QObject * parent=nullptr);

    int pKey() const;
    QString names() const;
    QString number() const;

    void setPKey(int pKey);
    void setNames(QString names);
    void setNumber(QString number);



signals:
    void pKeyChanged(int pKey);
    void namesChanged(QString names);
    void numberChanged(QString number);

private:
    int m_pKey;
    QString m_names;
    QString m_number;
};

#endif // PERSON_H
