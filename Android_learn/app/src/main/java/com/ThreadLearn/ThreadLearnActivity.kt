package com.ThreadLearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.example.myapplication.R
import java.util.concurrent.Callable
import java.util.concurrent.Executors
import java.util.concurrent.FutureTask
import java.util.concurrent.ThreadFactory

class ThreadLearnActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_thread_learn)

        //线程
        val thredF : ThreadFactory by lazy{
            ThreadFactory { r ->
                Thread(r, "第一个线程")
            }
        }

        val task = FutureTask(Callable<String> { "FutureTask" })

        Executors.newCachedThreadPool().submit {

        }
    }
}
