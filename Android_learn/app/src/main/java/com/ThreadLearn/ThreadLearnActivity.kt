package com.ThreadLearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import android.os.HandlerThread
import android.os.Message
import android.os.Process.THREAD_PRIORITY_DEFAULT
import android.util.Log
import com.example.myapplication.R
import kotlinx.android.synthetic.main.activity_thread_learn.*

class ThreadLearnActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_thread_learn)

        threadButton.setOnClickListener {
            threadTest()
        }

        handlerThreadButton.setOnClickListener {
            handlerThreadTest()
        }
    }

    private fun handlerThreadTest() {
        val handlerThread = HandlerThreadTest("handler_thread_test")
        Log.d("ThreadLearnActivity","handlerThread state ${handlerThread.state}")

        handlerThread.start()
        val handler = object : Handler(handlerThread.looper) {
            override fun handleMessage(msg: Message?) {
                Log.d("ThreadLearnActivity","handleMessage")
            }
        }

        try {
            handler.sendMessage(Message().apply { obj = "first" })
            Log.d("ThreadLearnActivity","handlerThread state ${handlerThread.state}")
            handler.sendMessage(Message().apply { obj = "second" })
            Log.d("ThreadLearnActivity","handlerThread state ${handlerThread.state}")
        } catch (e: IllegalStateException) {
            e.printStackTrace()
        }

        handlerThread.quitSafely()

        try {
            handler.sendMessage(Message().apply { obj = "third" })
        } catch (e: IllegalStateException) {
            e.printStackTrace()
        }
    }

    private fun threadTest() {
        val tThread = Thread(Runnable {
            Log.d("ThreadLearnActivity","Thread")
        })
        Log.d("ThreadLearnActivity","Thread state ${tThread.state}")
        tThread.start()
        Log.d("ThreadLearnActivity","Thread state ${tThread.state}")
    }
}

class HandlerThreadTest @JvmOverloads constructor(name: String, priority: Int = THREAD_PRIORITY_DEFAULT):HandlerThread(name, priority) {

}


