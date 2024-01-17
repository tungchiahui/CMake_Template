cmake_minimum_required (VERSION 3.0)

# add_compile_options(-std=c++11 -g -Wall) 
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

set(CMAKE_BUILD_TYPE Debug)

project (demo)

add_subdirectory (src)