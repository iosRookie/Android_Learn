package com.ucloudlink.mifi_rental

import android.app.Application
//import com.idlefish.flutterboost.FlutterBoost
//import com.idlefish.flutterboost.Utils
//import com.idlefish.flutterboost.interfaces.INativeRouter
import com.ucloudlink.core_log.ULog
import io.flutter.embedding.android.FlutterView
import java.io.File

/**
 * Author: 肖扬威
 * Date: 2020/3/3 10:59
 * Description:
 */
class MyApplication : Application() {
    companion object {
        private var app: MyApplication? = null
        fun getInstance(): MyApplication? {
            return app
        }
    }

    override fun onCreate() {
        super.onCreate()
        app = this
        ULog.builder()
                .filePath("${getExternalFilesDir(null)?.absolutePath}${File.separator}logs${File.separator}")
                .showThread(true)
                .build(this)

//        val router = INativeRouter { context, url, urlParams, requestCode, exts ->
//            val assembleUrl = Utils.assembleUrl(url, urlParams)
////            PageRouter.openPageByUrl(context, assembleUrl, urlParams)
//            Router.openPageByUrl(context, assembleUrl, urlParams, exts = exts)
//        }
//        val boostLifecycleListener = object : FlutterBoost.BoostLifecycleListener {
//
//            override fun beforeCreateEngine() {
//
//            }
//
//            override fun onEngineCreated() {
//
//            }
//
//            override fun onPluginsRegistered() {
//
//            }
//
//            override fun onEngineDestroy() {
//
//            }
//
//        }
//
//        val platform = FlutterBoost.ConfigBuilder(this, router)
//                .isDebug(true)
//                .whenEngineStart(FlutterBoost.ConfigBuilder.ANY_ACTIVITY_CREATED)
//                .renderMode(FlutterView.RenderMode.texture)
//                .lifecycleListener(boostLifecycleListener)
//                .build()
//        FlutterBoost.instance().init(platform)
    }
}