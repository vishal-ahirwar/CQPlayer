#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<MusicPlayerController/musicplayercontroller.h>
#include<AudioInfo/audioinfo.h>
#include<QQmlEngine>
#include<QQmlContext>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    MusicplayerController*player_controller=new MusicplayerController(&app);
    qmlRegisterSingletonInstance("com.vishal.MusicPlayerController",1,0,"PlayerController",player_controller);
    qmlRegisterType<AudioInfo>("com.vishal.AudioInfo",1,0,"AudioInfo");
    QQmlApplicationEngine engine;
    engine.load(QUrl(u"qrc:/qml/Main.qml"_qs));
    return app.exec();
}
