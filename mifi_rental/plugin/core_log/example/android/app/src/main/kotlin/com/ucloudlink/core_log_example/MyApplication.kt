package com.ucloudlink.core_log_example

import android.app.Application
import android.os.Environment
import com.ucloudlink.core_log.ULog
import io.flutter.view.FlutterMain
import java.io.File

/**
 * Author: 肖扬威
 * Date: 2020/3/3 15:31
 * Description:
 */
class MyApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        FlutterMain.startInitialization(this)
        ULog.builder()
                .filePath("${Environment.getExternalStorageDirectory().absolutePath}${File.separator}testLogs${File.separator}uilogs${File.separator}")
                .showThread(true).build(this)
    }
}