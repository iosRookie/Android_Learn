package com.yyg.kotlinlearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import com.example.myapplication.R

class CycleControlActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_cycle_control)

        // Kotlin循环控制
        // for循环可以对任何提供迭代器（iterator）的对象进行遍历
        var array = arrayOf("a","b","c")
        for (i in array) {
            Log.d("CycleControl",i)
        }
        for ((index, value) in array.withIndex()) {
            Log.d("CycleControl", "the element at $index is $value")
        }

        val list = listOf("l", "i", "s", "t")
        for (i in list.indices) {
            Log.d("CycleControl", "item at $i is ${list[i]}")
        }

        // while(布尔表达式){循环语句}      do{布尔表达式}while(循环语句)，先执行一次
        var x = 5
        while (x > 0) {
            Log.d("CycleControl", "${x--}")
        }
        var y = 5
        do {
            Log.d("CycleControl","${y--}")
        }while (y > 0)

        // 返回和跳转
        /*
        * return  默认从最直接包围它的函数或者匿名函数返回
        * break   终止最直接包围它的循环
        * continue 继续下一次最直接包围它的循环
        * */
        for (i in 1..10) {
            if (i == 3) continue
            Log.d("CycleControl", "$i")
            if (i > 5) break
        }

        loop@for (i in 1..10) {
            loop2@for (j in 1..10) {
                if (i > 5) break@loop       // 跳出外循环
                if (j == 3) continue@loop2  // 继续下一次内循环
                Log.d("CycleControl", "$i + $j")
            }
        }

        listOf("l", "i", "s", "t").forEach(fun(value: String) {
            if (value == "i") return@forEach
            Log.d("CycleControl", value)
        })
    }
}
