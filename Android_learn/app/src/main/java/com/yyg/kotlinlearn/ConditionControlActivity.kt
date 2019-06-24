package com.yyg.kotlinlearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import com.example.myapplication.R

class ConditionControlActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_condition_control)

        // if表达式
        val a = "a"
        val b = "b"
        val c = if (a >= b) a else b
        Log.d("ConditionControl", "c is $c")

        // if区间
        val str = "kjgjdfjgaahflu"
        val i = 3
        if (i in 4 until  1) {
            Log.d("ConditionControl", "$i exist 4..1")
        }

        if (i in 1..4) {
            Log.d("ConditionControl", "$i exist 1..4")
        }

        if (i in 1 until str.length) {
            Log.d("ConditionControl", "$i exist 1 until ${str.length}")
        }

        if (i in 4 downTo 1) {
            Log.d("ConditionControl", "$i exist 4 downTo 1")
        }

        if ("a" in str) {
            Log.d("ConditionControl", "a exist $str")
        }

        // when表达式
        /*
        * when将它的参数和所有分支条件顺序比较，直到某个分支满足条件并结束
        * when既可以被当做表达式使用也可以被当作语句使用
        * 表达式：符合条件的分支的值就是整个表达式
        * 语句：忽略个别分支的值
        * */
        var x = 0
        when (x) {
            0,1 -> Log.d("ConditionControl", "x == 0 || x == 1")
            2 -> Log.d("ConditionControl", "x == 2")
            in 0..9 -> Log.d("ConditionControl", "x in 0..9")
            !in 10..20 -> Log.d("ConditionControl", "x not in 10..20")
            validNumber(x) -> Log.d("ConditionControl", "$x is number")
            else -> Log.d("ConditionControl", "x != 0 && x != 1 && x != 2")
        }
    }

    private fun validNumber(x: Any):Int {
        return 5;
    }

    fun hasPrefix(x: String) = when(x) {
        is String -> x.startsWith("prefix")
        else -> false
    }
}
