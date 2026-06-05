# cmake_template

[中文](README-zh_CN.md) | English

A Linux-only CMake project template using modern CMake, CMake presets, Ninja, and the VSCode CMake Tools workflow.

## Requirements

Fedora:

```bash
sudo dnf install cmake ninja-build eigen3-devel
```

Ubuntu/Debian:

```bash
sudo apt install cmake ninja-build libeigen3-dev
```

## Build

Debug:

```bash
cmake --preset linux-debug
cmake --build --preset linux-debug
cmake --install build/linux-debug
./install/linux-debug/bin/cmake_template
```

Release:

```bash
cmake --preset linux-release
cmake --build --preset linux-release
cmake --install build/linux-release
./install/linux-release/bin/cmake_template
```

## VSCode

Install the CMake Tools extension, select the `linux-debug` or `linux-release` preset, then configure and build from CMake Tools.

## Layout

```text
.
├── CMakeLists.txt
├── CMakePresets.json
├── cmake/
│   └── ProjectOptions.cmake
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

`lib1` and `lib2` each find and link Eigen where they use it. The executable is named after the project: `cmake_template`.
