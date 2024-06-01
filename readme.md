# READ ME
## Abstract
This source code consists of 2 parts
- A C++ program running a TCP server, receiving data and performing NUDFT (Non-Uniform Discrete Fourier Transform) or NUIDFT (Non-Uniform Inverse Discrete Fourier Transform), then sending back the result.
- A Python script running as a TCP client, performing NUDFT by communicate with the server. A Python package for communicating is provided.

## Motivation
NUFFT (Non-Uniform Fast Fourier Transform) needs interpolation and may introduce errors. And there are few NUFFT library support all platforms and all languages. By implementing a NUDFT server, we may remove the interpolation error and perform NUDFT on any programming language and any platform.

## Notes
The NUDFT performs the following formula:

$$
S(\vec{k}) = \sum_{\vec{x}}{I(\vec{x})e^{-2 \pi \vec{k} \vec{x}}}
$$

The NUIDFT performs the following formula:

$$
I(\vec{x}) = \sum_{\vec{k}}{I(\vec{x})e^{2 \pi \vec{k} \vec{x}}}
$$

Range of $k$ and $x$ is supposed to be $[-0.5, 0.5)^{N}$ and $(-inf, inf)^{N}$. Both $k$ and $x$ need not be integers.

The definition of a packet is shown below:
```
/*
* packet definition: {0xFA, <data block>, 0xFC}
* 0xFA~0xFC: reserved for protocol
* 0xFA: Packet header
* 0xFB: escape char, 0xFB + 0xF<D~F> denotes for 0x7<A~C>
* 0xFC: Packet footer
*
* Rx data block definition:
* {<typeTransform>, <numInputCoor>, <numOutputCoor>, <listInputCoor>, <listInputData>, <listOutputCoor>, <sumBytes>}
* para@<typeTransform>: a byte specifying the type of transform, see below
* // 0x00: NUDFT_1D
* // 0x01: NUIDFT_1D
* // 0x02: NUDFT_2D
* // 0x03: NUIDFT_2D
* // 0x04: NUDFT_3D
* // 0x05: NUIDFT_3D,
* para@<numInputCoor>: specifying the number of input points
* para@<numOutputCoor>: specifying the number of output points
* para@<listInputCoor>: list of coordinates of input points, dim0: points dim1: x/y/z (size of dim1 could be 1, 2, 3 depending on the type of transform)
* para@<listInputData>: list of data of input points, dim0: points dim1: real/imag (size of dim1 must be 2)
* para@<listOutputCoor>: list of coordinates of output points, dim0: points dim1: x/y/z (size of dim1 could be 1, 2, 3 depending on the type of transform)
* para@<sumBytes>: sum of all bytes for verification
* type@<typeTransform>: uint8
* // 0x00: NUDFT_1D
* // 0x01: NUIDFT_1D
* // 0x02: NUDFT_2D
* // 0x03: NUIDFT_2D
* // 0x04: NUDFT_3D
* // 0x05: NUIDFT_3D,
* type@<numInputCoor>: uint64
* type@<numOutputCoor>: uint64
* type@<listInputCoor>: {{float64, [float64, float64]} ...}
* type@<listInputData>: {{float64, float64} ...}
* type@<listOutputCoor>: {{float64, [float64, float64]} ...}
* type@<sumBytes>: uint8
*
* Tx data block definition:
* {<listOutputData>, <sumBytes>}
* para@<listOutputData>: list of data of input points, dim0: points dim1: real/imag (size of dim1 must be 2)
* type@<listOutputData>: {{float64, float64} ...}
*
* range of k and xyz
* k: [-0.5, 0.5]
* xyz: [-inf, inf]
*
*/
```