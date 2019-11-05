package com.example.remoteservice

import android.app.Notification
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.graphics.BitmapFactory
import android.os.IBinder
import android.util.Log

class ForegroundService : Service() {
    val binder = object : IMyAidlInterface.Stub() {
        override fun basicTypes(
            anInt: Int,
            aLong: Long,
            aBoolean: Boolean,
            aFloat: Float,
            aDouble: Double,
            aString: String?
        ) {
            Log.d("ForegroundService", "basicTypes")
        }
    }

    override fun onCreate() {
        super.onCreate()

        Log.d("ForegroundService", "onCreate")
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d("ForegroundService", "onStartCommand")
        val builder = Notification.Builder(this.applicationContext)
        val nfIntent = Intent(this, MainActivity::class.java)

        builder.setContentIntent(PendingIntent.getActivity(this, 0, nfIntent, 0))
            .setLargeIcon(BitmapFactory.decodeResource(this.resources, R.mipmap.ic_launcher))
            .setContentTitle("下拉列表中的Title")
            .setSmallIcon(R.mipmap.ic_launcher_round)
            .setContentText("要显示的内容")
            .setWhen(System.currentTimeMillis())

        val notification = builder.build().apply {
            defaults = Notification.DEFAULT_SOUND
        }

        startForeground(100, notification)

        return super.onStartCommand(intent, flags, startId)
    }

    override fun onBind(intent: Intent?): IBinder? {
        Log.d("ForegroundService", "onBind")

        return null
    }

    override fun onUnbind(intent: Intent?): Boolean {
        Log.d("ForegroundService", "onUnbind")

        return super.onUnbind(intent)
    }

    override fun onDestroy() {
        Log.d("ForegroundService", "onDestroy")

        stopForeground(true)
        super.onDestroy()
    }
}