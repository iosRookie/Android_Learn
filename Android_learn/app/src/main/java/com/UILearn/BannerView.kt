package com.UILearn

import android.content.Context
import android.util.AttributeSet
import android.view.View
import android.widget.RelativeLayout
import com.example.myapplication.R

class BannerView(context: Context): RelativeLayout(context) {
    constructor(context: Context, attrs: AttributeSet) : this(context)
    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int) : this(context, attrs) {
        View.inflate(context, R.layout.banner_content_layout, this)

        initView()
    }

    fun initView() {

    }
}