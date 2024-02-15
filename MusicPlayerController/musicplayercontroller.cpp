#include<MusicPlayerController/musicplayercontroller.h>
#include<QMediaDevices>
#include<QAudioDevice>
#include<QAudioOutput>
#include<QHash>
#include<Util/util.h>

MusicplayerController::MusicplayerController(QObject *parent):QAbstractListModel{parent},m_bplaying{false}{
    this->m_player=std::make_unique<QMediaPlayer>();
    const auto&audioOutputs{QMediaDevices::audioOutputs()};
    if(audioOutputs.empty())
    {
        qDebug()<<"No Audio outputs foudn!";
        return;
    }
    m_player->setAudioOutput(new QAudioOutput(m_player.get()));
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

void MusicplayerController::switchToAudioByIndex(int index)
{
    if(!(index>=0&&index<m_audioinfo_list.length()))return;
    setCurrentSong(m_audioinfo_list.at(index));
};

bool MusicplayerController::getbPlaying()const
{
    return m_bplaying;
};

void MusicplayerController::switchToNextSong()
{
    const auto index{m_audioinfo_list.indexOf(m_current_song)};
    if(index+1>=m_audioinfo_list.length())setCurrentSong(m_audioinfo_list.at(0));
    else setCurrentSong(m_audioinfo_list.at(index+1));
};
void MusicplayerController::switchToPreviousSong()
{


    const auto index{m_audioinfo_list.indexOf(m_current_song)};
    if(index-1<0)setCurrentSong(m_audioinfo_list.last());
    else setCurrentSong(m_audioinfo_list.at(index+-1));
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
    if(index.isValid()&&index.row()>=0&&index.row()<m_audioinfo_list.length())
    {
        AudioInfo*info=m_audioinfo_list.at(index.row());
        switch(i2e(role))
        {
        case Role::AudioAuthorNameRole:
            return info->authorName();
        case Role::AudioImageSourceRole:
            return info->imageSource();
        case Role::AudioSourceRole:
            return info->audioSource();
        case Role::AudioVideoSourceRole:
            return info->videoSource();
        case Role::AudioTitleRole:
            return info->title();
        }
    }
    return {};
}

QHash<int, QByteArray> MusicplayerController::roleNames() const
{
    QHash<int, QByteArray>result;
    result[e2i(Role::AudioAuthorNameRole)]="authorName";
    result[e2i(Role::AudioImageSourceRole)]="imageSource";
    result[e2i(Role::AudioSourceRole)]="audioSource";
    result[e2i(Role::AudioVideoSourceRole)]="videoSource";
    result[e2i(Role::AudioTitleRole)]="audioTitle";
    return result;
};

AudioInfo* MusicplayerController::getCurrentSong()const
{
    return m_current_song;
}

void MusicplayerController::setCurrentSong(AudioInfo*new_song)
{
    if(new_song==m_current_song)return;
    m_current_song=new_song;
    emit currentSongChanged();
    if(m_current_song)
    {
        changeAudioSource(m_current_song->audioSource());

    }else
    {
        m_player->stop();
        m_player->setSource(QUrl{});
        m_bplaying=false;
        emit bPlayingChanged();
    }
};

inline int MusicplayerController::e2i(const Role&role)const
{
    return static_cast<int>(role);
};

inline MusicplayerController::Role MusicplayerController::i2e(int n)const
{
    return static_cast<Role>(n);
};

void MusicplayerController::addAudio(const QString &title, const QString &author_name, const QUrl &audio_source, const QUrl &image_source, const QUrl &video_source)
{
    beginInsertRows(QModelIndex(),m_audioinfo_list.length(),m_audioinfo_list.length());
    AudioInfo*new_audio=new AudioInfo(this);
    if(!new_audio)return;
    new_audio->setTitle(title);
    new_audio->setAuthorName(author_name);
    new_audio->setAudioSource(audio_source);
    new_audio->setImageSource(image_source);
    new_audio->setVideoSource(video_source);
    if(m_audioinfo_list.isEmpty())
    {
        setCurrentSong(new_audio);
    };
    m_audioinfo_list.append(new_audio);
    endInsertRows();
};
void MusicplayerController::removeAudio(int index)
{
    if(!(index>=0&&index<m_audioinfo_list.length()))return;
    beginRemoveRows(QModelIndex(),index,index);
    AudioInfo*to_remove=m_audioinfo_list.at(index);
    if(to_remove==m_current_song)
    {
        if(m_audioinfo_list.length()>1)
        {
            if(index!=0)
            {
                setCurrentSong(m_audioinfo_list.at(index-1));
            }else
            {
                setCurrentSong(m_audioinfo_list.at(index+1));
            };
        }else
        {
            setCurrentSong(nullptr);
        }
    }
    m_audioinfo_list.removeAt(index);
    to_remove->deleteLater();
    endRemoveRows();
};

