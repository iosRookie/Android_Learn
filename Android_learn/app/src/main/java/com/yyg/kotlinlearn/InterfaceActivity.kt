package com.yyg.kotlinlearn

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import com.example.myapplication.R

// 接口
/* 默认 open
*  一个类或者对象可以实现一个或多个接口
*  接口中的属性只能是抽象的，不允许初始化，接口不会保存属性值，实现接口时必须重写属性
* */
interface interface1 {
    var name: String

    fun bar()
    fun bar1()
    fun bar2()
    fun foo() {

    }
}

interface interface2 : interface1 {
    override fun bar()
    override fun bar1() {

    }
}

class TestInterface: interface1, interface2 {
    override var name: String
        get() = TODO("not implemented") //To change initializer of created properties use File | Settings | File Templates.
        set(value) {}

    override fun bar() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun bar2() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

//    override fun bar1() {
//        super.bar1()
//    }
}

class InterfaceActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_interface)
    }
}
