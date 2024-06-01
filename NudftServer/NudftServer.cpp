#include "NudftServer.h"

NudftServer::NudftServer(QObject *parent): QTcpServer(parent), listRxPkt(new std::list<uint8_t>), listTxPkt(new std::list<uint8_t>)
{
    typeConfig config;
    while(true){
        funGetAddrPort(&config);
        strcpy(addrServer, config.addr);
        portServer = config.port;
        numThread = config.nThd;

        if(this->listen(QHostAddress(addrServer), portServer)){
            connect(this, &QTcpServer::newConnection, this, &NudftServer::slotNewConnection);
            printf("[INFO] listening\n");
            return;
        }else{
            printf("[ERRO] listening failed\n");
            remove(FILE_CFG);
        }
    }
}

NudftServer::~NudftServer()
{
}

int NudftServer::funGetAddrPortCmd(NudftServer::typeConfig* config)
{
    // read config from user
    printf("[ENTR] ADDR: ");
    assert(scanf("%15s", (char*)&config->addr));
    printf("[ENTR] PORT: ");
    assert(scanf("%d", &config->port));
    printf("[ENTR] NTHD: ");
    assert(scanf("%d", &config->nThd));

    return 0;
}

int NudftServer::funGetAddrPortFile(NudftServer::typeConfig* config)
{
    FILE* fileConfig = fopen(FILE_CFG, "r");

    // validate file
    if(fileConfig == nullptr){
        return 1;
    }else{
        fseek(fileConfig, 0, SEEK_END);
        if(ftell(fileConfig)  < 21){ // 21 is the minimum possible size of config.ini
            fclose(fileConfig);
            return 1;
        }else{
            fseek(fileConfig, 0, SEEK_SET);
        }
    }

    // read config from file
    fscanf(fileConfig, "[ADDR] %15s\n", (char*)&config->addr);
    fscanf(fileConfig, "[PORT] %d\n", &config->port);
    fscanf(fileConfig, "[NTHD] %d\n", &config->nThd);
    fclose(fileConfig);
    
    // print config
    printf("[INFO] ADDR: %s\n", (char*)config->addr);
    printf("[INFO] PORT: %d\n", config->port);
    printf("[INFO] NTHD: %d\n", config->nThd);

    return 0;
}

int NudftServer::funSaveAddrPort(NudftServer::typeConfig* config)
{
    // store config to file
    FILE* fileConfig = fopen(FILE_CFG, "w");
    if(fileConfig == nullptr){
        printf("[ERRO] file open error\n");
        return 1;
    }else{
        fprintf(fileConfig, "[ADDR] %s\n", (char*)config->addr);
        fprintf(fileConfig, "[PORT] %d\n", config->port);
        fprintf(fileConfig, "[NTHD] %d\n", config->nThd);
        fclose(fileConfig);
        return 0;
    }
}

int NudftServer::funGetAddrPort(NudftServer::typeConfig* config)
{
    int rtFun = 0;
    if(funGetAddrPortFile(config)){
        funGetAddrPortCmd(config);
        funSaveAddrPort(config);
    }
    return 0;
}

void NudftServer::slotNewConnection()
{
    printf("[INFO] new connection\n");
    if(socket != nullptr && socket->isOpen()) socket->close();
    socket = this->nextPendingConnection();
    while(!socket->open(QIODevice::ReadWrite));
    connect(socket, &QTcpSocket::readyRead, this, &NudftServer::slotDataReceived);
    connect(socket, &QTcpSocket::disconnected, this, &NudftServer::slotSocketDisconnected);
}

void NudftServer::slotSocketDisconnected()
{
    printf("[INFO] disconnected\n");
    socket->close();
    listRxPkt->clear();
    listTxPkt->clear();
}

