from numpy import *
from matplotlib.pyplot import *
import skimage.data as data
import skimage.transform as transform
from packNudftClient.modNudftClient import classNudftClient

sizeImg = 128

def imfft(img): return fft.fftshift(fft.fft2(fft.ifftshift(img)))
def imifft(ksapce): return fft.fftshift(fft.ifft2(fft.ifftshift(ksapce)))

img = data.shepp_logan_phantom()
img = transform.resize(img, (sizeImg, sizeImg))
kspace = imfft(img)

listKx = linspace(-0.5, 0.5, sizeImg, endpoint=False)
listKx = tile(listKx, sizeImg).flatten()
listKy = linspace(-0.5, 0.5, sizeImg, endpoint=False)
listKy = repeat(listKy, sizeImg).flatten()
listInputCoor = array([listKx, listKy], dtype=float64).T.copy()

listInputData = kspace.flatten().copy()

listX = linspace(-sizeImg//2, sizeImg//2, sizeImg, endpoint=False)
listX = tile(listX, sizeImg).flatten()
listY = linspace(-sizeImg//2, sizeImg//2, sizeImg, endpoint=False)
listY = repeat(listY, sizeImg).flatten()
listOutputCoor = array([listX, listY], dtype=float64).T.copy()

objClient = classNudftClient()
listOutputData = objClient.funNuidft(listInputCoor, listInputData, listOutputCoor)

imgReco = listOutputData.reshape((sizeImg, sizeImg))

figure()
subplot(1, 2, 1)
imshow(abs(img), cmap='gray'); title('Original')
subplot(1, 2, 2)
imshow(abs(imgReco), cmap='gray'); title('NUIDFT')
show()