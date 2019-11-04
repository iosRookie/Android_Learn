package com.common

import android.app.Service
import android.content.Intent
import android.os.Binder
import android.os.IBinder
import android.util.Log

class MyLearnRemoteService : Service() {
    val TAG = "MyLearnRemoteService"
    private val myBinder : MyRemoteBinder = MyRemoteBinder()

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "onCreate")
        try {
//            Thread.sleep(60000)
        } catch (e: InterruptedException) {
            Log.d(TAG, e.printStackTrace().toString())
        }

        Log.d(TAG, Thread.currentThread().toString())
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d(TAG, "onStartCommand")
        return super.onStartCommand(intent, flags, startId)
    }

    override fun onBind(intent: Intent?): IBinder? {
        return myBinder
    }

    override fun onDestroy() {
        Log.d(TAG, "onDestroy")
        super.onDestroy()
    }
}

class MyRemoteBinder : Binder() {

}