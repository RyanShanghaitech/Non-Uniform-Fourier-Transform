conda install gcc_linux-64 make cmake qt -y
mkdir ./nudft/NudftServer/build/
cmake cmake -S ./nudft/NudftServer/ -B ./nudft/NudftServer/build/
make -C ./nudft/NudftServer/build/
