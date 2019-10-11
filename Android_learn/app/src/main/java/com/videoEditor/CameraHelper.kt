package com.videoEditor

import android.app.Activity
import android.content.ContextWrapper
import android.hardware.Camera
import android.hardware.Camera.CameraInfo.CAMERA_FACING_BACK
import android.hardware.Camera.CameraInfo.CAMERA_FACING_FRONT
import android.hardware.Camera.Parameters.FOCUS_MODE_CONTINUOUS_VIDEO
import android.media.CamcorderProfile
import android.media.MediaRecorder
import android.os.Environment
import java.text.SimpleDateFormat
import android.provider.MediaStore.Files.FileColumns.MEDIA_TYPE_IMAGE
import android.provider.MediaStore.Files.FileColumns.MEDIA_TYPE_VIDEO
import android.util.Log
import android.view.Surface
import android.view.SurfaceHolder
import android.view.View
import jp.co.cyberagent.android.gpuimage.GPUImageNativeLibrary
import java.io.File
import java.io.FileNotFoundException
import java.io.FileOutputStream
import java.io.IOException
import java.util.*

class CameraHelper(private var mHolder: SurfaceHolder, private val displayView: View) : SurfaceHolder.Callback, Camera.PictureCallback, Camera.PreviewCallback {
    var mCamera: Camera? = null
        private set

    private var mMediaRecorder = MediaRecorder()
    private var isRecording = false
    var currentFacing: Int = CAMERA_FACING_BACK

    init {
        mHolder.addCallback(this)
        openCamera(currentFacing)
    }

    fun openCamera(facing: Int): Boolean {
        return try {
            val cameraInfo: Camera.CameraInfo = Camera.CameraInfo()
            val count = Camera.getNumberOfCameras()
            for (i in 0..count) {
                Camera.getCameraInfo(i, cameraInfo)
                if (cameraInfo.facing == facing) {
                    mCamera = Camera.open(i)
                    setAutoFocus()
                    currentFacing = i
                    break
                }
            }
            mCamera?.setPreviewCallback(this)
            setCameraDisplayOrientation(displayView)
            true
        } catch (e: java.lang.Exception) {
            mCamera = null
            false
        }
    }

    fun changeCameraFacing(facing: Int): Boolean {
        if (mCamera != null) {
            mCamera?.stopPreview()
            mCamera?.setPreviewCallback(null)
            mCamera?.release()
        }
        try {
            when (facing) {
                CAMERA_FACING_BACK -> {
                    mCamera = Camera.open(facing)
                    setAutoFocus()
                }

                CAMERA_FACING_FRONT -> {
                    mCamera = Camera.open(facing)
                    setAutoFocus()
                }
            }
            currentFacing = facing
            setCameraDisplayOrientation(displayView)

            mCamera?.setPreviewDisplay(mHolder)
            mCamera?.setPreviewCallback(this)
            mCamera?.startPreview()

            return true
        } catch (e: java.lang.Exception) {
            mCamera = null
            return false
        }
    }

    private fun setCameraDisplayOrientation(view: View) {
        if (mCamera != null) {
            getActivityFromView(view)?.let {
                setCameraDisplayOrientation(it, currentFacing, mCamera!!)
            }
        }
    }

    // SurfaceHolder.Callback
    override fun surfaceCreated(holder: SurfaceHolder?) {
        try {
            mCamera?.setPreviewDisplay(holder)
            mCamera?.startPreview()
        } catch (e: IOException) {
            Log.d("CameraSurfacePreview", "Error start camera preview: ${e.message}")
        }
    }

