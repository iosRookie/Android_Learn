package com.yyg.kotlinlearn

import android.content.Context
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.example.myapplication.R

/*
* Kotlin中所有的类都继承Any类，没声明超类的默认超类是Any
* Any默认提供三个函数
*   equals()
*   hashCode()
*   toString()
*   注：Any不是java.lang.Object
*   如果一个类要被继承，可以使用open进行修饰，默认是final的
*
* 子类继承父类时，不能有跟父类同名的变量，除非父类中该变量为private或者override变量
* 子类重写父类变量或者方法时，不能将访问权限范围缩小，不能舍弃父类已生成的方法
*
*   构造函数：
*       1.如果子类有主构造函数，则基类必须在主构造函数中立即初始化
*       2.如果子类没有主构造函数，则必须在每一个次构造函数中间接或直接用super关键字初始化基类，初始化基类时可以调用基类的不同构造方法
*   即子类在构造过程中必须先初始化基类
* */

open class Person1(var name: String, var age: Int) {
    open fun study() {

    }
}

class Student1 constructor(name: String, age: Int, var no: String, var score: Int) : Person1(name, age) {
    override fun study() {
        super.study()
    }
}

open class A(x: Int, y: Int) {
    open val x: Int = x
        get
    open val y: Int = y
        get
    open fun f() {

    }
}

interface B {
    // 接口的成员默认是open的
    fun f() {

    }
}

class C(override val y: Int) : A(5, 5), B {
    override var x: Int = super<A>.x
    init {
        this.y
    }
    override fun f() {
        super<A>.f()
        super<B>.f()
    }
}



class InheritActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_inherit)
    }
}
