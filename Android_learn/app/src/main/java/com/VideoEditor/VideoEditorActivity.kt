package com.VideoEditor

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.graphics.Bitmap
import android.os.Bundle
import android.provider.MediaStore
import android.widget.Toast
import com.example.myapplication.R
import com.tbruyelle.rxpermissions2.RxPermissions
import kotlinx.android.synthetic.main.activity_video_editor.*

class VideoEditorActivity : BaseActivity() {
    private val REQUEST_IMAGE_CAPTURE = 1
    private val REQUEST_VIDEO_CAPTURE = 2

    private val rxPermission = RxPermissions(this)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_video_editor)

        // 视频录制
        record_btn.setOnClickListener {

        }

        // 选择系统资源
        select_dtn.setOnClickListener {

        }

        take_picture.setOnClickListener {
            cameraPermission {
                if (it) {
                    dispatchTakePictureIntent()
                }
            }
        }

        take_video.setOnClickListener {
            cameraPermission {
                if (it) {
                    dispatchTakeVideoIntent()
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == REQUEST_IMAGE_CAPTURE && resultCode == Activity.RESULT_OK) {
            val extras = data?.extras
            val imageBitmap = extras?.get("data") as Bitmap
            picture_image.setImageBitmap(imageBitmap)
        }

        if (requestCode == REQUEST_VIDEO_CAPTURE && resultCode == Activity.RESULT_OK) {
            val videoUri = data?.data
        }
    }

    // camera权限
    private fun cameraPermission(callBack:(granted:Boolean) -> Unit) {
        rxPermission.requestEach(Manifest.permission.CAMERA).subscribe {
            if (it.granted) {
                // 已授权
                callBack(true)
            } else {
                // 未授权
                if (!it.shouldShowRequestPermissionRationale) {
                    Toast.makeText(this, "请先开启camera权限", Toast.LENGTH_SHORT).show()
                }
                callBack(false)
            }
        }.dispose()
    }

    // 系统拍照
    private fun dispatchTakePictureIntent() {
        val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
        if (intent.resolveActivity(packageManager) != null) {
            startActivityForResult(intent, REQUEST_IMAGE_CAPTURE)
        }
    }

    // 系统录制视频
    private fun dispatchTakeVideoIntent() {
        val intent = Intent(MediaStore.ACTION_VIDEO_CAPTURE)
        if (intent.resolveActivity(packageManager) != null) {
            startActivityForResult(intent, REQUEST_VIDEO_CAPTURE)
        }
    }


}
