package com.yyg.kotlinlearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import com.example.myapplication.R

class Box<T>(v: T) {
    var value = v
}

class GenericityActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_genericity)

        fun <T>boxIn(value: T) = Box(value)

//        copyWhenGreater(listOf("3","1","5","9","2","4","7","0"), "5")
        Log.d("Genericity", copyWhenGreater(listOf("3","1","5","9","2","4","7","0"), "5").toString())
    }

    fun <T> doPrintln(content: T) {
        when (content) {
            is Int -> Log.d("Genericity", "not Int")
            is String -> Log.d("Genericity", "not String")
            else -> Log.d("Genericity", "not Int not String")
        }
    }

    fun <T : Comparable<T>> sort(list:List<T>) {

    }

    fun <T> copyWhenGreater(list: List<T>, threshold: T) : List<String> where T : CharSequence, T : Comparable<T> {
        return list.filter { it > threshold }.map { it.toString() }
    }
}
