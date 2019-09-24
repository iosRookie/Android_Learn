package com.common_ui

import android.content.Context
import android.util.AttributeSet
import android.view.View
import android.widget.RelativeLayout
import com.example.myapplication.R
import kotlinx.android.synthetic.main.top_bar_layout.view.*

class TopBar @JvmOverloads constructor (context: Context, attributeSet: AttributeSet? = null, defStyleAttr: Int = 0)
    : RelativeLayout(context, attributeSet, defStyleAttr) {
    public var title: String? = null
    init {
        val typedArray = context.obtainStyledAttributes(attributeSet, R.styleable.TopBar)
        title = typedArray.getString(R.styleable.TopBar_title)
        initView()
        typedArray.recycle()
    }

    private fun initView() {
        View.inflate(context, R.layout.top_bar_layout, this)
        txt_topbar.text = title
    }


}