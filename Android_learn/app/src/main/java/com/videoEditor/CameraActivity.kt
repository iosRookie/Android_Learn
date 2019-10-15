package com.videoEditor

import android.Manifest
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.camera2.Camera2Fragment
import com.example.myapplication.R
import com.tbruyelle.rxpermissions2.RxPermissions

class CameraActivity : AppCompatActivity() {
//    private var mPreview: CameraSurfacePreview? = null
    private val rxPermission = RxPermissions(this)
//    private var mCameraHelper: CameraHelper? = null
//
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        setContentView(R.layout.activity_camera)
//        mPreview = CameraSurfacePreview(this)
//        camera_preview_layout.addView(mPreview)
//        if (mPreview != null) {
//            mCameraHelper = CameraHelper(mPreview!!.holder, mPreview as View)
//        }
//
//        // 拍照
//        camera_take_picture.setOnClickListener {
//            rxPermission.request(Manifest.permission.WRITE_EXTERNAL_STORAGE).subscribe {
//                if (it) {
//                    mCameraHelper?.takePicture()
//                }
//            }
//        }
//
//        // 录像
//        camera_reocrd_video.setOnClickListener {
//            rxPermission.request(Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.RECORD_AUDIO).subscribe ({
//                if (it) {
//                    if (mCameraHelper?.videoRecord()!!) {
//                        camera_reocrd_video.text = this.resources.getText(R.string.stop_record)
//                    } else {
//                        camera_reocrd_video.text = this.resources.getText(R.string.record_video)
//                    }
//                }
//            }, {
//                Log.d("camera_record_video", it.message)
//                it.printStackTrace()
//            })
//        }
//
//        // 摄像头切换
//        change_facing.setOnClickListener {
//            when (mCameraHelper?.currentFacing) {
//                CameraHelper.BACK -> {
//                    mCameraHelper?.changeCameraFacing(CameraHelper.FRONT)
//                    change_facing.text = "FRONT"
//                }
//                CameraHelper.FRONT -> {
//                    mCameraHelper?.changeCameraFacing(CameraHelper.BACK)
//                    change_facing.text = "BACK"
//                }
//            }
//        }
//
//        // 闪光灯模式
//        flash.setOnClickListener {
//            val flashModes = arrayListOf("off", "auto", "on")
//            val cFlashMode = mCameraHelper?.getFlashMode()
//            if (flashModes.contains(cFlashMode)) {
//                val index = flashModes.indexOf(cFlashMode)
//                if (index + 1 >= flashModes.count()) {
//                    mCameraHelper?.setFlashMode(flashModes[0])
//                    flash.text = flashModes[0]
//                } else {
//                    mCameraHelper?.setFlashMode(flashModes[index + 1])
//                    flash.text = flashModes[index + 1]
//                }
//            }
//        }
//    }
//
//    override fun onPause() {
//        super.onPause()
//        Log.d("CameraActivity", "onPause")
//    }
//
//    override fun onDestroy() {
//        super.onDestroy()
//        mCameraHelper?.release()
//        Log.d("CameraActivity", "onDestroy")
//    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_camera)
        rxPermission.request(Manifest.permission.CAMERA, Manifest.permission.RECORD_AUDIO, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                .subscribe ({
                    if (!it) {
                        this.finish()
                    } else {
                        savedInstanceState ?:
                        supportFragmentManager
                                .beginTransaction()
                                .replace(R.id.container, Camera2Fragment.newInstance())
                                .commit()
                    }
                }, {
                    it.printStackTrace()
                }).dispose()

    }
}





























