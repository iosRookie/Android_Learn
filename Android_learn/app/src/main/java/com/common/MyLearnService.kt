package com.common

import android.app.Service
import android.content.Intent
import android.os.Binder
import android.os.IBinder
import android.util.Log
import kotlin.concurrent.thread

class MyLearnService : Service() {
    private var count : Int = 0
    private var quit : Boolean = true
    private val myBinder : MyBinder = MyBinder()

    inner class MyBinder : Binder() {
        fun getCount(): Int {
            return count
        }
    }

    override fun onBind(intent: Intent): IBinder {
        Log.d("MyLearnService","onBind")
        return myBinder
    }

    override fun onCreate() {
        super.onCreate()
        Log.d("MyLearnService","onCreate")

        thread(true) {
            while (!quit) {
                Thread.sleep(1000)
                count ++
            }
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return super.onStartCommand(intent, flags, startId)
        Log.d("MyLearnService","onStartCommand")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("MyLearnService","onDestroy")
        quit = true
    }

    override fun onRebind(intent: Intent?) {
        super.onRebind(intent)
        Log.d("MyLearnService","onRebind")
    }

    override fun onUnbind(intent: Intent?): Boolean {
        return super.onUnbind(intent)
        Log.d("MyLearnService","onUnbind")
    }

}
