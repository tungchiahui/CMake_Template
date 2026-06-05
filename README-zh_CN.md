# cmake_template

中文 | [English](README.md)

这是一个只支持 Linux 的 CMake 工程模板，使用现代 CMake、CMakePresets.json、Ninja 和 VSCode CMake Tools 工作流。

## 依赖

Fedora:

```bash
sudo dnf install cmake ninja-build eigen3-devel
```

Ubuntu/Debian:

```bash
sudo apt install cmake ninja-build libeigen3-dev
```

## 构建

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

安装 CMake Tools 扩展后，选择 `linux-debug` 或 `linux-release` preset，然后通过 CMake Tools 配置和构建即可。

## 目录结构

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

`lib1` 和 `lib2` 都在自己模块内部查找并链接 Eigen。最终可执行文件名与项目名一致：`cmake_template`。
