cmake_minimum_required (VERSION 3.0)

aux_source_directory (. SRC_LIST)


# 引用第三方库(例如引用Eigen3矩阵库)
# find_package(Eigen3 REQUIRED)
# include_directories (${EIGEN3_INCLUDE_DIRS})

include_directories (../inc)

add_executable (main ${PROJECT_SOURCE_DIR}/main.cpp ${SRC_LIST})


#EXECUTABLE_OUTPUT_PATH ：目标二进制可执行文件的存放位置
#PROJECT_SOURCE_DIR：工程的根目录
set (EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)