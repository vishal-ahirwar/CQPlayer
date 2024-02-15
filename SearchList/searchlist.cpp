#include<SearchList/searchlist.h>
#include<AudioInfo/audioinfo.h>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include<QNetworkReply>
#include <QUrlQuery>
namespace
{
    const QString &REQUEST_URL="https://api.jamendo.com/v3.0/tracks/";
    const QString &CLIENT_ID="2afbbb15";
    const QString &CLIENT_SECRET="636c58520534ea21624ef82734ad27f1";
};

SearchList::SearchList(QObject*parent):QAbstractListModel{parent},m_network_manager{nullptr},m_reply{nullptr}
{
    m_network_manager=std::make_unique<QNetworkAccessManager>();
}

int SearchList::e2i(const Role &role) const
{
    return static_cast<int>(role);
}

SearchList::Role SearchList::i2e(int index) const
{
    return static_cast<Role>(index);
}

void SearchList::searchSong(const QString &song_name)
{
    if(song_name.trimmed().isEmpty())return;

    if(m_reply)
    {
        m_reply->abort();
        m_reply->deleteLater();
        m_reply=nullptr;
    };
    QUrlQuery query;
    query.addQueryItem("client_id",CLIENT_ID);
    query.addQueryItem("namesearch",song_name);
    query.addQueryItem("format","json");

    setIsSearching(true);

    m_reply=m_network_manager->get(QNetworkRequest(REQUEST_URL+"?"+query.toString()));
    connect(m_reply,&QNetworkReply::finished,this,&SearchList::parseData);
}

void SearchList::parseData()
{
    if(m_reply->error()==QNetworkReply::NoError)
    {
        beginResetModel();
        qDeleteAll(m_audio_list);
        m_audio_list.clear();
        QByteArray data=m_reply->readAll();
        QJsonDocument json_document=QJsonDocument::fromJson(data);
        QJsonObject headers=json_document["headers"].toObject();
        if(headers["status"].toString()=="success")
        {
            QJsonArray results=json_document["results"].toArray();
            for(const auto&result:results)
            {
                QJsonObject entry=result.toObject();
                if(entry["audiodownload_allowed"].toBool())
                {
                    AudioInfo*audio_info=new AudioInfo(this);
                    audio_info->setTitle(entry["name"].toString());
                    audio_info->setAuthorName(entry["artist_name"].toString());
                    audio_info->setAudioSource(entry["audiodownload"].toString());
                    audio_info->setImageSource(entry["image"].toString());
                    m_audio_list.append(audio_info);
                }
            }
        }else
        {
            qWarning()<<headers["error_string"];
        }
        endResetModel();
    }else if(m_reply->error()!=QNetworkReply::OperationCanceledError)
    {
        qCritical()<<"reply failed error : "<<m_reply->errorString();
    };
    setIsSearching(false);
    m_reply->deleteLater();
    m_reply=nullptr;
}

int SearchList::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_audio_list.length();
}

QVariant SearchList::data(const QModelIndex &index, int role) const
{
    if(index.isValid()&&index.row()>=0&&index.row()<m_audio_list.length())
    {
        AudioInfo*info=m_audio_list.at(index.row());
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

QHash<int, QByteArray> SearchList::roleNames() const
{
    QHash<int, QByteArray>result;
    result[e2i(Role::AudioAuthorNameRole)]="authorName";
    result[e2i(Role::AudioImageSourceRole)]="imageSource";
    result[e2i(Role::AudioSourceRole)]="audioSource";
    result[e2i(Role::AudioVideoSourceRole)]="videoSource";
    result[e2i(Role::AudioTitleRole)]="audioTitle";
    return result;
}

bool SearchList::isSearching() const
{
    return m_is_searching;
}

void SearchList::setIsSearching(bool is_searching)
{
    m_is_searching=is_searching;
    emit isSearchingChanged();
}
