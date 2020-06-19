package com.ucloudlink.mifi_rental.pay

import android.app.Activity
import android.content.Intent
import android.graphics.Bitmap
import android.os.Build
import android.os.Bundle
import android.view.KeyEvent
import android.view.View
import android.webkit.*
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.ucloudlink.core_log.ULog
import com.ucloudlink.mifi_rental.MessageEvent
import com.ucloudlink.mifi_rental.R
import io.flutter.Log
import io.flutter.plugin.common.EventChannel
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe
import org.greenrobot.eventbus.ThreadMode
import wendu.dsbridge.DWebView
import java.util.*
//import com.idlefish.flutterboost.interfaces.IFlutterViewContainer.RESULT_KEY

//@Route(path = "/main/pay_native")
class PayActivity : AppCompatActivity() {
    var timer: Timer = Timer()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        supportActionBar?.hide()
        setContentView(R.layout.activity_pay)
        val dwebView = findViewById<View>(R.id.dwebview) as DWebView
        DWebView.setWebContentsDebuggingEnabled(true)
        val param: String = intent.getStringExtra("params")
        println("PayActivity param: $param")
        dwebView.addJavascriptObject(JSApi(param, this), null)
        dwebView.webChromeClient = object : WebChromeClient() {
            override fun onGeolocationPermissionsShowPrompt(origin: String, callback: GeolocationPermissions.Callback) { //动态请求访问位置权限后下，一般弹框让用户选择
                callback.invoke(origin, true, true)
                // callback.invoke(origin,false,false);
                super.onGeolocationPermissionsShowPrompt(origin, callback)
            }

            override fun onProgressChanged(view: WebView?, newProgress: Int) {
                super.onProgressChanged(view, newProgress)
                println("PayActivity $newProgress")
            }
        }
        dwebView.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView, request: WebResourceRequest): Boolean {
                return false
            }

            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                super.onPageStarted(view, url, favicon)
                println("onPageStarted: " + url)
            }
        }
        val settings = dwebView.settings
        settings.cacheMode = WebSettings.LOAD_CACHE_ELSE_NETWORK
        settings.domStorageEnabled = true
        settings.javaScriptEnabled = true
        settings.useWideViewPort = true
        settings.loadWithOverviewMode = true
        settings.cacheMode = WebSettings.LOAD_NO_CACHE
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            settings.mixedContentMode = WebSettings.MIXED_CONTENT_COMPATIBILITY_MODE
        }
        dwebView.loadUrl("https://saas82mph5.ukelink.net/pay/authPaypal")

        val task = object : TimerTask() {
            override fun run() {
                cancelOrder()
            }
        }
        timer.schedule(task, 1000 * 60 * 15)
        
    }

    override fun onDestroy() {
        super.onDestroy()
        timer.cancel()
    }

    fun cancelOrder() {
        // 取消订单
        EventBus.getDefault().post(MessageEvent("cancelOrder"))
        finish()
    }
    
    fun paySuccess() {
        // 支付成功
        ULog.d("支付成功")
        finish()
        EventBus.getDefault().post(MessageEvent("paySuccess"))
    }

    private fun showCancelDialog() {
        AlertDialog.Builder(this)
                .setTitle(R.string.tip)
                .setMessage(R.string.whether_cancel_payment)
                .setNegativeButton(R.string.cancel) { d, _ -> d.dismiss() }
                .setPositiveButton(R.string.confirm) { _, _ ->
                    cancelOrder()
                }
                .create().show()
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            showCancelDialog()
            return true
        }
        return super.onKeyDown(keyCode, event)
    }
}