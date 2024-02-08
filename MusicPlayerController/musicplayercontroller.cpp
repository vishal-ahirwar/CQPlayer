#include<MusicPlayerController/musicplayercontroller.h>
#include<QMediaDevices>
#include<QAudioDevice>
#include<QAudioOutput>
#include<QHash>
#include<Util/util.h>
MusicplayerController::MusicplayerController(QObject *parent):m_bplaying{false}{
    this->m_player=std::make_unique<QMediaPlayer>();
    this->m_util=std::make_unique<Util>();
    const auto&audioOutputs{QMediaDevices::audioOutputs()};
    if(audioOutputs.empty())
    {
        qDebug()<<"No Audio outputs foudn!";
        return;
    }
    m_player->setAudioOutput(new QAudioOutput(m_player.get()));
    QString test_string{};
    m_util->load(test_string);
    qDebug()<<test_string;
}

void MusicplayerController::changeAudioSource(QUrl url)
{
    if(!m_player)return;
    m_player->stop();
    m_player->setSource(url);
    if(m_bplaying)
    {
        m_player->play();
        qDebug()<<url;
    };
}
bool MusicplayerController::getbPlaying()const
{
    return m_bplaying;
};

void MusicplayerController::switchToNextSong()
{
    // if(current_song_index+1>=song_count)current_song_index=0;
    // else ++current_song_index;
};
void MusicplayerController::switchToPreviousSong()
{
    // if(current_song_index-1<0)current_song_index=song_count-1;
    // else --current_song_index;
};

void MusicplayerController::togglePlayPause()
{
    m_bplaying=!m_bplaying;
    m_bplaying?m_player->play():m_player->stop();
    emit bPlayingChanged();
};


int MusicplayerController::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_audioinfo_list.length();
};

QVariant MusicplayerController::data(const QModelIndex &index, int role) const
{
    return {};
}

QHash<int, QByteArray> MusicplayerController::roleNames() const
{
    QHash<int, QByteArray>result;
    result[(int)Role::AudioAuthorNameRole]="authorName";
    result[(int)Role::AudioImageSourceRole]="ImageSource";
    result[(int)Role::AudioSourceRole]="audioSource";
    result[(int)Role::AudioVideoSourceRole]="videoSource";
    result[(int)Role::AudioTitleRole]="audioTitle";
    return result;
};

AudioInfo* MusicplayerController::getCurrentSong()const
{
    return m_current_song;
}

void MusicplayerController::setCurrentSong(AudioInfo*newSong)
{

};