    override fun surfaceChanged(holder: SurfaceHolder?, format: Int, width: Int, height: Int) {
        if (mHolder.surface == null) return

        val sizes = mCamera?.parameters?.supportedPreviewSizes
        val preViewSize = mCamera?.Size(720, 1080)
        sizes?.let {
            if (preViewSize != null && it.contains(preViewSize)) {
                mCamera?.parameters?.setPreviewSize(preViewSize.width, preViewSize.height)
            }
        }
        try {
            mCamera?.stopPreview()
        } catch (e: Exception) {
            Log.d("CameraSurfacePreview", "Error stop camera preview: ${e.message}")
        }

        try {
            mCamera?.setPreviewDisplay(holder)
            mCamera?.startPreview()
        } catch (e: IOException) {
            Log.d("CameraSurfacePreview", "Error start camera preview: ${e.message}")
        }
    }

    override fun surfaceDestroyed(holder: SurfaceHolder?) {

    }

    // Camera.PictureCallback
    // 拍照回调，保存照片
    override fun onPictureTaken(data: ByteArray?, camera: Camera?) {
        val pictureFile = getOutputMediaFile(MEDIA_TYPE_IMAGE)
        if (pictureFile == null) {
            Log.d("onPictureTaken", "Error creating media file, checkout storage permission")
            return
        }

        try {
            val outputStream = FileOutputStream(pictureFile)
            outputStream.write(data)
            outputStream.close()
        } catch (e: FileNotFoundException) {
            Log.d("onPictureTaken", e.message)
        } catch (e: IOException) {
            Log.d("onPictureTaken", e.message)
        }

        camera?.startPreview()
    }

    override fun onPreviewFrame(data: ByteArray?, camera: Camera?) {

    }

    private fun prepareVideoRecorder(): Boolean {
        if (mCamera == null) return false

        // Step 1: Unlock and set camera to MediaRecorder
        mCamera?.unlock()
        mMediaRecorder.setCamera(mCamera)
        // Step 2: Set sources
        try {
            mMediaRecorder.setAudioSource(MediaRecorder.AudioSource.CAMCORDER)
        } catch (e: IllegalStateException) {
            Log.d("prepareVideoRecorder", e.message)
        }

        try {
            mMediaRecorder.setVideoSource(MediaRecorder.VideoSource.CAMERA)
        } catch (e: IllegalStateException) {
            Log.d("prepareVideoRecorder", e.message)
        }

        // Step 3: Set a CamcorderProfile (requires API Level 8 or higher)
        mMediaRecorder.setProfile(CamcorderProfile.get(CamcorderProfile.QUALITY_720P))
//        try {
//            mMediaRecorder.setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)
//        } catch (e: IllegalStateException) {
//            Log.d("setOutputFormat", e.message)
//            e.printStackTrace()
//        }
//        mMediaRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.DEFAULT)
//        mMediaRecorder.setVideoEncoder(MediaRecorder.VideoEncoder.DEFAULT)

        // Step 4: Set output file
        mMediaRecorder.setOutputFile(getOutputMediaFile(MEDIA_TYPE_VIDEO).toString())
        // Step 5: Set the preview output
        mMediaRecorder.setPreviewDisplay(mHolder.surface)
        // Step 6: Prepare configured MediaRecorder
        try {
            mMediaRecorder.prepare()
        } catch (e: IllegalStateException) {
            Log.d("prepareVideoRecorder", "IllegalStateException preparing MediaRecorder: " + e.message)
            releaseMediaRecorder()
            return false
        } catch (e: IOException) {
            Log.d("prepareVideoRecorder", "IOException preparing MediaRecorder: " + e.message)
            releaseMediaRecorder()
            return false
        }

        return true
    }

    // 拍照
    fun takePicture() {
        mCamera?.takePicture(null, null, this)
    }

    // 录视频
    fun videoRecord(): Boolean {
        if (!isRecording) {
            // 录制
            if (prepareVideoRecorder()) {
                isRecording = try {
                    mMediaRecorder.start()
                    true
                } catch (e: IllegalStateException) {
                    Log.d("videoRecord", e.message)
                    false
                }
            }
        } else {
            // 停止录制
            isRecording = try {
                mMediaRecorder.stop()
                mCamera?.lock()
                false
            } catch (e: IllegalStateException) {
                Log.d("videoRecord", e.message)
                true
            }
        }

        return isRecording
    }

