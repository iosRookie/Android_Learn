package com.ucloudlink.mifi_rental

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.Vibrator
import android.view.View
import android.view.WindowManager
import androidx.appcompat.app.AppCompatActivity
import cn.bingoogolapple.qrcode.core.BarcodeType
import cn.bingoogolapple.qrcode.core.QRCodeView
import cn.bingoogolapple.qrcode.zxing.ZXingView
import com.idlefish.flutterboost.interfaces.IFlutterViewContainer.RESULT_KEY
import com.ucloudlink.core_log.ULog
import kotlin.collections.set


/**
 * Author: Create by kang.ning on 2018/7/12.
 * Email: kang.ning@ukelink.com
 * Description:
 */
class ScanActivity : AppCompatActivity(), QRCodeView.Delegate {
    private var mZXingView: ZXingView? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        supportActionBar!!.hide()
        window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
        setContentView(R.layout.activity_scan)
        mZXingView = findViewById(R.id.zxingview)
        mZXingView?.setDelegate(this)
        mZXingView?.setType(BarcodeType.HIGH_FREQUENCY, null)

//        ActivityCompat.requestPermissions(this, arrayOf(
//                Manifest.permission.WRITE_EXTERNAL_STORAGE,
//                Manifest.permission.READ_PHONE_STATE,
//                Manifest.permission.READ_EXTERNAL_STORAGE,
//                Manifest.permission.CAMERA), 0)
    }

    override fun onStart() {
        mZXingView?.startCamera() // 打开后置摄像头开始预览，但是并未开始识别
        //        mZXingView.startCamera(Camera.CameraInfo.CAMERA_FACING_FRONT); // 打开前置摄像头开始预览，但是并未开始识别
        mZXingView?.startSpotAndShowRect() // 显示扫描框，并且延迟0.5秒后开始识别
        super.onStart()
    }

    override fun onStop() {
        mZXingView?.stopCamera() // 关闭摄像头预览，并且隐藏扫描框
        super.onStop()
    }

    override fun onDestroy() {
        mZXingView?.onDestroy() // 销毁二维码扫描控件
        super.onDestroy()
    }

    private fun vibrate() {
        val vibrator = (getSystemService(Context.VIBRATOR_SERVICE) as Vibrator)
        vibrator.vibrate(200)
    }

    override fun onScanQRCodeSuccess(result: String) {
        ULog.d("onScanQRCodeSuccess: $result")
        vibrate()
        val map = HashMap<String, Any>()
        map["content"] = result
        val intent = Intent()
        intent.putExtra(RESULT_KEY, map)
        setResult(Activity.RESULT_OK, intent)

        finish()
    }

    override fun onScanQRCodeOpenCameraError() {
        ULog.d("onScanQRCodeOpenCameraError")
    }

    companion object {
        private const val TAG = "ScanActivity"
    }

    fun back(view: View) {
        finish()
    }
}