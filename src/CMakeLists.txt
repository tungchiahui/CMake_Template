# 查找 src 目录及其子目录中的所有.c和.cpp 文件添加到列表(获取的是完整的文件绝对路径)
file(GLOB_RECURSE SRC_LIST "${CMAKE_SOURCE_DIR}/src/*.c" "${CMAKE_SOURCE_DIR}/src/*.cpp")
# 输出一下SRC目录
message(STATUS "SRC_LIST: ${SRC_LIST}")

# 查找 inc 目录及其子目录中的所有.h和.hpp 文件添加到列表(获取的是完整的文件绝对路径)
file(GLOB_RECURSE HEADER_LIST "${CMAKE_SOURCE_DIR}/inc/*.h" "${CMAKE_SOURCE_DIR}/inc/*.hpp")
# 输出一下INC目录
message(STATUS "HEADER_LIST: ${HEADER_LIST}")

# 将指定目录下的所有源文件（不包括子目录中的文件）添加到一个列表中(用file更好)
# aux_source_directory (. SRC_LIST)

# 利用指定的源文件在项目中添加可执行文件 (该命令必须靠前)
# add_executable(<可执行文件名> <源文件列表>)   源文件可以有多个，用空格隔开
add_executable(${TARGET_NAME} ${CMAKE_SOURCE_DIR}/main.cpp)


# 给指定的目标添加头文件搜索路径(只需要一个目录即可，不需要完整的绝对路径,所以用不到${HEADER_LIST})(还有一个叫include_directories，类似于全局变量，一般大工程不用)
# target_include_directories(<target> <INTERFACE|PUBLIC|PRIVATE> <dir1 dir2 ...>)
# target_include_directories(${TARGET_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/inc)

# 指定可执行文件的输出路径
# CMake 中用于设置目标属性的命令。通过这个命令，你可以为特定目标配置各种属性
# set_target_properties(target_name PROPERTIES property1 value1 property2 value2 ...)
# target_name：指定你要设置属性的目标名称
# PROPERTIES：表示接下来的键值对是要设置的属性
# property：目标的属性名 (RUNTIME_OUTPUT_DIRECTORY 是一个属性名，用于指定可执行文件的输出目录)
# value：属性的值 (${CMAKE_SOURCE_DIR}/bin 是这个属性的值，指定了输出目录的位置)
set_target_properties(${TARGET_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)


# 添加库 将${SRC_LIST}中的库全部创建为src_lib动态库
add_library(src_lib SHARED ${SRC_LIST})
# 将动态库src_lib与目标进行链接
target_link_libraries(${TARGET_NAME} PUBLIC src_lib)
# 使动态库能够正常找到他自己的头文件
target_include_directories(src_lib PUBLIC ${CMAKE_SOURCE_DIR}/inc)


# 引用第三方库(例如引用Eigen3矩阵库)
# 查找 库 的包
find_package(Eigen3 REQUIRED)
# 查找 库 头文件
target_include_directories(${TARGET_NAME} PUBLIC ${EIGEN3_INCLUDE_DIRS})
# 提示是否找到 库
message(STATUS "Eigen3 include dirs: ${EIGEN3_INCLUDE_DIRS}")


# 引用第三方库(例如引用OpenCV4库)
# 查找 库 的包
find_package(OpenCV REQUIRED)
# 查找 库 头文件
target_include_directories(${TARGET_NAME} PUBLIC ${OpenCV_INCLUDE_DIRS})
# 链接 库
target_link_libraries(${TARGET_NAME} PUBLIC ${OpenCV_LIBS})
# 提示是否找到 库
message(STATUS "OpenCV library status:")
message(STATUS "> version: ${OpenCV_VERSION}")
message(STATUS "> include: ${OpenCV_INCLUDE_DIRS}")
message(STATUS "> libraries: ${OpenCV_LIBS}")
