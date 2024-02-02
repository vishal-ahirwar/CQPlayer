#ifndef MUSICPLAYERCONTROLLER_H
#define MUSICPLAYERCONTROLLER_H

#include <QObject>
#include<QMediaPlayer>
class MusicplayerController : public QObject
{
    Q_OBJECT
    
    Q_PROPERTY(int current_song_index READ getCurrentSongIndex  NOTIFY currentSongIndexChanged FINAL REQUIRED)
    Q_PROPERTY(int song_count READ getSongCount NOTIFY songCountChanged FINAL)
    Q_PROPERTY(bool b_playing READ getbPlaying NOTIFY bPlayingChanged FINAL)
public:
    explicit MusicplayerController(QObject *parent = nullptr);
    int getCurrentSongIndex() const;
    int getSongCount()const;
    bool getbPlaying()const;

public:
    Q_INVOKABLE void switchToNextSong();
    Q_INVOKABLE void switchToPreviousSong();
    Q_INVOKABLE void togglePlayPause();
    Q_INVOKABLE void changeAudioSource(QUrl url);
signals:
    void currentSongIndexChanged();
    void songCountChanged();
    void bPlayingChanged();

private:
    int current_song_index{};
    int song_count{};
    bool b_playing{};
    std::unique_ptr<class QMediaPlayer>player{};
};

#endif // MUSICPLAYERCONTROLLER_H
