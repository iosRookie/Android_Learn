package com.common

import android.app.Service
import android.content.ComponentName
import android.content.Intent
import android.content.ServiceConnection
import android.os.Bundle
import android.os.IBinder
import android.os.RemoteException
import android.support.v7.app.AppCompatActivity
import android.telecom.ConnectionService
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.Toast
import com.example.myapplication.R

class ServiceActivity : AppCompatActivity(), View.OnClickListener {
    var binder : MyLearnService.MyBinder? = null

    private lateinit var myAIDLService:MyAIDLService

    private val serviceConnectionService = object : ServiceConnection {
        override fun onServiceDisconnected(name: ComponentName?) {
            Log.d("ServiceActivity", "onServiceDisconnected")
        }

        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            Log.d("ServiceActivity", "onServiceConnected")
            binder = service as MyLearnService.MyBinder
        }

        override fun onBindingDied(name: ComponentName?) {
            Log.d("ServiceActivity", "onBindingDied")
        }

        override fun onNullBinding(name: ComponentName?) {
            Log.d("ServiceActivity", "onBindingDied")
        }
    }


    private val rServiceConnectionService = object : ServiceConnection {
        override fun onServiceDisconnected(name: ComponentName?) {
            Log.d("ServiceActivity", "onServiceDisconnected")
        }

        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            Log.d("ServiceActivity", "onServiceConnected")
            myAIDLService = MyAIDLService.Stub.asInterface(service)
            try {
                val result = myAIDLService.plus(3,5)
                val upperstr = myAIDLService.toUpperCase("hello world")
                Log.d("onServiceConnected", "result is $result")
                Log.d("onServiceConnected", "upperstr is $upperstr")
            } catch (e: RemoteException) {
                e.printStackTrace()
            }
        }

        override fun onBindingDied(name: ComponentName?) {
            Log.d("ServiceActivity", "onBindingDied")
        }

        override fun onNullBinding(name: ComponentName?) {
            Log.d("ServiceActivity", "onBindingDied")
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_service)

        findViewById<Button>(R.id.service_start).setOnClickListener(this)
        findViewById<Button>(R.id.service_stop).setOnClickListener(this)
        findViewById<Button>(R.id.service_bind).setOnClickListener(this)
        findViewById<Button>(R.id.service_unbind).setOnClickListener(this)
        findViewById<Button>(R.id.service_state).setOnClickListener(this)

        findViewById<Button>(R.id.rStart).setOnClickListener(this)
        findViewById<Button>(R.id.rStop).setOnClickListener(this)
        findViewById<Button>(R.id.rBind).setOnClickListener(this)
        findViewById<Button>(R.id.rUnbind).setOnClickListener(this)
        findViewById<Button>(R.id.rState).setOnClickListener(this)

        Log.d("ServiceActivity", "packageName = $packageName")
        Log.d("ServiceActivity", Thread.currentThread().toString())
    }

    override fun onClick(v: View?) {
        when (v?.id) {
            R.id.service_start -> {
                val serviceIntent = Intent(this, MyLearnService::class.java)
//                val serviceIntent = Intent()
//                serviceIntent.action = "com.yyg.service.LEARN_SERVICE"
//                serviceIntent.`package` = packageName
                startService(serviceIntent)
            }
            R.id.service_stop -> {
                val serviceIntent = Intent(this, MyLearnService::class.java)
//                val serviceIntent = Intent(this, MyLearnService::class.java)
                stopService(serviceIntent)
            }
            R.id.service_bind -> {
                val serviceIntent = Intent(this, MyLearnService::class.java)
                bindService(serviceIntent, serviceConnectionService, Service.BIND_AUTO_CREATE)
            }
            R.id.service_unbind -> {
                unbindService(serviceConnectionService)
            }
            R.id.service_state -> {
                Toast.makeText(applicationContext, "Service的count的值为:" + binder?.getCount(), Toast.LENGTH_SHORT).show()
            }

            R.id.rStart -> {
                val rServiceIntent = Intent(this, MyLearnRemoteService::class.java)
                rServiceIntent.action = "com.yyg.service.LEARN_REMOTE_SERVICE"
                startService(rServiceIntent)
            }
            R.id.rStop -> {
                val rServiceIntent = Intent(this, MyLearnRemoteService::class.java)
                stopService(rServiceIntent)
            }
            R.id.rBind -> {
                val rServiceIntent = Intent(this, MyLearnRemoteService::class.java)
                bindService(rServiceIntent, rServiceConnectionService, Service.BIND_AUTO_CREATE)
            }
            R.id.rUnbind -> {
                unbindService(rServiceConnectionService)
            }
            R.id.rState -> {

            }
        }
    }
}
