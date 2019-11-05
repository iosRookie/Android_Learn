package com.example.remoteservice

import android.content.ComponentName
import android.content.Intent
import android.content.ServiceConnection
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.IBinder
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

//    val serviceConnection = object : ServiceConnection {
//        override fun onBindingDied(name: ComponentName?) {
//            super.onBindingDied(name)
//        }
//
//        override fun onNullBinding(name: ComponentName?) {
//            super.onNullBinding(name)
//        }
//
//        override fun onServiceDisconnected(name: ComponentName?) {
//            TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
//        }
//
//        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
//            TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
//        }
//    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        fStart.setOnClickListener {
            startService(Intent(this, ForegroundService::class.java))
        }

        fStop.setOnClickListener {
            stopService(Intent(this, ForegroundService::class.java))
        }

    }

}