void NudftServer::slotDataReceived()
{
    printf("[INFO] data received\n");
    static int64_t flagHeader = 0;
    static int64_t flagEscape = 0;

    QByteArray qByteArraySocketRxData = socket->readAll();
    QByteArray qByteArraySocketTxData;
    int64_t lenPkt = qByteArraySocketRxData.length();
    uint8_t byte = 0x00;
    for(int64_t idxPkt = 0; idxPkt < lenPkt; ++idxPkt)
    {
        byte = qByteArraySocketRxData.data()[idxPkt];
        switch(byte)
        {
        case 0xFA:
            flagHeader = 1;
            listRxPkt->clear();
            listTxPkt->clear();
            break;
        case 0xFB:
            flagEscape = 1;
            break;
        case 0xFC:
            flagHeader = 0;
            if(!funParsePkt(listRxPkt.get(), listTxPkt.get())){
                funPackData(listTxPkt.get(), &qByteArraySocketTxData);
                socket->write(qByteArraySocketTxData);
                socket->flush();
            }else{
                printf("[ERRO] error parsing packet\n");
            }
            break;
        default:
            if(listRxPkt->size() < MEMORY_LIMIT){
                listRxPkt->push_back(flagEscape?byte-0x03:byte);
            }else{
                printf("[ERRO] memory limit exceeded\n");
            }
            flagEscape = 0;
            break;
        }
    }
}

int NudftServer::funParsePkt(const std::list<uint8_t> *listRxPkt, std::list<uint8_t> *listTxPkt)
{
    int64_t lenPkt = listRxPkt->size();
    std::unique_ptr<uint8_t[]> arrPkt(new uint8_t[lenPkt]);
    uint8_t typeTransform;
    int64_t numInputCoor;
    int64_t numOutputCoor;
    double *arrInputCoor;
    double *arrInputData;
    double *arrOutputCoor;
    uint8_t sumBytes;
    
    int64_t idxPkt = 0;
    int64_t lenDesired = 0;

    // convert std::list to C array
    idxPkt = 0;
    std::list<uint8_t>::const_iterator itPkt = listRxPkt->begin();
    do{
        arrPkt[idxPkt++] = *(itPkt++);
    }while(itPkt != listRxPkt->end());

    // parse parameters
    lenDesired = 2*sizeof(uint8_t) + 2*sizeof(uint64_t);
    if((size_t)lenPkt < lenDesired){
        printf("[ERRO] header size error\n");
        return 1;
    } // array size check

    int64_t ptrBias = 0;
    typeTransform = *(uint8_t*)&arrPkt[ptrBias];

    int64_t numDim;
    bool flagIDFT;
    switch(typeTransform)
    {
        case 0x00: numDim = 1; flagIDFT = false; break;
        case 0x01: numDim = 1; flagIDFT = true; break;
        case 0x02: numDim = 2; flagIDFT = false; break;
        case 0x03: numDim = 2; flagIDFT = true; break;
        case 0x04: numDim = 3; flagIDFT = false; break;
        case 0x05: numDim = 3; flagIDFT = true; break;
        default: printf("[ERRO] type error\n"); return 1;
    }

    ptrBias += sizeof(uint8_t);
    numInputCoor = *(uint64_t*)&arrPkt[ptrBias];

    ptrBias += sizeof(uint64_t);
    numOutputCoor = *(uint64_t*)&arrPkt[ptrBias];

    lenDesired = 
        2*sizeof(uint8_t) + // typeTransform, sumBytes
        2*sizeof(uint64_t) + // numInputCoor, numOutputCoor
        (numInputCoor)*(numDim)*(sizeof(double)) + // listInputCoor
        (numInputCoor)*(2*sizeof(double)) + // listInputData
        (numOutputCoor)*(numDim)*(sizeof(double)); // listOutputCoor
    
    if((size_t)lenPkt != lenDesired){ // listInputData
        printf("[ERRO] data size error\n");
        return 1;
    } // array size check

    ptrBias += sizeof(uint64_t);
    arrInputCoor = (double*)&arrPkt[ptrBias];

    ptrBias += numInputCoor*numDim*sizeof(double);
    arrInputData = (double*)&arrPkt[ptrBias];

    ptrBias += numInputCoor*2*sizeof(double);
    arrOutputCoor = (double*)&arrPkt[ptrBias];

    ptrBias += numOutputCoor*numDim*sizeof(double);
    sumBytes = *(uint8_t*)&arrPkt[ptrBias];

    uint8_t derivedSum = 0;
    idxPkt = 0;
    do{
        derivedSum += arrPkt[idxPkt++];
    }while(idxPkt != lenPkt - 1);
    if(derivedSum != sumBytes){
        printf("[ERRO] sum error\n");
        return 1;
    }
    
    // run calculation
    std::unique_ptr<double[]> arrOutputData(new double[numOutputCoor*2]);
    int64_t ptsPerThread = numOutputCoor/numThread;
    if(numOutputCoor > ptsPerThread*numThread) ptsPerThread += 1;
    std::thread arrThread[numThread];
    for(int64_t idxThread = 0; idxThread < numThread; ++idxThread){
        arrThread[idxThread] = std::thread(
                    NudftServer::funNUDFT,
                    flagIDFT,
                    numDim,
                    numInputCoor,
                    arrInputCoor,
                    arrInputData,
                    (idxThread != numThread - 1)?(ptsPerThread):(numOutputCoor - ptsPerThread*(numThread - 1)),
                    arrOutputCoor + numDim*idxThread*ptsPerThread,
                    arrOutputData.get() + 2*idxThread*ptsPerThread,
                    idxThread
                    );
    }
    for(int64_t idxThread = 0; idxThread < numThread; ++idxThread){
        arrThread[idxThread].join();
    }

    // generate Tx packet
    std::list<uint8_t> listTemp;
    uint8_t* arru8Outputdata = (uint8_t*)arrOutputData.get();
    uint8_t sumOutput = 0x00;
    for(int64_t idxOutputData = 0; idxOutputData < numOutputCoor*2*sizeof(double); ++idxOutputData){ // 2*numOutputCoor: real and imag
        sumOutput += arru8Outputdata[idxOutputData];
        listTemp = {(uint8_t*)&arrOutputData[idxOutputData], (uint8_t*)&arrOutputData[idxOutputData+1]};
        listTxPkt->push_back(arru8Outputdata[idxOutputData]);
    }
    listTxPkt->push_back(sumOutput);

    return 0;
}

