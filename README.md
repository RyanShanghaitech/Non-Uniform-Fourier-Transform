# READ ME
## Requirements
1. Currently, only `linux(or wsl) + conda` platform is supported. To use this package on other platform, you may need to re-compile the `NudftServer` executable and install environments on your own.

## How to use
1. Run `bash install.bash` first to install essential environment.
1. See example `example.py`.

## Abstract
A python package perform NUDFT with C++ backend.

## Motivation
1. NUFFT (Non-Uniform Fast Fourier Transform) needs interpolation and may introduce errors. This package perform NUDFT, which may provide the more precise result than NUFFT and maybe useful for numerial simulation.
1. Most NUFFT package does not support DFT between two non-Cartesian domain (for example, non-Cartesian kspace to non-Cartesian image). This package allows to perform DFT between two non-Cartesian domain.

## Function
The NUDFT performs the following formula:

$$
S(\vec{k}) = \sum_{\vec{x}}{I(\vec{x})e^{-2 \pi \vec{k} \vec{x}}}
$$

The NUIDFT performs the following formula:

$$
I(\vec{x}) = \sum_{\vec{k}}{S(\vec{k})e^{2 \pi \vec{k} \vec{x}}}
$$

Range of $k$ and $x$ is supposed to be $[-0.5, 0.5)^{N}$ and $(-inf, inf)^{N}$. Both $k$ and $x$ need not to be integers.
