package com.yyg.kotlinlearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.example.myapplication.R

// 枚举类
/*
* 枚举类最近本的用法是实现一个类型安全的枚举
*
* */

enum class Color1 {
    RED,
    BLACK,
    BLUE
}

// 枚举初始化  每一个枚举都是枚举类的实例，它们可以被初始化
enum class Color(val rgb: Int) {
    RED(0xff0000),
    GREEN(0x00ff00),
    BLUE(0x0000ff)
}

// 默认名称为枚举字符名，值从0开始。若需要指定值，则可以使用其构造函数
enum class Shape(value:Int) {
    ovel(100),
    rectangle(200)
}

// 枚举还支持以声明自己的匿名类及响应方法、以及覆盖积累的方法
//enum class ProtocolState {
//    WAITING {
//        override fun signal() = TALKING
//    },
//    TALKING {
//        override fun signal() = WAITING
//    }
//}

class EnumClassActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_enum_class)

        val shape = Shape.ovel
        Shape.values()
        Shape.valueOf(shape.name)
        shape.ordinal
    }
}
