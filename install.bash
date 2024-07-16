conda install gcc_linux-64 make cmake qt -y
mkdir ./packNudft/NudftServer/build/
cmake cmake -S ./packNudft/NudftServer/ -B ./packNudft/NudftServer/build/
make -C ./packNudft/NudftServer/build/
