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

# Utility rule file for NudftServer_autogen.

# Include any custom commands dependencies for this target.
include CMakeFiles/NudftServer_autogen.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/NudftServer_autogen.dir/progress.make

CMakeFiles/NudftServer_autogen:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/ryan/LProject/NUDFT/packNudft/NudftServer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Automatic MOC and UIC for target NudftServer"
	/home/ryan/anaconda3/envs/default/bin/cmake -E cmake_autogen /home/ryan/LProject/NUDFT/packNudft/NudftServer/build/CMakeFiles/NudftServer_autogen.dir/AutogenInfo.json ""

NudftServer_autogen: CMakeFiles/NudftServer_autogen
NudftServer_autogen: CMakeFiles/NudftServer_autogen.dir/build.make
.PHONY : NudftServer_autogen

# Rule to build all files generated by this target.
CMakeFiles/NudftServer_autogen.dir/build: NudftServer_autogen
.PHONY : CMakeFiles/NudftServer_autogen.dir/build

CMakeFiles/NudftServer_autogen.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/NudftServer_autogen.dir/cmake_clean.cmake
.PHONY : CMakeFiles/NudftServer_autogen.dir/clean

CMakeFiles/NudftServer_autogen.dir/depend:
	cd /home/ryan/LProject/NUDFT/packNudft/NudftServer/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ryan/LProject/NUDFT/packNudft/NudftServer /home/ryan/LProject/NUDFT/packNudft/NudftServer /home/ryan/LProject/NUDFT/packNudft/NudftServer/build /home/ryan/LProject/NUDFT/packNudft/NudftServer/build /home/ryan/LProject/NUDFT/packNudft/NudftServer/build/CMakeFiles/NudftServer_autogen.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/NudftServer_autogen.dir/depend
