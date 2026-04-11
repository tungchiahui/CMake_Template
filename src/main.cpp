#include <iostream>
#include <functional>
#include <memory>


// 基类
class BaseCalculator
{
public:
    void set_callback(std::function<int(int,int)> cb)
    {
        callback_ = std::move(cb);
    }

    std::function<int(int,int)> get_callback() const
    {
        return callback_;
    }

    void do_calculation(int x, int y)
    {
        if (callback_)
        {
            int result = callback_(x, y);
            std::cout << "Result: " << result << std::endl;
        }
    }

private:
    std::function<int(int,int)> callback_;
};

// 派生类：加法
class AddCalculator : public BaseCalculator
{
public:
    AddCalculator()
    {
        set_callback(std::bind(&AddCalculator::add,this,std::placeholders::_1, std::placeholders::_2));
    }

private:
    int add(int a, int b)
    {
        return a + b;
    }
};

// 派生类：乘法
class MultiplyCalculator : public BaseCalculator
{
public:
    MultiplyCalculator()
    {
        set_callback([this](int a, int b) 
        {
            return a * b;
        });
    }

};

// 主函数
int main()
{
    auto add_calc = std::make_shared<AddCalculator>();
    auto mul_calc = std::make_shared<MultiplyCalculator>();

    add_calc->do_calculation(10, 5);   // 输出 15
    mul_calc->do_calculation(10, 5);   // 输出 50

    // 用加法替换乘法的回调
    mul_calc->set_callback(add_calc->get_callback());
    mul_calc->do_calculation(10, 5);   // 输出 15

    return 0;
}
