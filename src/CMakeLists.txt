add_executable(${PROJECT_NAME}
  ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
)

target_link_libraries(${PROJECT_NAME}
  PRIVATE
    project_options
    project_warnings
)

add_subdirectory(lib1)
add_subdirectory(lib2)

target_link_libraries(${PROJECT_NAME}
  PRIVATE
    lib1_src_lib
    lib2_src_lib
)

set_target_properties(${PROJECT_NAME} PROPERTIES
  INSTALL_RPATH "$ORIGIN/../${CMAKE_INSTALL_LIBDIR}"
)

install(TARGETS ${PROJECT_NAME}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
