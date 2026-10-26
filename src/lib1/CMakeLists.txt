set(PREFIX "lib1")

file(GLOB_RECURSE ${PREFIX}_SRC_LIST CONFIGURE_DEPENDS
  "${CMAKE_CURRENT_LIST_DIR}/src/*.c"
  "${CMAKE_CURRENT_LIST_DIR}/src/*.cpp"
)

add_library(${PREFIX}_src_lib SHARED
  ${${PREFIX}_SRC_LIST}
)

generate_export_header(${PREFIX}_src_lib
  BASE_NAME ${PREFIX}
  EXPORT_FILE_NAME "${CMAKE_CURRENT_BINARY_DIR}/inc/${PREFIX}/export.hpp"
)

target_include_directories(${PREFIX}_src_lib
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/inc>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/inc>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(${PREFIX}_src_lib
  PUBLIC
    project_options
  PRIVATE
    project_warnings
)

# ========================
# Third-party dependencies
# ========================
find_package(Eigen3 REQUIRED)

target_link_libraries(${PREFIX}_src_lib
  PUBLIC
    Eigen3::Eigen
)

# =======
# Install
# =======
# On Linux, find lib2 in the same installed library directory.
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  set_target_properties(${PREFIX}_src_lib PROPERTIES
    INSTALL_RPATH "$ORIGIN"
  )
endif()

install(TARGETS ${PREFIX}_src_lib
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(DIRECTORY "${CMAKE_CURRENT_LIST_DIR}/inc/"
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/inc/${PREFIX}/export.hpp"
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${PREFIX}"
)
