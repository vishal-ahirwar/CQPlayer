#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include"./MusicPlayerController/musicplayercontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    MusicplayerController*player_controller=new MusicplayerController(&app);
    qmlRegisterSingletonInstance("com.vishal.MusicPlayerController",1,0,"PlayerController",player_controller);
    QQmlApplicationEngine engine;
    engine.load(QUrl(u"qrc:/qml/Main.qml"_qs));
    return app.exec();
}
