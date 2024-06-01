from numpy import *
from socket import *

class classNudftClient:
    def __init__(self, ipServer:str, portServer:int) -> None:
        self.objSocket = socket(AF_INET, SOCK_STREAM)
        try:
            self.objSocket.connect((ipServer, portServer))
        except:
            raise ConnectionError("in classNudftClient")

    def _funPackData(self, flagIdft:bool, listCoorIn:ndarray, listDataIn:ndarray, listCoorOut:ndarray) -> ndarray:
        assert(listCoorIn.ndim == 2 and listDataIn.ndim == 1 and listCoorOut.ndim == 2)
        assert(listCoorIn.shape[0] == listDataIn.shape[0]) # num of point consistency
        assert(listCoorIn.shape[1] == listCoorOut.shape[1]) # dim consistency

        # derive metadata
        numDim = uint8(listCoorIn.shape[1])
        typeTf = uint8(1 + 2*(numDim-1)) if flagIdft else uint8(2*(numDim-1))
        numCoorIn = uint64(listCoorIn.shape[0])
        numCoorOut = uint64(listCoorOut.shape[0])
        listCoorIn = listCoorIn.astype(float64).flatten()
        listDataIn = listDataIn.astype(complex128)
        listDataIn = array([listDataIn.real, listDataIn.imag], dtype=float64).T.flatten()
        listCoorOut = listCoorOut.astype(float64).flatten()

        # derive validation sum
        bytesPkgTx = typeTf.tobytes() + numCoorIn.tobytes() + numCoorOut.tobytes() + listCoorIn.tobytes() + listDataIn.tobytes() + listCoorOut.tobytes()
        listPkgTx = array(list(bytesPkgTx), dtype=uint8)

        sumBytes = uint8(sum(listPkgTx))

        bytesPkgTx += sumBytes.tobytes()
        listPkgTx = append(listPkgTx, [sumBytes], 0)

        # add header, footer, and escape
        idx0xFA = where(listPkgTx == 0xFA)[0]
        idx0xFB = where(listPkgTx == 0xFB)[0]
        idx0xFC = where(listPkgTx == 0xFC)[0]

        listPkgTx[idx0xFA] = 0xFD
        listPkgTx[idx0xFB] = 0xFE
        listPkgTx[idx0xFC] = 0xFF

        listPkgTx = insert(listPkgTx, concatenate((idx0xFA, idx0xFB, idx0xFC), 0), [uint8(0xFB)], 0)
        listPkgTx = insert(listPkgTx, 0, [uint8(0xFA)], 0)
        listPkgTx = append(listPkgTx, [uint8(0xFC)], 0)

        # return
        return listPkgTx
    
    def _funUnpackData(self, bytesPkgRx:bytes) -> ndarray:
        # check header, footer
        assert(bytesPkgRx[0] == 0xFA)
        assert(bytesPkgRx[-1] == 0xFC)

        # convert to array
        listPkgRx = frombuffer(bytesPkgRx, dtype=uint8).copy()

        # remove header, footer and escape
        listPkgRx = listPkgRx[1:-1]
        assert(listPkgRx[-1] != 0xFB)
        idx0xFB = where(listPkgRx == 0xFB)[0]

        listPkgRx[idx0xFB + 1] -= 0x03
        listPkgRx = delete(listPkgRx, idx0xFB, 0)

        # check sum
        assert(uint8(sum(listPkgRx[:-1])) == listPkgRx[-1])

        # derive data
        listDataOut = frombuffer(listPkgRx[:-1], dtype=float64)

        # return
        return listDataOut

    def _funAcqPkg(self) -> bytes:
        # self.objSocket.setblocking(False)
        flagHeader = False
        bytesPkgRx = bytes()
        while True:
            # bytesPartRx = self.objSocket.recv(int(1e3))
            bytesPartRx = self.objSocket.recv(int(1e3))
            if flagHeader:
                bytesPkgRx += bytesPartRx
            else:
                if 0xFA in bytesPartRx:
                    flagHeader = True
                    bytesPartRx = bytesPartRx[bytesPartRx.index(0xFA):]
                    bytesPkgRx += bytesPartRx
                else:
                    pass
            if 0xFC in bytesPkgRx:
                bytesPkgRx = bytesPkgRx[:bytesPkgRx.index(0xFC)+1]
                break
        return bytesPkgRx
    
    def funNudft(self, listX:ndarray, listIx:ndarray, listK:ndarray) -> ndarray:
        assert(listX.shape[0] == listIx.shape[0]) # num of point consistency
        assert(listX.shape[1] == listK.shape[1]) # dim consistency
        listPkgTx = self._funPackData(False, listX, listIx, listK)
        self.objSocket.send(listPkgTx)
        listPkgRx = self._funAcqPkg()
        listSk = self._funUnpackData(listPkgRx)
        listSk = listSk[0::2] + 1j*listSk[1::2]
        return listSk
    
    def funNuidft(self, listK:ndarray, listSk:ndarray, listX:ndarray) -> ndarray:
        assert(listK.shape[0] == listSk.shape[0]) # num of point consistency
        assert(listK.shape[1] == listX.shape[1]) # dim consistency
        listPkgTx = self._funPackData(True, listK, listSk, listX)
        self.objSocket.send(listPkgTx)
        bytesPkgRx = self._funAcqPkg()
        listIx = self._funUnpackData(bytesPkgRx)
        listIx = listIx[0::2] + 1j*listIx[1::2]
        return listIx

