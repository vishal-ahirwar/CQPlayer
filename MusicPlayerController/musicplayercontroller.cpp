#include "musicplayercontroller.h"
#include<QMediaDevices>
#include<QAudioDevice>
#include<QAudioOutput>

MusicplayerController::MusicplayerController(QObject *parent):QObject{parent},song_count{3},current_song_index{0},b_playing{false}{
    this->player=std::make_unique<QMediaPlayer>();
    const auto&audioOutputs{QMediaDevices::audioOutputs()};
    if(audioOutputs.empty())return;
    player->setAudioOutput(new QAudioOutput(player.get()));
}

void MusicplayerController::changeAudioSource(QUrl url)
{
    if(!player)return;
    player->stop();
    player->setSource(url);
    if(b_playing)
    {
        player->play();
    };
};
int MusicplayerController::getCurrentSongIndex() const
{
    return current_song_index;
};

bool MusicplayerController::getbPlaying()const
{
    return b_playing;
};

int MusicplayerController::getSongCount()const
{
    return song_count;
};

void MusicplayerController::switchToNextSong()
{
    if(current_song_index+1>=song_count)current_song_index=0;
    else ++current_song_index;
    emit currentSongIndexChanged();};

void MusicplayerController::switchToPreviousSong()
{
    if(current_song_index-1<0)current_song_index=song_count-1;
    else --current_song_index;
    emit currentSongIndexChanged();};

void MusicplayerController::togglePlayPause()
{
    b_playing=!b_playing;
    b_playing?player->play():player->stop();
    emit bPlayingChanged();
};
