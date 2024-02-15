#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QQmlEngine>
#include<QQmlContext>
#include<MusicPlayerController/musicplayercontroller.h>
#include<AudioInfo/audioinfo.h>
#include<SearchList/searchlist.h>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    MusicplayerController*player_controller=new MusicplayerController(&app);
    SearchList*search_list=new SearchList(&app);

    qmlRegisterSingletonInstance("com.vishal.MusicPlayerController",1,0,"PlayerController",player_controller);
    qmlRegisterSingletonInstance<SearchList>("com.vishal.SearchList",1,0,"SearchList",search_list);
    qmlRegisterType<AudioInfo>("com.vishal.AudioInfo",1,0,"AudioInfo");

    QQmlApplicationEngine engine;
    engine.load(QUrl(u"qrc:/qml/Main.qml"_qs));
    return app.exec();
}
