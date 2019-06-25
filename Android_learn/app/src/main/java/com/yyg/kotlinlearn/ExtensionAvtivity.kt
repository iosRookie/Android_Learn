package com.yyg.kotlinlearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import com.example.myapplication.R

// 扩展
/* Kotlin可以对一个类的属性和方法进行扩展，且不需要继承或者使用Decorator
*  扩展是一种静态行为，对被扩展的类代码本身不会造成任何影响
* */

class User(var name: String) {
    companion object { } // 伴生对象
}
// 扩展属性 不允许定义在函数中
// 扩展属性没有后段字段(backing field)，不能被初始化，只能显示的提供getter/setter方法
var User.age: Int
    get() {
        return name.length
    }
    set(value) {
        name = age.toString()
    }
// 伴生对象函数扩展
fun User.Companion.foo() {

}
// 伴生对象属性扩展
//fun User.Companion.gender: Int get() = 10 set(value) {}

// 扩展函数
// 扩展函数是静态解析的，并不是接受者类型的虚拟成员，在调用扩展函数时，具体被调用的是哪一个函数，由调用函数的对象表达式来决定的，而不是动态的类型决定的
// 如果扩展函数和成员函数一致，则使用该函数时，会优先使用成员函数
fun User.print() {
    Log.d("Extension", "扩展方法")
}

fun MutableList<Int>.swap(index1: Int, index2: Int) {
    var tmp = this[index1]             // this关键字指代接收者本身
    this[index1] = this[index2]
    this[index2] = tmp
}

fun Any?.toString(): String {
    if (this == null) return "null"
    return toString()
}

// 扩展声明为成员
/*
*  在一个类内部可以为另一个类声明扩展
* */


class MyClass {
    companion object {
        val myClassField1: Int = 1
        var myClassField2 = "this is myClassField2"
        fun companionFun1() {
            Log.d("Extension", "this is 1st companion function.")
            foo()
        }
        fun companionFun2() {
            Log.d("Extension", "this is 2st companion function.")
            companionFun1()
        }
    }
    fun MyClass.Companion.foo() {
        Log.d("Extension", "伴随对象的扩展函数（内部）")
    }
    fun test2() {
        MyClass.foo()
    }
    init {
        test2()
    }
}
val MyClass.Companion.no: Int
    get() = 10
fun MyClass.Companion.foo() {
    Log.d("Extension", "foo 伴随对象外部扩展函数")
}

class ExtensionAvtivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_extension_avtivity)

        val user = User("yyg")
        user.print()

        Log.d("Extension", "no:${MyClass.no}")
        Log.d("Extension", "field1:${MyClass.myClassField1}")
        Log.d("Extension", "field2:${MyClass.myClassField2}")
        MyClass.foo()
        MyClass.companionFun2()
        MyClass()
    }
}
