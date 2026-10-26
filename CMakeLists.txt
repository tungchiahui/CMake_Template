cmake_minimum_required(VERSION 3.22)

project(cmake_template VERSION 1.0.0 LANGUAGES C CXX)

include(GNUInstallDirs)
include(CTest)

option(BUILD_SHARED_LIBS "Build shared project libraries" ON)

include("${CMAKE_CURRENT_LIST_DIR}/cmake/ProjectOptions.cmake")

add_subdirectory(src)

include("${CMAKE_CURRENT_LIST_DIR}/cmake/WindowsRuntime.cmake")

if(BUILD_TESTING)
  add_test(NAME eigen_example COMMAND ${PROJECT_NAME})
  set_tests_properties(eigen_example PROPERTIES
    PASS_REGULAR_EXPRESSION "Determinant = -2"
  )
endif()
