# This example demonstrates how to use the NUDFT client to perform non-uniform discrete Fourier transform (NUDFT) with Cartesian data on a 2D image. To use non-Cartesian data, you can modify the input coordinates and corresponding data.

from numpy import *
from matplotlib.pyplot import *
import skimage.data as data
import skimage.transform as transform
from packNudft.modNudftClient import classNudftClient

sizeImg = 128

def imfft(img): return fft.fftshift(fft.fft2(fft.ifftshift(img)))
def imifft(kspace): return fft.fftshift(fft.ifft2(fft.ifftshift(kspace)))

# generate phantom
img = data.shepp_logan_phantom()
img = transform.resize(img, (sizeImg, sizeImg))
kspace = imfft(img)

# generate list of input (kspace) coordinates
listKx = linspace(-0.5, 0.5, sizeImg, endpoint=False)
listKx = tile(listKx, sizeImg).flatten()
listKy = linspace(-0.5, 0.5, sizeImg, endpoint=False)
listKy = repeat(listKy, sizeImg).flatten()
listInputCoor = array([listKx, listKy], dtype=float64).T.copy()

# generate list of input (kspace) data
listInputData = kspace.flatten().copy()

# generate list of output (img) coordinates
listX = linspace(-sizeImg//2, sizeImg//2, sizeImg, endpoint=False)
listX = tile(listX, sizeImg).flatten()
listY = linspace(-sizeImg//2, sizeImg//2, sizeImg, endpoint=False)
listY = repeat(listY, sizeImg).flatten()
listOutputCoor = array([listX, listY], dtype=float64).T.copy()

# run NUIDFT
objClient = classNudftClient("127.0.0.1", 7886)
listOutputData = objClient.funNuidft(listInputCoor, listInputData, listOutputCoor)
imgReco = listOutputData.reshape((sizeImg, sizeImg))

# show results
figure()
subplot(1, 2, 1)
imshow(abs(img), cmap='gray'); title('Original')
subplot(1, 2, 2)
imshow(abs(imgReco), cmap='gray'); title('NUIDFT')
show()