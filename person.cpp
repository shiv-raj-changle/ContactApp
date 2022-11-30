#include "person.h"

Person::Person(QObject *parent) : QObject(parent)
{

}

Person::Person(const int &pKey, const QString &names, const QString &number, QObject *parent):QObject(parent),m_pKey(pKey),m_names(names),m_number(number)
{

}

int Person::pKey() const
{
    return m_pKey;
}

QString Person::names() const
{
    return m_names;
}

QString Person::number() const
{
    return m_number;
}

void Person::setPKey(int pKey)
{
    if (m_pKey == pKey)
        return;

    m_pKey = pKey;
    emit pKeyChanged(m_pKey);
}

void Person::setNames(QString names)
{
    if (m_names == names)
        return;

    m_names = names;
    emit namesChanged(m_names);
}

void Person::setNumber(QString number)
{
    if (m_number == number)
        return;

    m_number = number;
    emit numberChanged(m_number);
}
