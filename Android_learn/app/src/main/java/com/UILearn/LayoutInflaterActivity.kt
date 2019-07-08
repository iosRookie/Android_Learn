package com.UILearn

import android.annotation.SuppressLint
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.RelativeLayout
import android.widget.RelativeLayout.*
import com.example.myapplication.R

class LayoutInflaterActivity : AppCompatActivity() {

    @SuppressLint("ResourceType")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val ly: RelativeLayout = RelativeLayout(this)
        val btnOne: Button = Button(this)
        btnOne.text = "按钮1"
        btnOne.id = 123
        val btnTow: Button = Button(this)
        btnTow.text = "按钮2"


        var lyp1 = LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT)
        lyp1.addRule(CENTER_IN_PARENT)

        var lyp2: LayoutParams = LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT)
        lyp2.addRule(BELOW, 123)
        lyp2.addRule(ALIGN_PARENT_RIGHT)

        ly.addView(btnOne, lyp1)
        ly.addView(btnTow, lyp2)

        setContentView(ly)
    }
}
