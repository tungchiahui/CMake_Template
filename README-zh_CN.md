# README

中文 | [English](README.md) 

1. 项目名称：CMake_Template_Project
2. 版本：v1.0
3. 版本状态：预发行版本
4. 作者：Tung Chia-hui
5. 网站：[https://github.com/tungchiahui](https://github.com/tungchiahui)
6. 电子邮件：tungchiahui@gmail.com
7. 团队：山东理工大学机电创新学会Vinci机器人队
8. 构建日期：2023-03-20
9. 未来功能：
    1. 让Make的日志加入到log文件夹中。
    2. 为vinci_emis脚本添加更多的东西


##### 倘若运行报错，报错为缺少一些库，请查看自己是否有Eigen3和OpenCV4。
##### 需要使用脚本的请看script文件夹。





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
