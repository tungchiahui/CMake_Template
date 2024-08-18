#include "Matrix/eigen3_test.hpp"
#include <iostream>
#include "eigen3/Eigen/Dense"



void eigen3_test(void)
{
    // 创建 2x2 矩阵
    Eigen::Matrix2d mat;
    mat << 1, 2,
           6, 4;

    // 打印矩阵
    std::cout << "打印一个矩阵:\n" << mat << std::endl;
}