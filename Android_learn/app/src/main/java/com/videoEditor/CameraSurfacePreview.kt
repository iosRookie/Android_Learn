package com.videoEditor

import android.app.Activity
import android.content.Context
import android.content.ContextWrapper
import android.hardware.Camera
import android.media.CamcorderProfile
import android.media.MediaRecorder
import android.util.AttributeSet
import android.util.Log
import android.view.SurfaceHolder
import android.view.SurfaceView
import java.io.IOException
import android.provider.MediaStore.Files.FileColumns.MEDIA_TYPE_IMAGE
import android.os.Environment
import android.provider.MediaStore.Files.FileColumns.MEDIA_TYPE_VIDEO
import android.view.Surface
import android.view.View
import java.io.File
import java.io.FileNotFoundException
import java.io.FileOutputStream
import java.text.SimpleDateFormat
import java.util.*


class CameraSurfacePreview @JvmOverloads constructor(context: Context, attrs: AttributeSet? = null, defStyle: Int = 0):
        SurfaceView(context, attrs, defStyle) {
//    private var mCamera: Camera? = null
//    private var mCameraHelper: CameraHelper? = null




//    private val mHolder = holder

    init {
//        mHolder.addCallback(this)
//        mCameraHelper = CameraHelper(holder, this)
//        mCamera = getCameraInstance()
//        getActivityFromView(this)?.let {
//            setCameraDisplayOrientation(it, Camera.CameraInfo.CAMERA_FACING_BACK, mCamera!!)
//        }
    }

//    fun stopCameraPreView() {
//        mCameraHelper?.stopCamera()
//    }

//    override fun surfaceCreated(holder: SurfaceHolder?) {
//        try {
//            mCamera?.setPreviewDisplay(holder)
//            mCamera?.startPreview()
//        } catch (e: IOException) {
//            Log.d("CameraSurfacePreview", "Error start camera preview: ${e.message}")
//        }
//    }

//    override fun surfaceChanged(holder: SurfaceHolder?, format: Int, width: Int, height: Int) {
//        if (mHolder.surface == null) return
//
//        val sizes = mCamera?.parameters?.supportedPreviewSizes
//        val preViewSize = mCamera?.Size(720, 1080)
//        sizes?.let {
//            if (preViewSize != null && it.contains(preViewSize)) {
//                mCamera?.parameters?.setPreviewSize(preViewSize.width, preViewSize.height)
//            }
//        }
//        try {
//            mCamera?.stopPreview()
//        } catch (e: Exception) {
//            Log.d("CameraSurfacePreview", "Error stop camera preview: ${e.message}")
//        }
//
//        try {
//            mCamera?.setPreviewDisplay(holder)
//            mCamera?.startPreview()
//        } catch (e: IOException) {
//            Log.d("CameraSurfacePreview", "Error start camera preview: ${e.message}")
//        }
//    }

//    override fun surfaceDestroyed(holder: SurfaceHolder?) {
//
//    }


//    companion object {
//        private fun getActivityFromView(view: View?): Activity? {
//            if (null != view) {
//                var context = view.context
//                while (context is ContextWrapper) {
//                    if (context is Activity) {
//                        return context
//                    }
//                    context = context.baseContext
//                }
//            }
//            return null
//        }
//
//        fun getCameraInstance(): Camera? {
//            return try {
////                var cameraID = -1
////                val cameraInfo: Camera.CameraInfo = Camera.CameraInfo()
////                val count = Camera.getNumberOfCameras()
////                for (i in 0..count) {
////                    Camera.getCameraInfo(i, cameraInfo)
////                    when (cameraInfo.facing) {
////                        Camera.CameraInfo.CAMERA_FACING_BACK -> {
////                            cameraID = i
////                        }
////                        Camera.CameraInfo.CAMERA_FACING_FRONT -> {
////                            cameraID = i
////                        }
////                    }
////                }
//                Camera.open()
//            } catch (e: java.lang.Exception) {
//                null
//            }
//        }
//
//        fun setCameraDisplayOrientation(activity: Activity, cameraId: Int, camera: Camera) {
//            val info = Camera.CameraInfo()
//            Camera.getCameraInfo(cameraId, info)
//            val rotation = activity.windowManager.defaultDisplay.rotation
//            var surfaceDegress = 0
//            when (rotation) {
//                Surface.ROTATION_0 -> surfaceDegress = 0
//                Surface.ROTATION_90 -> surfaceDegress = 90
//                Surface.ROTATION_180 -> surfaceDegress = 180
//                Surface.ROTATION_270 -> surfaceDegress = 270
//            }
//            var result: Int
//            if (info.facing == Camera.CameraInfo.CAMERA_FACING_FRONT) {
//                result = (info.orientation + surfaceDegress) % 360
//                result = (360 - result) % 360
//            } else {
//                result = (info.orientation - surfaceDegress + 360) % 360
//            }
//            camera.setDisplayOrientation(result)
//        }
//
//         fun getOutputMediaFile(type: Int): File? {
//            val mediaStorageDir = File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES), "Android_learn")
//            if (!mediaStorageDir.exists()) {
//                if (!mediaStorageDir.mkdirs()) {
//                    Log.d("getOutputMediaFile", "failed to create directory")
//                    return null
//                }
//            }
//
//            val timeStamp = SimpleDateFormat("yyyyMMdd_HHmmss", Locale("", "cn")).format(Date())
//
//            return when (type) {
//                MEDIA_TYPE_IMAGE -> {
//                    File(mediaStorageDir.path + File.separator + "IMG_" + timeStamp + ".jpg")
//                }
//                MEDIA_TYPE_VIDEO -> {
//                    File(mediaStorageDir.path + File.separator + "VID_" + timeStamp + ".mp4")
//                }
//                else -> return null
//            }
//        }
//    }
//
//    fun takePicture() {
//        mCameraHelper?.takePicture()
//    }
//
//    fun videoRecord(): Boolean {
//        return mCameraHelper?.videoRecord()!!
//    }
//
//    private fun releaseMediaRecorder() {
//        mMediaRecorder.reset()    // clear recorder configuration
//        mMediaRecorder.release()  // release the recorder object
//        mCamera?.lock()           // lock camera for later use
//    }
//
//    fun release() {
//        releaseMediaRecorder()
//        mCamera?.stopPreview()
//        mCamera?.setPreviewCallback(null)
//        mCamera?.release()
//    }
}