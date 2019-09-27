package com.VideoEditor

import android.hardware.Camera
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.example.myapplication.R
import kotlinx.android.synthetic.main.activity_camera.*
import java.lang.Exception

class CameraActivity : AppCompatActivity() {
    private val mCamera = getCameraInstance()
    private val mPreview: CameraSurfacePreview = CameraSurfacePreview(this, mCamera!!)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_camera)

        camera_preview_layout.addView(mPreview)
    }

    companion object {
        fun getCameraInstance(): Camera? {
            return try {
                Camera.open()
            } catch (e: Exception) {
                null
            }
        }
    }
}
