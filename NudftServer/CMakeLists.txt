cmake_minimum_required(VERSION 3.1.0)

project(NudftServer VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(CMAKE_VERSION VERSION_LESS "3.7.0")
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
endif()

find_package(Qt5 REQUIRED Core Network)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_executable(NudftServer
    main.cpp
    NudftServer.cpp
    NudftServer.h
)

target_link_libraries(NudftServer Qt5::Core Qt5::Network pthread)