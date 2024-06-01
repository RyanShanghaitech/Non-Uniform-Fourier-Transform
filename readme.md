# READ ME
## How to use
1. Install `Qt` library (recommanded version: 5.15.9)
1. Create a folder named `build` in folder `NudftServer`
1. Run `cmake ../` in folder `build`
1. Run `make` in folder `build`
1. Start server by executing `./NudftServer`
1. Go to folder `NudftClient` and run Python scipt `testNudftClient.py`
1. Modify the Python code for your own use.

## Abstract
This source code consists of 2 parts
- A C++ program running a TCP server, receiving data and performing NUDFT (Non-Uniform Discrete Fourier Transform) or NUIDFT (Non-Uniform Inverse Discrete Fourier Transform), then sending back the result.
- A Python script running as a TCP client, performing NUDFT by communicating with the server. A Python package for communicating is available.

## Motivation
NUFFT (Non-Uniform Fast Fourier Transform) needs interpolation and may introduce errors. And there are few NUFFT library support all platforms and all languages. By implementing a NUDFT server, we may remove the interpolation error and perform NUDFT on any programming language and any platform.

## Function
The NUDFT performs the following formula:

$$
S(\vec{k}) = \sum_{\vec{x}}{I(\vec{x})e^{-2 \pi \vec{k} \vec{x}}}
$$

The NUIDFT performs the following formula:

$$
I(\vec{x}) = \sum_{\vec{k}}{I(\vec{x})e^{2 \pi \vec{k} \vec{x}}}
$$

Range of $k$ and $x$ is supposed to be $[-0.5, 0.5)^{N}$ and $(-inf, inf)^{N}$. Both $k$ and $x$ need not be integers.

## TCP parameter

Default server address and port are `127.0.0.1` and `7885`. However you can modify these parameter by

1. Create a file `config.ini` in the same foler of server executable, the content should be look like this

```
[ADDR] 127.0.0.1
[PORT] 7885
```

2. Modify the definition of address and port in the beginning of Python script.

## TCP Packet

The definition of a packet is shown below:

### Definition of a packet
```
/*
* packet definition: {0xFA, <data block>, 0xFC}
* 0xFA~0xFC: reserved for protocol
* 0xFA: Packet header
* 0xFB: escape char, 0xFB + 0xF<D~F> denotes for 0x7<A~C>
* 0xFC: Packet footer
*/
```

where `<data block>` could be **Tx data block** (in context of server) or **Rx data block** (also in context of server).

### Definition of Rx data block
```
/*
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
*/
```
### Definition of Tx data block
```
/*
* Tx data block definition:
* {<listOutputData>, <sumBytes>}
* para@<listOutputData>: list of data of input points, dim0: points dim1: real/imag (size of dim1 must be 2)
* type@<listOutputData>: {{float64, float64} ...}
*/
