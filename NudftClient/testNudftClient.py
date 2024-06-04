from numpy import *
from matplotlib.pyplot import *
import skimage.data as data
import skimage.transform as transform
from os import path
from packNudftClient.modNudftClient import classNudftClient

imgH, imgW = 128, 128

def imfft(img): return fft.fftshift(fft.fft2(fft.ifftshift(img)))
def imifft(ksapce): return fft.fftshift(fft.ifft2(fft.ifftshift(ksapce)))

dirRoot = path.dirname(path.abspath(__file__))
fileCfg = open(path.join(dirRoot, "../config/config.ini"), "r")
addrServer = fileCfg.readline()[7:-1]
portServer = int(fileCfg.readline()[7:])

img = data.shepp_logan_phantom()
img = transform.resize(img, (imgH, imgW))
kspace = imfft(img)

list_Kx = linspace(-0.5, 0.5, imgW, endpoint=False)
list_Kx = tile(list_Kx, imgH).flatten()
list_Ky = linspace(-0.5, 0.5, imgH, endpoint=False)
list_Ky = repeat(list_Ky, imgW).flatten()
list_InputCoor = array([list_Kx, list_Ky], dtype=float64).T.copy()

list_InputData = kspace.flatten().copy()

list_X = linspace(-imgW//2, imgW//2, imgW, endpoint=False)
list_X = tile(list_X, imgH).flatten()
list_Y = linspace(-imgH//2, imgH//2, imgH, endpoint=False)
list_Y = repeat(list_Y, imgW).flatten()
list_OutputCoor = array([list_X, list_Y], dtype=float64).T.copy()

objClient = classNudftClient(addrServer, portServer)
list_OutputData = objClient.funNuidft(list_InputCoor, list_InputData, list_OutputCoor)

imgReco = list_OutputData.reshape((imgH, imgW))

figure()
subplot(1, 2, 1)
imshow(abs(img), cmap='gray'); title('Original')
subplot(1, 2, 2)
imshow(abs(imgReco), cmap='gray'); title('NUIDFT')
show()