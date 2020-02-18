package com.UILearn

import android.graphics.Color
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.design.widget.AppBarLayout
import com.example.myapplication.R
import kotlinx.android.synthetic.main.activity_appbar_layout_leran.*

class AppbarLayoutLeran : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_appbar_layout_leran)

        setAvatorChange()
    }

    /**
     * 渐变toolbar背景
     */
    private fun setAvatorChange() {
        appbar.addOnOffsetChangedListener(AppBarLayout.OnOffsetChangedListener { appBarLayout, verticalOffset ->
            //verticalOffset始终为0以下的负数
            val percent = Math.abs(verticalOffset * 1.0f) / appBarLayout.totalScrollRange

            toolbar.setBackgroundColor(changeAlpha(Color.WHITE, percent))
        })
    }

    /** 根据百分比改变颜色透明度  */
    private fun changeAlpha(color: Int, fraction: Float): Int {
        val red = Color.red(color)
        val green = Color.green(color)
        val blue = Color.blue(color)
        val alpha = (Color.alpha(color) * fraction).toInt()
        return Color.argb(alpha, red, green, blue)
    }
}
