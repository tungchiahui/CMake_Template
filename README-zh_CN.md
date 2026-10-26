# cmake_template

中文 | [English](README.md)

支持 Linux 和 Windows 的 CMake 工程模板，使用现代 CMake、CMakePresets.json、Ninja 和 VSCode CMake Tools 工作流。Windows 使用 GCC / MinGW-w64，推荐 MSYS2 UCRT64；Linux 使用 GCC。默认语言标准为 C++20。

更详细的模板说明、图形化构建步骤和第三方库配置请访问：

<http://tungchiahui.cn/zh-cn/wiki/2023-10-05-cplusplus-jiao-xue/ch21-cmake-gong-cheng-mu-ban>

## 依赖

需要 CMake 3.22 或更新版本、Ninja、GCC / G++ 和 Eigen 3。预设文件使用格式版本 3。

### Linux

Ubuntu 22.04 可直接使用系统提供的 CMake 3.22.1，无需为本模板升级 CMake。在容器中开发时，将依赖安装在容器内，供 VSCode CMake Tools 使用。

Fedora:

```bash
sudo dnf install cmake ninja-build gcc-c++ eigen3-devel gdb
```

Ubuntu/Debian:

```bash
sudo apt install cmake ninja-build g++ libeigen3-dev gdb
```

### Windows

推荐安装 [MSYS2](https://www.msys2.org/) 来准备工具；项目不依赖 MSYS2 终端或固定安装位置。安装后打开 **MSYS2 UCRT64** 终端，先更新系统：

```bash
pacman -Syu
```

如果提示关闭终端，按提示关闭并重新打开 UCRT64 终端，再次运行更新。然后安装同一环境的工具和 Eigen：

```bash
pacman -S --needed mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-cmake mingw-w64-ucrt-x86_64-ninja mingw-w64-ucrt-x86_64-eigen3 mingw-w64-ucrt-x86_64-gdb
```

以下 Windows 命令均在 UCRT64 终端的项目根目录执行，使用 `/ucrt64/bin` 下的原生 Windows 工具。项目和第三方二进制库应使用匹配的 MinGW 工具链。

#### 已有环境或分别安装

已有工具链时也可以分别安装：准备支持 C++20 的 MinGW-w64 GCC / GDB、CMake 3.22+、Ninja 和 Eigen，将 GCC、CMake、Ninja 的 `bin/` 加入 PATH。自行安装的 Eigen 可通过环境变量 `CMAKE_PREFIX_PATH` 指定安装根目录，或通过 `Eigen3_DIR` 指定配置文件目录。Eigen 是头文件库，不需要按编译器分别编译。

配置好 PATH 后，同样的 CMake 命令可以在 PowerShell 中执行；下面的 Windows 运行命令 `./.../cmake_template.exe` 也可直接使用。

## 构建与测试

CMake Tools 按当前系统显示可用的 configure preset。

### Linux

Debug:

```bash
cmake --preset linux-debug
cmake --build --preset linux-debug
ctest --preset linux-debug
./build/linux-debug/src/cmake_template
```

Release 使用 `linux-release` 替换上面的 `linux-debug`。

验证安装结果：

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

Release 使用 `windows-release` 替换上面的 `windows-debug`。

验证安装结果：

```bash
cmake --install build/windows-debug
./install/windows-debug/bin/cmake_template.exe
```

Windows 构建目录的 `bin/` 包含 EXE 和项目 DLL；开发时，UCRT64 环境提供 GCC 运行库。安装时会将工具链中可找到的常用 GCC 运行库 DLL（libstdc++、libgcc、libwinpthread 等）一并复制到安装目录的 `bin/`，系统 DLL 不会复制。分发时保留整个安装目录，不要只复制 EXE。新增第三方 DLL 依赖时，应另行添加对应 DLL 的安装规则。

### 自定义 Eigen 路径

使用系统包或上述 MSYS2 包时通常无需额外配置。自行安装 Eigen 时，在本地 `CMakeUserPresets.json` 中继承对应预设并设置安装前缀，例如：

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

随后使用 `cmake --preset windows-debug-local` 和 `cmake --build build/windows-debug-local`。该用户预设文件已被 Git 忽略，也可以直接设置包含 `Eigen3Config.cmake` 的 `Eigen3_DIR`。

## VSCode

安装 CMake Tools 和 Microsoft C/C++ 扩展。断点调试使用 GDB。

Windows 默认安装 MSYS2 到 `C:/msys64` 时，将 `C:/msys64/ucrt64/bin` 加入启动 VSCode 进程的 PATH，再重新打开 VSCode。也可以在 PowerShell 中临时设置后打开项目：

```powershell
$env:PATH = "C:\msys64\ucrt64\bin;" + $env:PATH
code .
```

1. 选择当前平台的 Debug 或 Release configure preset。
2. 点击 Configure，然后点击 Build。
3. 选择 `cmake_template` 作为运行/调试 target。
4. 点击 CMake Tools 的运行按钮或 Debug 按钮。

如果调试器未自动识别，Windows 的 GDB 路径通常为 `C:/msys64/ucrt64/bin/gdb.exe`。

使用 clangd 时，仓库 `.clangd` 默认指向 `build/linux-debug`；Windows 下将其 `CompilationDatabase` 改为 `build/windows-debug`，使用其他预设时也对应调整。

## 目录结构

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

`lib1` 和 `lib2` 都在自己的模块内查找并链接 Eigen。公共 API 使用自动生成的 `lib1/export.hpp`、`lib2/export.hpp` 中的导出宏；这些头文件位于各模块的构建目录，并随库一起安装。新增公共函数或类时也应使用对应的 `LIB1_EXPORT` / `LIB2_EXPORT`。

GitHub Actions 覆盖 Linux 与 Windows UCRT64 的 Debug/Release，检查示例运行和安装目录移动后的运行；Windows 安装验证会移除 PATH 中的开发工具链。
