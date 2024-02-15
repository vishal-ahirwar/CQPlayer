#ifndef SEARCHLIST_H
#define SEARCHLIST_H
#include<QObject>
#include<QAbstractListModel>
#include<QNetworkAccessManager>

class AudioInfo;

class SearchList:public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(bool is_searching READ isSearching NOTIFY isSearchingChanged FINAL)
public:
    SearchList(QObject*parent=nullptr);
    bool isSearching() const;
    void setIsSearching(bool);
private:
    enum class Role
    {
        AudioTitleRole=Qt::UserRole+1,
        AudioAuthorNameRole,
        AudioSourceRole,
        AudioImageSourceRole,
        AudioVideoSourceRole
    };

    inline int e2i(const Role&role)const;
    inline Role i2e(int)const;

private:

    QList<AudioInfo*>m_audio_list;
    std::unique_ptr<QNetworkAccessManager>m_network_manager;
    QNetworkReply*m_reply;
    bool m_is_searching;

public slots:
    void searchSong(const QString&song_name);
    void parseData();
public:

    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

signals:
    void isSearchingChanged();
};

#endif // SEARCHLIST_H
