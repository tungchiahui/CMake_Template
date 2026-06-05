# cmake_template

[中文](README-zh_CN.md) | English

A Linux-only CMake project template using modern CMake, CMake presets, Ninja, and the VSCode CMake Tools workflow.

## Requirements

Fedora:

```bash
sudo dnf install cmake ninja-build eigen3-devel gdb
```

Ubuntu/Debian:

```bash
sudo apt install cmake ninja-build libeigen3-dev gdb
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

For F5 debugging, also install the Microsoft C/C++ extension. This template keeps a minimal `.vscode/launch.json` that launches the currently selected CMake target:

1. Select the `linux-debug` configure preset.
2. Configure the project with CMake Tools.
3. Build the project with CMake Tools.
4. Select `cmake_template` as the launch target.
5. Press F5 and choose `Debug CMake Target`.

During development, run or debug the build-tree executable directly:

```bash
./build/linux-debug/src/cmake_template
```

Use install only when you want to verify the installed layout:

```bash
cmake --install build/linux-debug
./install/linux-debug/bin/cmake_template
```

## Layout

```text
.
├── CMakeLists.txt
├── CMakePresets.json
├── .vscode/
│   └── launch.json
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
