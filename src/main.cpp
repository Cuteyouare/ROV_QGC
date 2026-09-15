#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "RovStatusModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("ROV Ground Station");
    RovStatusModel rovStatus;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("rovStatus", &rovStatus);
    engine.loadFromModule("ROV.GroundStation", "Main");
    if (engine.rootObjects().isEmpty()) return -1;
    return app.exec();
}
