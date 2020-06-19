package com.ucloudlink.mifi_rental

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
//import com.idlefish.flutterboost.containers.BoostFlutterActivity
import com.ucloudlink.mifi_rental.pay.PayActivity
import org.json.JSONObject

/**
 * Author: 肖扬威
 * Date: 2020/3/6 14:58
 * Description:
 */
object PageRouter {
    val pageName: Map<String, String> = object : HashMap<String, String>() {
        init {
            put("first", "first")
            put("second", "second")
            put("rent", "rent")
            put("pay", "pay")
            put("problem", "problem")
            put("device", "device")
            put("fault_report", "fault_report")
            put("sample://flutterPage", "flutterPage")
            put("rent_fail", "rent_fail")
            put("flow_package", "flow_package")
            put("success", "success")
            put("query", "query")

            put("pay_fail", "pay_fail")
        }
    }

    val NATIVE_PAGE_URL = "sample://nativePage"
    val FLUTTER_PAGE_URL = "sample://flutterPage"
    val FLUTTER_FRAGMENT_PAGE_URL = "sample://flutterFragmentPage"

    @JvmOverloads
    fun openPageByUrl(context: Context, url: String, params: Map<*, *>?, requestCode: Int = 0): Boolean {
        val path = url.split("\\?".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()[0]

        Log.i("openPageByUrl", path)

        try {
            if (pageName.containsKey(path)) {
//                val intent = BoostFlutterActivity.withNewEngine().url(pageName[path]!!).params(params
//                        ?: HashMap<String, String>())
//                        .backgroundMode(BoostFlutterActivity.BackgroundMode.opaque).build(context)
//                if (context is Activity) {
//                    context.startActivityForResult(intent, requestCode)
//                } else {
//                    context.startActivity(intent)
//                }
                return true
            } else if (url.startsWith(FLUTTER_FRAGMENT_PAGE_URL)) {
                //                context.startActivity(new Intent(context, FlutterFragmentPageActivity.class));
                return true
            } else if (url.startsWith(NATIVE_PAGE_URL)) {
                //                context.startActivity(new Intent(context, NativePageActivity.class));
                return true
            } else if (url.startsWith("native")) {
                if (context is Activity) {
                    context.startActivityForResult(Intent(context, NativeActivity::class.java), requestCode)
                }
                return true
            } else if (url.startsWith("scan")) {
                if (context is Activity) {
                    context.startActivityForResult(Intent(context, ScanActivity::class.java), requestCode)
                }
            } else if (url.startsWith("pay_native")) {
                if (context is Activity) {
                    val intent = Intent(context, PayActivity::class.java)
                    val json = JSONObject()
                    params?.forEach {
                        if ("__container_uniqueId_key__" != it.key) {
                            if (it.key == "terminalSn") {
                                intent.putExtra("terminalSn", it.value as String)
                            } else {
                                json.put(it.key as String, it.value as String)
                            }

                        }
                    }
                    intent.putExtra("params", json.toString())
                    context.startActivityForResult(intent, requestCode)
                }
            }
            return false

        } catch (t: Throwable) {
            return false
        }

    }
}