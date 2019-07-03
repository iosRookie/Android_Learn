package com.UILearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.app.Fragment
import android.util.Log
import android.view.Display
import android.view.Surface
import com.example.myapplication.R

class FragmentLearnActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_fragment_learn)
        val dis: Display = windowManager.defaultDisplay
        when (dis.rotation) {
            Surface.ROTATION_0, Surface.ROTATION_180 -> {
                supportFragmentManager.beginTransaction().replace(R.id.fragment_learn_layout, FirstFragment()).commit()
            }

            Surface.ROTATION_90, Surface.ROTATION_270 -> {
                supportFragmentManager.beginTransaction().replace(R.id.fragment_learn_layout, SecondFragment()).commit()
            }
        }

        Log.d("Activity Life Cycle","onCreate")
    }

    override fun onAttachFragment(fragment: Fragment?) {
        super.onAttachFragment(fragment)
        Log.d("Activity Life Cycle","onAttachFragment")
    }

    override fun onContentChanged() {
        super.onContentChanged()
        Log.d("Activity Life Cycle","onContentChanged")
    }

    override fun onStart() {
        super.onStart()
        Log.d("Activity Life Cycle","onStart")
    }

    override fun onRestart() {
        super.onRestart()
        Log.d("Activity Life Cycle","onRestart")
    }

    override fun onResume() {
        super.onResume()
        Log.d("Activity Life Cycle","onResume")
    }

    override fun onPause() {
        super.onPause()
        Log.d("Activity Life Cycle","onPause")
    }

    override fun onStop() {
        super.onStop()
        Log.d("Activity Life Cycle","onStop")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("Activity Life Cycle","onDestroy")
    }

}
