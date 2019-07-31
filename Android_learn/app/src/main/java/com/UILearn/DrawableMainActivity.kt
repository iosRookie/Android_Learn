package com.UILearn

import android.graphics.drawable.ClipDrawable
import android.graphics.drawable.ColorDrawable
import android.graphics.drawable.RotateDrawable
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import com.example.myapplication.R
import kotlinx.android.synthetic.main.activity_drawable_main.*
import java.util.*

class DrawableMainActivity : AppCompatActivity() {
    var clipDrawable:ClipDrawable? = null
    var rotateDrawable:RotateDrawable? = null

    val handler = Handler(Handler.Callback {
        if (it?.what == 0x123) {
            clipDrawable?.level?.plus(500)?.let { it1 -> clipDrawable?.setLevel(it1) }
            rotateDrawable?.level?.plus(500)?.let { it1 -> rotateDrawable?.setLevel(it1) }
        }
        if (it?.what == 0x124) {
            clipDrawable?.level?.minus(10000)?.let { it1 -> clipDrawable?.setLevel(it1) }
            rotateDrawable?.level?.minus(10000)?.let { it1 -> rotateDrawable?.setLevel(it1) }
        }
        return@Callback true
    })


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_drawable_main)

        color_drawable_text_code.background = ColorDrawable(0xffff0000.toInt())
        @Suppress("DEPRECATION")
        color_drawable_text_code.setTextColor(resources.getColor(R.color.custom_white))

        clipDrawable = clip_drawable_imageView.drawable as ClipDrawable
        rotateDrawable = rotate_drawable.drawable as RotateDrawable
        val timer = Timer()
        timer.schedule(object : TimerTask(){
            override fun run() {
                if (clipDrawable?.level!! < 10000) {
                    handler.sendEmptyMessage(0x123)
                }

                if (clipDrawable?.level!! >= 10000) {
                    handler.sendEmptyMessage(0x124)
                }
            }
        }, 0, 300)
    }

}
