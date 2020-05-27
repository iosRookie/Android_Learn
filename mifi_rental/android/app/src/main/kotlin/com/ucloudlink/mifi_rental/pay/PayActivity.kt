package com.ucloudlink.mifi_rental.pay

import android.graphics.Bitmap
import android.os.Build
import android.os.Bundle
import android.view.KeyEvent
import android.view.View
import android.webkit.*
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.ucloudlink.mifi_rental.PageRouter
import com.ucloudlink.mifi_rental.R
import wendu.dsbridge.DWebView

class PayActivity : AppCompatActivity() {
    var terminalSn: String? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        supportActionBar?.hide()
        setContentView(R.layout.activity_pay)
        val dwebView = findViewById<View>(R.id.dwebview) as DWebView
        DWebView.setWebContentsDebuggingEnabled(true)
        val param: String = intent.getStringExtra("params")
        terminalSn = intent.getStringExtra("terminalSn")
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
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            settings.mixedContentMode = WebSettings.MIXED_CONTENT_COMPATIBILITY_MODE
        }
        dwebView.loadUrl("https://saas82mph5.ukelink.net/pay/authPaypal")
    }

    private fun showCancelDialog() {
        AlertDialog.Builder(this)
                .setTitle(R.string.tip)
                .setMessage(R.string.whether_cancel_payment)
                .setNegativeButton(R.string.cancel) { d, _ -> d.dismiss() }
                .setPositiveButton(R.string.confirm) { _, _ ->
                    val map = HashMap<String, String>()
                    terminalSn?.let {
                        map["sn"] = it
                    }
                    PageRouter.openPageByUrl(this, "pay", map)
                    finish()
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