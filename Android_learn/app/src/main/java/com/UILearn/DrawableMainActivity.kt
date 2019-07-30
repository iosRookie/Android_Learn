package com.UILearn

import android.graphics.drawable.ColorDrawable
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.example.myapplication.R
import kotlinx.android.synthetic.main.activity_drawable_main.*

class DrawableMainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_drawable_main)

        color_drawable_text_code.background = ColorDrawable(0xffff0000.toInt())
        @Suppress("DEPRECATION")
        color_drawable_text_code.setTextColor(resources.getColor(R.color.custom_white))
    }

}
