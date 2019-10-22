package com.common_ui

import android.app.Activity
import android.view.WindowManager

fun Activity.fullScreen(full: Boolean) {
    val lp = window.attributes
    if (full) {
        lp.flags = lp.flags or WindowManager.LayoutParams.FLAG_FULLSCREEN
        window.attributes = lp
        window.addFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS)
    } else {
        lp.flags = lp.flags and (WindowManager.LayoutParams.FLAG_FULLSCREEN.inv())
        window.attributes = lp
        window.clearFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS)
    }
}

