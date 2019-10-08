package com.VideoEditor

import android.Manifest
import android.app.Activity
import android.hardware.Camera
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.Surface
import com.example.myapplication.R
import com.tbruyelle.rxpermissions2.RxPermissions
import kotlinx.android.synthetic.main.activity_camera.*
import java.lang.Exception

class CameraActivity : AppCompatActivity() {
//    private var mCamera: Camera? = null
    private var mPreview: CameraSurfacePreview? = null
    private val rxPermission = RxPermissions(this)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_camera)

//        mCamera = getCameraInstance()
//        mCamera?.let {
//            setCameraDisplayOrientation(this, Camera.CameraInfo.CAMERA_FACING_BACK, it)
//        }
//        val params = mCamera?.parameters
//        params?.supportedFocusModes

//        mPreview = CameraSurfacePreview(this, mCamera!!)

        mPreview = CameraSurfacePreview(this)
        camera_preview_layout.addView(mPreview)

        // 拍照
        camera_take_picture.setOnClickListener {
            rxPermission.request(Manifest.permission.WRITE_EXTERNAL_STORAGE).subscribe {
                if (it) {
                    mPreview?.takePicture()
                }
            }
        }

        // 录像
        camera_reocrd_video.setOnClickListener {
            rxPermission.request(Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.RECORD_AUDIO).subscribe ({
                if (it) {
                    if (mPreview?.videoRecord()!!) {
                        camera_reocrd_video.text = this.resources.getText(R.string.stop_record)
                    } else {
                        camera_reocrd_video.text = this.resources.getText(R.string.record_video)
                    }
                }
            }, {
                Log.d("camera_record_video", it.message)
                it.printStackTrace()
            })
        }
    }

    override fun onPause() {
        super.onPause()

        mPreview?.release()
//        mCamera?.stopPreview()
//        mCamera?.setPreviewCallback(null)
//        mCamera?.release()
        Log.d("CameraActivity", "onPause")
    }

    override fun onDestroy() {
        super.onDestroy()

        Log.d("CameraActivity", "onDestroy")
    }
}
