# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.26

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/ryan/anaconda3/envs/default/bin/cmake

# The command to remove a file.
RM = /home/ryan/anaconda3/envs/default/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ryan/LProject/NUDFT/packNudft/NudftServer

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ryan/LProject/NUDFT/packNudft/NudftServer/build

# Include any dependencies generated for this target.
include CMakeFiles/NudftServer.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/NudftServer.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/NudftServer.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/NudftServer.dir/flags.make

CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.o: CMakeFiles/NudftServer.dir/flags.make
CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.o: NudftServer_autogen/mocs_compilation.cpp
CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.o: CMakeFiles/NudftServer.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ryan/LProject/NUDFT/packNudft/NudftServer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.o -MF CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.o.d -o CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.o -c /home/ryan/LProject/NUDFT/packNudft/NudftServer/build/NudftServer_autogen/mocs_compilation.cpp

CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ryan/LProject/NUDFT/packNudft/NudftServer/build/NudftServer_autogen/mocs_compilation.cpp > CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.i

CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ryan/LProject/NUDFT/packNudft/NudftServer/build/NudftServer_autogen/mocs_compilation.cpp -o CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.s

CMakeFiles/NudftServer.dir/main.cpp.o: CMakeFiles/NudftServer.dir/flags.make
CMakeFiles/NudftServer.dir/main.cpp.o: /home/ryan/LProject/NUDFT/packNudft/NudftServer/main.cpp
CMakeFiles/NudftServer.dir/main.cpp.o: CMakeFiles/NudftServer.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ryan/LProject/NUDFT/packNudft/NudftServer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/NudftServer.dir/main.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/NudftServer.dir/main.cpp.o -MF CMakeFiles/NudftServer.dir/main.cpp.o.d -o CMakeFiles/NudftServer.dir/main.cpp.o -c /home/ryan/LProject/NUDFT/packNudft/NudftServer/main.cpp

CMakeFiles/NudftServer.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/NudftServer.dir/main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ryan/LProject/NUDFT/packNudft/NudftServer/main.cpp > CMakeFiles/NudftServer.dir/main.cpp.i

CMakeFiles/NudftServer.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/NudftServer.dir/main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ryan/LProject/NUDFT/packNudft/NudftServer/main.cpp -o CMakeFiles/NudftServer.dir/main.cpp.s

CMakeFiles/NudftServer.dir/NudftServer.cpp.o: CMakeFiles/NudftServer.dir/flags.make
CMakeFiles/NudftServer.dir/NudftServer.cpp.o: /home/ryan/LProject/NUDFT/packNudft/NudftServer/NudftServer.cpp
CMakeFiles/NudftServer.dir/NudftServer.cpp.o: CMakeFiles/NudftServer.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ryan/LProject/NUDFT/packNudft/NudftServer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/NudftServer.dir/NudftServer.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/NudftServer.dir/NudftServer.cpp.o -MF CMakeFiles/NudftServer.dir/NudftServer.cpp.o.d -o CMakeFiles/NudftServer.dir/NudftServer.cpp.o -c /home/ryan/LProject/NUDFT/packNudft/NudftServer/NudftServer.cpp

CMakeFiles/NudftServer.dir/NudftServer.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/NudftServer.dir/NudftServer.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ryan/LProject/NUDFT/packNudft/NudftServer/NudftServer.cpp > CMakeFiles/NudftServer.dir/NudftServer.cpp.i

CMakeFiles/NudftServer.dir/NudftServer.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/NudftServer.dir/NudftServer.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ryan/LProject/NUDFT/packNudft/NudftServer/NudftServer.cpp -o CMakeFiles/NudftServer.dir/NudftServer.cpp.s

# Object files for target NudftServer
NudftServer_OBJECTS = \
"CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.o" \
"CMakeFiles/NudftServer.dir/main.cpp.o" \
"CMakeFiles/NudftServer.dir/NudftServer.cpp.o"

# External object files for target NudftServer
NudftServer_EXTERNAL_OBJECTS =

NudftServer: CMakeFiles/NudftServer.dir/NudftServer_autogen/mocs_compilation.cpp.o
NudftServer: CMakeFiles/NudftServer.dir/main.cpp.o
NudftServer: CMakeFiles/NudftServer.dir/NudftServer.cpp.o
NudftServer: CMakeFiles/NudftServer.dir/build.make
NudftServer: /home/ryan/anaconda3/envs/default/lib/libQt5Network.so.5.15.2
NudftServer: /home/ryan/anaconda3/envs/default/lib/libQt5Core.so.5.15.2
NudftServer: CMakeFiles/NudftServer.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ryan/LProject/NUDFT/packNudft/NudftServer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable NudftServer"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/NudftServer.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/NudftServer.dir/build: NudftServer
.PHONY : CMakeFiles/NudftServer.dir/build

CMakeFiles/NudftServer.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/NudftServer.dir/cmake_clean.cmake
.PHONY : CMakeFiles/NudftServer.dir/clean

CMakeFiles/NudftServer.dir/depend:
	cd /home/ryan/LProject/NUDFT/packNudft/NudftServer/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ryan/LProject/NUDFT/packNudft/NudftServer /home/ryan/LProject/NUDFT/packNudft/NudftServer /home/ryan/LProject/NUDFT/packNudft/NudftServer/build /home/ryan/LProject/NUDFT/packNudft/NudftServer/build /home/ryan/LProject/NUDFT/packNudft/NudftServer/build/CMakeFiles/NudftServer.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/NudftServer.dir/depend
