package com.yyg.kotlinlearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.example.myapplication.R

// 数据类
/*
*  Kotlin可以创建一个只包含数据的类，关键字data
*  编译器会自动的从主构造函数中根据所有声明的属性提取一下函数：
*       equals()/hashCode()
*       toString()
*       compontentN() functions对应于属性，按声明顺序排列
*       copy()
*  如果这些函数在类中明确定义了或者从超类中继承而来，就不会在生成
*  数据类必须满足：
*       主构函数至少包含一个参数
*       所有主构函数的参数必须表示为val 或者 var
*       数据类不可声明为abstract、open、sealed、inner
*       数据类不能继承其他类，可实现接口
* */

data class UserData(val name: String, val age:Int) {

}

//fun copy(name: String = this.name, age: Int = this.age) = UserData(name, age)

// 密封类

sealed class Expr
data class Const(val number: Double) : Expr()
data class Sum(val e1: Expr, val e2: Expr) : Expr()
object NotANumber : Expr()

fun eval(expr: Expr): Double = when (expr) {
    is Const -> expr.number
    is Sum -> eval(expr.e1) + eval(expr.e2)
    NotANumber -> Double.NaN
}

class DataAndSealedActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_data_and_sealed)

        val jack = UserData("jack", 10)
        val oldJack = jack.copy(name = "oldJack", age = 50)
        val (name, age) = jack   //解构声明

    }
}
