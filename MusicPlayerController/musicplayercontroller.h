#ifndef MUSICPLAYERCONTROLLER_H
#define MUSICPLAYERCONTROLLER_H

#include <QObject>
#include<QMediaPlayer>
#include<QAbstractListModel>
#include<AudioInfo/audioinfo.h>

class MusicplayerController : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(bool b_playing READ getbPlaying NOTIFY bPlayingChanged FINAL)
    Q_PROPERTY(AudioInfo* current_song READ getCurrentSong WRITE setCurrentSong NOTIFY currentSongChanged)

public:
    explicit MusicplayerController(QObject *parent = nullptr);
    bool getbPlaying()const;
    AudioInfo*getCurrentSong()const;
    void setCurrentSong(AudioInfo*newSong);
    enum class Role
    {
        AudioTitleRole=Qt::UserRole+1,
        AudioAuthorNameRole,
        AudioSourceRole,
        AudioImageSourceRole,
        AudioVideoSourceRole
    };
public:
    Q_INVOKABLE void switchToNextSong();
    Q_INVOKABLE void switchToPreviousSong();
    Q_INVOKABLE void togglePlayPause();
    Q_INVOKABLE void changeAudioSource(QUrl url);
signals:
    void bPlayingChanged();
    void currentSongChanged();
private:
    bool m_bplaying{};
    AudioInfo*m_current_song{};
    std::unique_ptr<class QMediaPlayer>m_player{};
    std::unique_ptr<class Util>m_util{};
    QList<AudioInfo*>m_audioinfo_list{};
public:
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;
};

#endif // MUSICPLAYERCONTROLLER_H
