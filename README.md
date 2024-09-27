# README
1. Project Name: CMake_Template_Project
2. Version: v2.0
3. State: Pre-Release
4. Author: Tung Chia-hui
5. Website: [https://github.com/tungchiahui](https://github.com/tungchiahui)
6. E-mail: tungchiahui@gmail.com
7. Organization: SDUT_EMIS_VinciRobot
8. Date: 2023-03-20
9. Future Features: 
    1. Make_Log do not recorded.
    2. Add more things to the vinci_ emis script.


##### If there is an error when running and it says that some libraries are missing, please check if you have Eigen3 and OpenCV4.
##### For those who need to use scripts, please refer to the script folder.


# 项目如何编译、运行程序说明


## 1. `常规命令行运行`

### 功能

- CMake生成Makefiles等编译文件。
- MakeFiles生成bin，lib等文件。
- 加载lib环境，运行二进制程序。

### 使用方法

1. **编译**

   使用以下命令编译出二进制文件：

   ```bash
    # 请确认该脚本在build文件夹下运行
    cd build
    # 进行CMake
    cmake ..
    # 进行MakeFiles
    make install



2. **运行程序**

   使用以下命令运行二进制文件：

   ```bash
    # 请确认该脚本在build文件夹下运行
    cd build
    # 加载lib环境
    source ../install/.setup.bash
    # 运行二进制程序(demo1换成对应的二进制文件名)
    ../install/bin/demo1

## 2. `VScode任务运行`

### 功能

- 用VScode强大的任务功能一键CMake,MakeFiles，加载lib环境以及运行二进制程序。
- 可以使用该方法进行Debug。

### 如何使用

1. **点击Run**

   直接点击VScode的Run即可，注意，如果有报错，需要去log文件夹下查看对应的.log文件来寻找错误，或者打断点Debug。


## 3. `脚本方式运行`

### 功能

- 详见script文件夹下的Markdown。