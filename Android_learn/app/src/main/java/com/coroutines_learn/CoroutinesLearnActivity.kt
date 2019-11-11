package com.coroutines_learn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.example.myapplication.R
import kotlinx.coroutines.*
import kotlin.coroutines.*

class CoroutinesLearnActivity : AppCompatActivity() {

    private val job = GlobalScope.launch {
        delay(1000L)
        println("World!")
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_coroutines_learn)
//
//        GlobalScope.launch {
//            println("World! ${Thread.currentThread().name}")
//            delay(1000L)
//            println("World! ${Thread.currentThread().name}")
//        }
//        println("Hello, ${Thread.currentThread().name}")
//        runBlocking {
//            println("block ${Thread.currentThread().name}")
//            delay(2000L)
//            println("block finish ${Thread.currentThread().name}")
//        }
//        println("finish")
//
//        println("Hello")
//        job.join()
        runBlocking {
            try {
                withTimeoutOrNull(1300) {
                    job.join()
                    repeat(1000) { i ->
                        println("I'm sleeping $i ...")
                        delay(500L)
                    }
                }
            }catch (e: TimeoutCancellationException) {
                e.printStackTrace()
            }

        }

    }
}
