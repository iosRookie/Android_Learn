package com.ucloudlink.mifi_rental

import android.content.Intent
import android.os.Bundle
import androidx.annotation.NonNull
import com.ucloudlink.mifi_rental.pay.PayActivity
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe
import org.greenrobot.eventbus.ThreadMode
import org.json.JSONObject


class MainActivity : FlutterActivity() {
    var eventSink: EventSink? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor,"com.uklink.common/methodChannel").setMethodCallHandler { call, result ->
            if (call.method == "payWebPage") {
                val intent = Intent(this.context, PayActivity::class.java)
                val json = JSONObject()
                (call.arguments as Map<*, *>?)?.forEach {
                    if ("__container_uniqueId_key__" != it.key) {
                        if (it.key == "terminalSn") {
                            intent.putExtra("terminalSn", it.value as String)
                        } else {
                            json.put(it.key as String, it.value as String)
                        }
                    }
                }
                intent.putExtra("params", json.toString())
                this.context.startActivity(intent)
            } else {
                result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor, "com.uklink.common/eventChannel").setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventSink?) {
                        eventSink = events
                    }

                    override fun onCancel(arguments: Any?) {

                    }
                }
        )
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 注册
        EventBus.getDefault().register(this)
    }

    override fun onDestroy() {
        super.onDestroy()

        // 反注册
        EventBus.getDefault().unregister(this)
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    fun handlerEvent(messageEvent: MessageEvent) {
        Log.d("PayActivity", "${messageEvent.getMessage()}")
        eventSink?.success("${messageEvent.getMessage()}")
    }
}