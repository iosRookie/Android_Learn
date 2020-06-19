package com.ucloudlink.mifi_rental

import android.app.Activity
import android.os.Build
import android.view.View

/**
 * Created by 肖扬威 on 2019/10/16.
 * Email:kaka_xiao91@163.com
 * Description:
 **/
object StatusBarUtil {

    fun setStatusIconColor(activity: Activity, dark: Boolean) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val decorView = activity.window.decorView
            var vis = decorView.systemUiVisibility
            vis = if (dark) {
                vis or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
            } else {
                vis and View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR.inv()
            }
            decorView.systemUiVisibility = vis
        }
    }
}