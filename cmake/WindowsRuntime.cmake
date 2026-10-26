# Keep GCC runtime DLLs beside the installed executable. Ask the compiler for
# their locations so this also works with standalone and cross MinGW toolchains.
if(MINGW)
  get_filename_component(mingw_bin_dir "${CMAKE_CXX_COMPILER}" DIRECTORY)
  set(mingw_runtime_dlls)

  # The libgcc DLL name depends on the toolchain's exception model.
  foreach(runtime_name IN ITEMS
      libstdc++-6.dll
      libgcc_s_seh-1.dll
      libgcc_s_dw2-1.dll
      libgcc_s_sjlj-1.dll
      libwinpthread-1.dll
      libssp-0.dll)
    execute_process(
      COMMAND "${CMAKE_CXX_COMPILER}" "-print-file-name=${runtime_name}"
      OUTPUT_VARIABLE runtime_path
      OUTPUT_STRIP_TRAILING_WHITESPACE
      COMMAND_ERROR_IS_FATAL ANY
    )

    # Some native distributions keep runtime DLLs only in the compiler's bin/.
    if(NOT IS_ABSOLUTE "${runtime_path}" OR NOT EXISTS "${runtime_path}")
      set(runtime_path "${mingw_bin_dir}/${runtime_name}")
    endif()

    if(EXISTS "${runtime_path}")
      list(APPEND mingw_runtime_dlls "${runtime_path}")
    endif()
  endforeach()

  if(mingw_runtime_dlls)
    install(FILES ${mingw_runtime_dlls}
      DESTINATION ${CMAKE_INSTALL_BINDIR}
    )
  endif()
endif()
