package com.UILearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.webkit.WebView
import android.webkit.WebViewClient
import com.example.myapplication.R
import com.tbruyelle.rxpermissions2.RxPermissions
import java.util.*
import java.util.jar.Manifest

class WebViewActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_web_view)

        RxPermissions(this).request(android.Manifest.permission.CAMERA).subscribe({
            if (it == true) {

            } else {

            }
        },{

        }).dispose()
        val webView = findViewById<WebView>(R.id.webView)
        webView.settings.javaScriptEnabled = true
        webView.webViewClient = WebViewClient()
        webView.loadUrl("http://www.baidu.com")
    }
}
