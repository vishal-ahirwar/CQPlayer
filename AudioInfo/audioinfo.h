#ifndef AUDIOINFO_H
#define AUDIOINFO_H

#include <QObject>

class AudioInfo : public QObject
{
    Q_OBJECT
public:
    explicit AudioInfo(QObject *parent = nullptr);

signals:
};

#endif // AUDIOINFO_H
