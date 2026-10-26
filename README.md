# cmake_template

[中文](README-zh_CN.md) | English

A Linux and Windows CMake project template using modern CMake, CMake presets, Ninja, and the VSCode CMake Tools workflow. Windows uses GCC / MinGW-w64, preferably MSYS2 UCRT64; Linux uses GCC. The default language standard is C++20.

For detailed documentation, graphical build instructions, and third-party dependency configuration, visit:

<http://tungchiahui.cn/en-us/wiki/2023-10-05-cplusplus-jiao-xue/ch21-cmake-gong-cheng-mu-ban>

## Requirements

Requires CMake 3.22 or newer, Ninja, GCC / G++, and Eigen 3. The presets use schema version 3.

### Linux

Ubuntu 22.04's CMake 3.22.1 is sufficient; no CMake upgrade is needed. For container development, install the dependencies inside the container used by VSCode CMake Tools.

Fedora:

```bash
sudo dnf install cmake ninja-build gcc-c++ eigen3-devel gdb
```

Ubuntu/Debian:

```bash
sudo apt install cmake ninja-build g++ libeigen3-dev gdb
```

### Windows

Install [MSYS2](https://www.msys2.org/) for the recommended tool setup. The project does not require its terminal or a fixed installation location. After installation, open the **MSYS2 UCRT64** terminal, and update it:

```bash
pacman -Syu
```

If instructed to close the terminal, close it, reopen UCRT64, and run the update again. Then install the matching tools and Eigen:

```bash
pacman -S --needed mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-cmake mingw-w64-ucrt-x86_64-ninja mingw-w64-ucrt-x86_64-eigen3 mingw-w64-ucrt-x86_64-gdb
```

Run the Windows commands below from the project root in UCRT64, using the native Windows tools under `/ucrt64/bin`. Build the project and third-party binary libraries with compatible MinGW toolchains.

#### Existing or standalone tools

Existing or standalone toolchains work too: install C++20-capable MinGW-w64 GCC / GDB, CMake 3.22+, Ninja, and Eigen, and add the GCC, CMake, and Ninja `bin/` directories to PATH. For a custom Eigen installation, set the `CMAKE_PREFIX_PATH` environment variable to its installation prefix, or set `Eigen3_DIR` to its CMake configuration directory. Eigen is header-only and does not need a separate build for each compiler.

Once PATH is configured, the same CMake commands work in PowerShell. The Windows run commands below (`./.../cmake_template.exe`) also work there.

## Build and test

CMake Tools shows configure presets matching the current operating system.

### Linux

Debug:

```bash
cmake --preset linux-debug
cmake --build --preset linux-debug
ctest --preset linux-debug
./build/linux-debug/src/cmake_template
```

For Release, replace `linux-debug` with `linux-release`.

Verify the installation:

```bash
cmake --install build/linux-debug
./install/linux-debug/bin/cmake_template
```

### Windows

Debug:

```bash
cmake --preset windows-debug
cmake --build --preset windows-debug
ctest --preset windows-debug
./build/windows-debug/bin/cmake_template.exe
```

For Release, replace `windows-debug` with `windows-release`.

Verify the installation:

```bash
cmake --install build/windows-debug
./install/windows-debug/bin/cmake_template.exe
```

The Windows build directory's `bin/` contains the executable and project DLLs; the UCRT64 environment supplies the GCC runtime DLLs during development. Installation also copies common GCC runtime DLLs found in the toolchain (libstdc++, libgcc, libwinpthread, etc.) into the installed `bin/`, excluding Windows system DLLs. Distribute the whole installation directory, rather than just the executable. Add explicit installation rules when introducing third-party DLL dependencies.

### Custom Eigen location

System packages and the MSYS2 packages above normally require no extra configuration. For a custom Eigen installation, inherit the relevant preset in a local `CMakeUserPresets.json` and set its installation prefix, for example:

```json
{
  "version": 3,
  "configurePresets": [
    {
      "name": "windows-debug-local",
      "inherits": "windows-debug",
      "cacheVariables": {
        "CMAKE_PREFIX_PATH": "C:/deps/eigen"
      }
    }
  ]
}
```

Then use `cmake --preset windows-debug-local` and `cmake --build build/windows-debug-local`. Git ignores this user preset file. Alternatively, set `Eigen3_DIR` to the directory containing `Eigen3Config.cmake`.

## VSCode

Install CMake Tools and the Microsoft C/C++ extension. Use GDB for breakpoint debugging.

With MSYS2 installed at its default Windows location, add `C:/msys64/ucrt64/bin` to the PATH inherited by VSCode, then reopen VSCode. Alternatively, set it temporarily in PowerShell before opening the project:

```powershell
$env:PATH = "C:\msys64\ucrt64\bin;" + $env:PATH
code .
```

1. Select a Debug or Release configure preset for the current platform.
2. Click Configure, then Build.
3. Select `cmake_template` as the run/debug target.
4. Click the CMake Tools Run or Debug button.

If the debugger is not detected automatically, its Windows path is typically `C:/msys64/ucrt64/bin/gdb.exe`.

For clangd, the repository's `.clangd` defaults to `build/linux-debug`. On Windows, change its `CompilationDatabase` to `build/windows-debug`; adjust it similarly when using another preset.

## Layout

```text
.
├── CMakeLists.txt
├── CMakePresets.json
├── cmake/
│   ├── ProjectOptions.cmake
│   └── WindowsRuntime.cmake
└── src/
    ├── main.cpp
    ├── lib1/
    │   ├── CMakeLists.txt
    │   ├── inc/lib1/eigen3_test.hpp
    │   └── src/eigen3_test.cpp
    └── lib2/
        ├── CMakeLists.txt
        ├── inc/lib2/eigen3_test.hpp
        └── src/eigen3_test.cpp
```

`lib1` and `lib2` each find and link Eigen in their own module. Public APIs use export macros from the generated `lib1/export.hpp` and `lib2/export.hpp` headers. These headers live in the modules' build directories and are installed with the libraries. Mark new public functions and classes with the corresponding `LIB1_EXPORT` / `LIB2_EXPORT` macro.

GitHub Actions covers Linux and Windows UCRT64 in Debug and Release, checking the example and relocated installations. The Windows installation check removes the development toolchain from PATH.
