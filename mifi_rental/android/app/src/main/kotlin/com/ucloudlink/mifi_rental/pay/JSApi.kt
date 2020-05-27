package com.ucloudlink.mifi_rental.pay

import android.webkit.JavascriptInterface
import com.ucloudlink.core_log.ULog
import com.ucloudlink.mifi_rental.PageRouter

class JSApi(private val params: String?, private val activity: PayActivity) {
    /***
     * 同步API.
     * public any handler(Object msg)
     * 参数必须是 Object 类型，并且必须申明（如果不需要参数，申明后不适用即可）。返回值类型没有限制，可以是任意类型。
     * 异步 API.
     * public void handler(Object arg, CompletionHandler handler)
     */
    @JavascriptInterface
    fun getInfo(msg: Any): String? {
        ULog.d("JSApi getInfo $msg params:$params")
        return params
    }

    @JavascriptInterface
    fun jumpToNativePage(msg: Any): String? {
        ULog.i("JSApi jumpToNativePage $msg")
        when (msg) {
            "toPaySuccess" -> {
                PageRouter.openPageByUrl(activity, "query", null)
                activity.finish()
            }
            "toPayCancel", "repayAgain" -> {
                val map = HashMap<String, String>()
                activity.terminalSn?.let {
                    map["sn"] = it
                }
                PageRouter.openPageByUrl(activity, "pay", map)
                activity.finish()
            }
            "toContactUsActivity" -> {
            }

        }
        return ""
    }
}