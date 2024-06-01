from numpy import *
from matplotlib.pyplot import *
import skimage.data as data
import skimage.transform as transform
from packNudftClient.modNudftClient import classNudftClient

imgH, imgW = 128, 128

def imfft(img): return fft.fftshift(fft.fft2(fft.ifftshift(img)))
def imifft(ksapce): return fft.fftshift(fft.ifft2(fft.ifftshift(ksapce)))

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

objClient = classNudftClient("127.0.0.1", 7885)
list_OutputData = objClient.funNuidft(list_InputCoor, list_InputData, list_OutputCoor)

imgReco = list_OutputData.reshape((imgH, imgW))

figure()
imshow(abs(imgReco), cmap='gray')
show()