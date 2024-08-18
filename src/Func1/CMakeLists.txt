# 定义包前缀变量
set(PREFIX "Func1")
message(STATUS "it's ${PREFIX}:")

# 查找 src 目录及其子目录中的所有.c和.cpp 文件添加到列表(获取的是完整的文件绝对路径)
file(GLOB_RECURSE ${PREFIX}_SRC_LIST "${CMAKE_CURRENT_LIST_DIR}/src/*.c" "${CMAKE_CURRENT_LIST_DIR}/src/*.cpp")
# 输出一下SRC目录
message(STATUS "${PREFIX}_SRC_LIST: ${${PREFIX}_SRC_LIST}")

# 查找 inc 目录及其子目录中的所有.h和.hpp 文件添加到列表(获取的是完整的文件绝对路径)
file(GLOB_RECURSE ${PREFIX}_HEADER_LIST "${CMAKE_CURRENT_LIST_DIR}/inc/*.h" "${CMAKE_CURRENT_LIST_DIR}/inc/*.hpp")
# 输出一下INC目录
message(STATUS "${PREFIX}_HEADER_LIST: ${${PREFIX}_HEADER_LIST}")


# 添加库 将${SRC_LIST}中的库全部创建为src_lib动态库
add_library(${PREFIX}_src_lib SHARED ${${PREFIX}_SRC_LIST})
# 使动态库能够正常找到他自己的头文件
# target_include_directories(${PREFIX}_src_lib PUBLIC ${CMAKE_CURRENT_LIST_DIR}/inc)
# 安装头文件到 install 目录的 include 子目录中再寻找
install(FILES ${${PREFIX}_HEADER_LIST} DESTINATION ${CMAKE_INSTALL_PREFIX}/include/${PREFIX})