int NudftServer::funPackData(const std::list<uint8_t>* listTxPkt, QByteArray* qByteArraySocketTxData)
{
    qByteArraySocketTxData->append(0xFA);
    for(std::list<uint8_t>::const_iterator itTxPkt = listTxPkt->begin();
        itTxPkt != listTxPkt->end();
        ++itTxPkt){
        if(*itTxPkt >= 0xFA && *itTxPkt <= 0xFC){
            qByteArraySocketTxData->append(0xFB);
            qByteArraySocketTxData->append(*itTxPkt + 0x03);
        }else{
            qByteArraySocketTxData->append(*itTxPkt);
        }
    }
    qByteArraySocketTxData->append(0xFC);
    return 0;
}

int NudftServer::funNUDFT(
    const bool flagIDFT,
    const int64_t numDim,
    const int64_t lenDm0,
    const double* const arrCoorDm0,
    const double* const arrValDm0,
    const int64_t lenDm1,
    const double* const arrCoorDm1,
    double* const arrValDm1,
    const int64_t idxThread)
{
    static const double pi = std::abs(std::acos((double)-1));
    const double prodSign2Pi = (flagIDFT)?(2*pi):(-2*pi);
    std::complex<double> tempDm0(0, 0);
    std::complex<double> tempDm1(0, 0);

    double* ptrValDm1 = arrValDm1;
    for(int64_t idxDm1 = 0; idxDm1 != lenDm1; ++idxDm1){
        tempDm1 = {0, 0};
        
        const double* ptrCoorDm0 = arrCoorDm0;
        const double* ptrValDm0 = arrValDm0;
        for(int64_t idxDm0 = 0; idxDm0 != lenDm0; ++idxDm0){
            tempDm0.real(*ptrValDm0++);
            tempDm0.imag(*ptrValDm0++);
            double prodXK = 0;
            const double* ptrCoorDm1 = arrCoorDm1 + idxDm1*numDim;
            for(int64_t idxDim = 0; idxDim != numDim; ++idxDim){
                prodXK += (*ptrCoorDm1++)*(*ptrCoorDm0++);
            }
            tempDm1 += tempDm0*std::exp(std::complex<double>(0, prodSign2Pi*prodXK));
        }

        *ptrValDm1++ = tempDm1.real();
        *ptrValDm1++ = tempDm1.imag();

        if(idxThread == 0 && idxDm1%100 == 0){
            printf("[INFO] thread[%d]: progress = %.2f%%\n", (int)idxThread, 100*(double)idxDm1/lenDm1);
        }

    }

    return 0;
}
