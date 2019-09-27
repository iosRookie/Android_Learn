package com.VideoEditor

import android.content.Context
import android.hardware.Camera
import android.util.AttributeSet
import android.util.Log
import android.view.SurfaceHolder
import android.view.SurfaceView
import java.io.IOException

class CameraSurfacePreview @JvmOverloads constructor(context: Context, attrs: AttributeSet? = null, defStyle: Int = 0):
        SurfaceView(context, attrs, defStyle), SurfaceHolder.Callback {
    private var mCamera: Camera? = null

    constructor(context: Context, mCamera: Camera) : this(context) {
        this.mCamera = mCamera
    }

    private val mHoler = holder

    init {
        mHoler.addCallback(this)
    }

    override fun surfaceCreated(holder: SurfaceHolder?) {
        try {
            mCamera?.setPreviewDisplay(holder)
            mCamera?.startPreview()
        } catch (e: IOException) {
            Log.d("CameraSurfacePreview", "Error start camera preview: ${e.message}")
        }
    }


    override fun surfaceChanged(holder: SurfaceHolder?, format: Int, width: Int, height: Int) {
        if (mHoler.surface == null) return
        
        try {
            mCamera?.stopPreview()
        } catch (e: Exception) {
            Log.d("CameraSurfacePreview", "Error stop camera preview: ${e.message}")
        }
    }

    override fun surfaceDestroyed(holder: SurfaceHolder?) {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

}