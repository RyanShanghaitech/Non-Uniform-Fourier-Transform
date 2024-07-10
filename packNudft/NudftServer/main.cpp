#include <QtCore/QCoreApplication>
#include <QtNetwork/QTcpServer>
#include <NudftServer.h>

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    try{
        NudftServer objNudftServer(&a);
        return a.exec();
    } catch (...) {
        return 1;
    }
}
