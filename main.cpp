#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "person.h"
#include "objectlistwrapper.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    ObjectListWrapper wrapper;
    if(!wrapper.initialize())
        return -1;

    return app.exec();
}
