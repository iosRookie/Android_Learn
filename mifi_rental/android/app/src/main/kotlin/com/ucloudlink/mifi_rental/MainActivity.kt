package com.ucloudlink.mifi_rental

import android.os.Bundle
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val params = HashMap<String,String>()
        params["test1"] = "v_test1"
        params["test2"] = "v_test2"
        PageRouter.openPageByUrl(this, "rent", params)
        finish()
    }
}