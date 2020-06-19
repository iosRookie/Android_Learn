package com.ucloudlink.mifi_rental

import android.app.Activity
import android.content.Context
import android.content.Intent
//import com.idlefish.flutterboost.containers.BoostFlutterActivity
import com.ucloudlink.core_log.ULog
import com.ucloudlink.mifi_rental.pay.PayActivity

object Router {

    @JvmOverloads
    fun openPageByUrl(context: Context, url: String, params: Map<*, *>?, requestCode: Int = 0, exts: Map<*, *>? = null) {
        ULog.i("url:$url")
        val path = url.split("\\?".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()[0].let {
            it.substring(it.indexOf("//") + 2, it.length)
        }
        val clearTask = exts?.let {
            it["clearTask"]
        }
        if (url.startsWith("flutter")) {
//            val intent = BoostFlutterActivity.NewEngineIntentBuilder(FActivity::class.java).url(path).params(params
//                    ?: HashMap<String, String>())
//                    .backgroundMode(BoostFlutterActivity.BackgroundMode.opaque).build(context)
//            if (clearTask == true) {
//                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK or Intent.FLAG_ACTIVITY_NEW_TASK)
//            }
//            if (context is Activity) {
//                context.startActivityForResult(intent, requestCode)
//            } else {
//                context.startActivity(intent)
//            }
        } else if (url.startsWith("native")) {

            getClass(path)?.let {
                val intent = Intent(context, it)
                if (clearTask == true) {
                    intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK or Intent.FLAG_ACTIVITY_NEW_TASK)
                }
                params?.let {
                    for (entry in it) {
                        when {
                            entry.value is String -> intent.putExtra(entry.key.toString(), entry.value as String)
                            entry.value is Int -> intent.putExtra(entry.key.toString(), entry.value as Int)
                            entry.value is Long -> intent.putExtra(entry.key.toString(), entry.value as Long)
                            entry.value is Float -> intent.putExtra(entry.key.toString(), entry.value as Float)
                            entry.value is Double -> intent.putExtra(entry.key.toString(), entry.value as Double)
                        }
                    }
                }
                if (context is Activity) {
                    context.startActivityForResult(intent, 1)
                } else {
                    context.startActivity(intent)
                }
            }

//            val bundle = Bundle()
//            params?.let {
//                for (entry in it) {
//                    when {
//                        entry.value is String -> bundle.putString(entry.key.toString(), entry.value as String)
//                        entry.value is Int -> bundle.putInt(entry.key.toString(), entry.value as Int)
//                        entry.value is Long -> bundle.putLong(entry.key.toString(), entry.value as Long)
//                        entry.value is Float -> bundle.putFloat(entry.key.toString(), entry.value as Float)
//                        entry.value is Double -> bundle.putDouble(entry.key.toString(), entry.value as Double)
//                    }
//                }
//            }
//            val p = ARouter.getInstance().build("/main/$path").with(bundle)
//            if (clearTask == true) {
//                p.withFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK or Intent.FLAG_ACTIVITY_NEW_TASK)
//            }
//            if (context is Activity) {
//                p.navigation(context, 1)
//            } else {
//                p.navigation()
//            }

        }
    }

    private fun getClass(path: String): Class<*>? {
        return when (path) {
            "scan" -> ScanActivity::class.java
            "pay_native" -> PayActivity::class.java
            else -> null
        }
    }
}