    private fun releaseMediaRecorder() {
        mMediaRecorder.reset()    // clear recorder configuration
        mMediaRecorder.release()  // release the recorder object
        mCamera?.lock()           // lock camera for later use
    }

    fun release() {
        releaseMediaRecorder()
        mCamera?.stopPreview()
        mCamera?.setPreviewCallback(null)
        mCamera?.release()
    }


    companion object {
        const val BACK = CAMERA_FACING_BACK
        const val FRONT = CAMERA_FACING_FRONT

        fun setCameraDisplayOrientation(activity: Activity, cameraId: Int, camera: Camera) {
            val info = Camera.CameraInfo()
            Camera.getCameraInfo(cameraId, info)
            val rotation = activity.windowManager.defaultDisplay.rotation
            var surfaceDegress = 0
            when (rotation) {
                Surface.ROTATION_0 -> surfaceDegress = 0
                Surface.ROTATION_90 -> surfaceDegress = 90
                Surface.ROTATION_180 -> surfaceDegress = 180
                Surface.ROTATION_270 -> surfaceDegress = 270
            }
            var result: Int
            if (info.facing == Camera.CameraInfo.CAMERA_FACING_FRONT) {
                result = (info.orientation + surfaceDegress) % 360
                result = (360 - result) % 360
            } else {
                result = (info.orientation - surfaceDegress + 360) % 360
            }
            camera.setDisplayOrientation(result)
        }

        private fun getActivityFromView(view: View?): Activity? {
            if (null != view) {
                var context = view.context
                while (context is ContextWrapper) {
                    if (context is Activity) {
                        return context
                    }
                    context = context.baseContext
                }
            }
            return null
        }

        fun getOutputMediaFile(type: Int): File? {
            val mediaStorageDir = File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES), "Android_learn")
            if (!mediaStorageDir.exists()) {
                if (!mediaStorageDir.mkdirs()) {
                    Log.d("getOutputMediaFile", "failed to create directory")
                    return null
                }
            }

            val timeStamp = SimpleDateFormat("yyyyMMdd_HHmmss", Locale("", "cn")).format(Date())

            return when (type) {
                MEDIA_TYPE_IMAGE -> {
                    File(mediaStorageDir.path + File.separator + "IMG_" + timeStamp + ".jpg")
                }
                MEDIA_TYPE_VIDEO -> {
                    File(mediaStorageDir.path + File.separator + "VID_" + timeStamp + ".mp4")
                }
                else -> return null
            }
        }
    }
}

// 闪光灯
fun CameraHelper.setFlashMode(value: String) {
    var parameters = mCamera?.parameters
    val supportFlashModes = mCamera?.parameters?.supportedFlashModes
    if (supportFlashModes?.contains(value)!!) {
        parameters?.flashMode = value
    }
    mCamera?.parameters = parameters
}

fun CameraHelper.getFlashMode(): String {
    return mCamera?.parameters?.flashMode.toString()
}

// 对焦
// FOCUS_MODE_AUTO 自动对焦
// FOCUS_MODE_INFINITY 无穷远
// FOCUS_MODE_MACRO 微距拍摄
// FOCUS_MODE_FIXED 固定对焦
// FOCUS_MODE_EDOF 扩展景深
// FOCUS_MODE_CONTINUOUS_PICTURE
// FOCUS_MODE_CONTINUOUS_VIDEO 视频记录的连续自动对焦
fun CameraHelper.setAutoFocus() {
    var parameters = mCamera?.parameters
    val sFocusModes = mCamera?.parameters?.supportedFocusModes
    parameters?.focusMode = FOCUS_MODE_CONTINUOUS_VIDEO
    mCamera?.parameters = parameters
}