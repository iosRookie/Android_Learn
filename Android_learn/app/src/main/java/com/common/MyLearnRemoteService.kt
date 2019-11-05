package com.common

import android.app.Service
import android.content.Intent
import android.os.Binder
import android.os.IBinder
import android.os.Process
import android.util.Log

class MyLearnRemoteService : Service() {
    val TAG = "MyLearnRemoteService"

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "onCreate")
        try {

        } catch (e: InterruptedException) {
            Log.d(TAG, e.printStackTrace().toString())
        }

        Log.d(TAG, "Process ID is " + Process.myPid().toString())
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d(TAG, "onStartCommand")
        return super.onStartCommand(intent, flags, startId)
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onDestroy() {
        Log.d(TAG, "onDestroy")
        super.onDestroy()
    }

    fun serviceMethod(str: String?) {
        Log.d("serviceMethod print ", str)
    }
}

class MyRemoteBinder : Binder() {

}