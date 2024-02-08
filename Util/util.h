#ifndef UTIL_H
#define UTIL_H

#include <QObject>

class Util:public QObject
{
    Q_OBJECT
public:
    Util(QObject*parent=nullptr);

    void save();
    void load(QString&out);
};

#endif // UTIL_H
