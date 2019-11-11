package com.coroutines_learn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.example.myapplication.R
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlin.coroutines.*

class CoroutinesLearnActivity : AppCompatActivity() {

    private val job = GlobalScope.launch {
        delay(1000L)
        print("World!")
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_coroutines_learn)

//        GlobalScope.launch {
//            delay(1000L)
//            println("World!")
//        }
//        println("Hello,")
//        runBlocking {
//            println("block")
//            delay(2000L)
//            println("block finish")
//        }
//        println("finish")

//        println("Hello")
//        job.join()
    }
}
