# cmake_template

中文 | [English](README.md)

这是一个只支持 Linux 的 CMake 工程模板，使用现代 CMake、CMakePresets.json、Ninja 和 VSCode CMake Tools 工作流。

## 依赖

Fedora:

```bash
sudo dnf install cmake ninja-build eigen3-devel gdb
```

Ubuntu/Debian:

```bash
sudo apt install cmake ninja-build libeigen3-dev gdb
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

如果要按 F5 调试，再安装 Microsoft C/C++ 扩展。这个模板保留了一个极简 `.vscode/launch.json`，它会启动 CMake Tools 当前选择的 target：

1. 选择 `linux-debug` configure preset。
2. 使用 CMake Tools 配置工程。
3. 使用 CMake Tools 构建工程。
4. 选择 `cmake_template` 作为 launch target。
5. 按 F5，选择 `Debug CMake Target`。

日常开发时，可以直接运行或调试 build 目录里的程序：

```bash
./build/linux-debug/src/cmake_template
```

只有在验证安装结果时，才需要 install 后运行：

```bash
cmake --install build/linux-debug
./install/linux-debug/bin/cmake_template
```

## 目录结构

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

`lib1` 和 `lib2` 都在自己模块内部查找并链接 Eigen。最终可执行文件名与项目名一致：`cmake_template`。
