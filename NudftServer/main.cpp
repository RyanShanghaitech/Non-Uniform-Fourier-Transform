#include <QtCore/QCoreApplication>
#include <QtNetwork/QTcpServer>
#include <NudftServer.h>

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    NudftServer objNudftServer;

    return a.exec();
}
