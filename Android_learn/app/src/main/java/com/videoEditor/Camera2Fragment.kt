package com.videoEditor

import android.graphics.SurfaceTexture
import android.hardware.camera2.*
import android.media.ImageReader
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.HandlerThread
import android.support.annotation.RequiresApi
import android.support.v4.app.Fragment
import android.util.Log
import android.util.Size
import android.util.SparseIntArray
import android.view.*
import android.widget.Toast
import java.io.File
import java.util.*
import java.util.concurrent.Semaphore
import kotlin.collections.ArrayList
import kotlin.math.sign

@RequiresApi(Build.VERSION_CODES.LOLLIPOP)
class Camera2Fragment : Fragment(), View.OnClickListener {

    private var mCameraId: String? = null
    private var mTextureView: AutoFitTextureView? = null
    private var mPreviewSize: Size = Size(0, 0)

    private var mCaptureSession: CameraCaptureSession? = null
    private var mCameraDevice: CameraDevice? = null
    private var mPreviewRequestBuilder: CaptureRequest.Builder? = null
    private var mPreviewRequest: CaptureRequest? = null
    private val mCamerDeviceStateCallback = object : CameraDevice.StateCallback() {
        override fun onOpened(camera: CameraDevice) {

        }

        override fun onDisconnected(camera: CameraDevice) {
            TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        }

        override fun onClosed(camera: CameraDevice) {
            super.onClosed(camera)
        }

        override fun onError(camera: CameraDevice, error: Int) {
            TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        }
    }

    private var mBackgroudThread: HandlerThread? = null
    private var mBackgroundHandler: Handler? = null
    private var mImageReader: ImageReader? = null
    private var mFile: File? = null
    private var mOnImageAvailableListener = object : ImageReader.OnImageAvailableListener {
        override fun onImageAvailable(reader: ImageReader?) {
            mBackgroundHandler?.post(ImageSaver(reader?.acquireNextImage(), mFile))
        }
    }
    /**
     * The current state of camera state for taking pictures.
     *
     * @see #mCaptureCallback
     * */
    private var mState = STATE_PREVIEW

    /**
     * A {@link Semaphore} to prevent the app from existing before closing the camera.
     * */
    private val mCameraOpenCloseLock = Semaphore(1)

    private var mFlashSupported = false

    /**
     * Orientation of the camera sensor
     * */
    private var mSensorOrientation: Int = 0

    private val mCaptureCallback = object : CameraCaptureSession.CaptureCallback() {
        private fun process(result: CaptureResult) {
            when (mState) {
                STATE_PREVIEW -> { }
                STATE_WAITING_LOCK -> {
                    val afState = result.get(CaptureResult.CONTROL_AF_STATE)
                    if (afState == null) {
                        captureStillPicture()
                    } else if (CaptureResult.CONTROL_AF_STATE_FOCUSED_LOCKED == afState ||
                            CaptureResult.CONTROL_AF_STATE_NOT_FOCUSED_LOCKED == afState) {
                        // CONTROL_AF_STATE can be null on some devices
                        var aeState = result.get(CaptureResult.CONTROL_AE_STATE)
                        if (aeState == null || aeState == CaptureRequest.CONTROL_AE_STATE_CONVERGED) {
                            mState = STATE_PICTURE_TAKEN
                            captureStillPicture()
                        } else {
                            runPrecaptureSequence()
                        }
                    }
                }
                STATE_WAITING_PRECAPTURE -> {
                    // CONTROL_AE_STATE can be null on some devices
                    val aeState = result.get(CaptureResult.CONTROL_AE_STATE)
                    if (aeState == null ||
                            aeState == CaptureResult.CONTROL_AE_STATE_FLASH_REQUIRED ||
                            aeState == CaptureResult.CONTROL_AE_STATE_PRECAPTURE) {
                        mState = STATE_WAITING_NON_PRECAPTURE
                    }
                }
                STATE_WAITING_NON_PRECAPTURE -> {
                    val aeState = result.get(CaptureResult.CONTROL_AE_STATE)
                    if (aeState == null || aeState != CaptureResult.CONTROL_AE_STATE_PRECAPTURE) {
                        mState = STATE_PICTURE_TAKEN
                        captureStillPicture()
                    }
                }
            }
        }
        override fun onCaptureCompleted(session: CameraCaptureSession, request: CaptureRequest, result: TotalCaptureResult) {
            process(result)
        }

        override fun onCaptureProgressed(session: CameraCaptureSession, request: CaptureRequest, partialResult: CaptureResult) {
            process(partialResult)
        }
    }

    private fun showToast(text: String) {
        activity?.runOnUiThread {
            Toast.makeText(activity, text, Toast.LENGTH_SHORT).show()
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return super.onCreateView(inflater, container, savedInstanceState)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
    }

    override fun onResume() {
        super.onResume()
    }

    override fun onPause() {
        super.onPause()
    }

    companion object {
        /**
         * Conversion from screen rotation to JPEG orientation
         * */
        private val ORIENTATIONS: SparseIntArray by lazy {
            val tSparseIntArray = SparseIntArray()
            tSparseIntArray.append(Surface.ROTATION_0, 90)
            tSparseIntArray.append(Surface.ROTATION_90, 0)
            tSparseIntArray.append(Surface.ROTATION_180, 270)
            tSparseIntArray.append(Surface.ROTATION_270, 180)
            tSparseIntArray
        }
        private val FRAGMENT_DIALOG = "dialog"
        private val TAG = "Camera2Fragment"
        /**
         * Camera state: Showing camera preview.
         * */
        private val STATE_PREVIEW = 0
        /**
         * Camera state: Waiting for the focus to be locked.
         * */
        private val STATE_WAITING_LOCK = 1
        /**
         *Camera state: Waiting for the exposure to be precapture state.
         * */
        private val STATE_WAITING_PRECAPTURE = 2
        /**
         * Camera state: Waiting for the exposure state to be something other than precapture.
         * */
        private val STATE_WAITING_NON_PRECAPTURE = 3
        /**
         * Camera state: Picture was token.
         * */
        private val STATE_PICTURE_TAKEN = 4
        /**
         * Max preview width that is guaranteed by Camera2 API
         * */
        private val MAX_PREVIEW_WIDTH = 1920
        /**
         * Max preview height that is guaranteed by Camera2 API
         * */
        private val MAX_PREVIEW_HEIGHT = 1080
        /**
         * {@link TextureView.SurfaceTextureListener} handles several lifecycle events on a {@link TextureView}
         * */
        private val mSurfaceTextureListener = object: TextureView.SurfaceTextureListener {
            override fun onSurfaceTextureAvailable(surface: SurfaceTexture?, width: Int, height: Int) {
                openCamera(width, height)
            }

            override fun onSurfaceTextureSizeChanged(surface: SurfaceTexture?, width: Int, height: Int) {
                configureTransform(width, height)
            }

            override fun onSurfaceTextureUpdated(surface: SurfaceTexture?) {

            }

            override fun onSurfaceTextureDestroyed(surface: SurfaceTexture?): Boolean {
                return true
            }

        }

        private fun chooseOptimalSize(choices: Array<Size>, textureViewWidth: Int, textureViewHeight: Int,
                                      maxWidth: Int, maxHeight: Int, aspectRatio: Size): Size {
            var bigEnough = ArrayList<Size>()
            var notBigEnough = ArrayList<Size>()

            val w = aspectRatio.width
            val h = aspectRatio.height
            for (option in choices) {
                if (option.width <= maxWidth && option.height <= maxHeight && option.height == option.width * h / w) {
                    if (option.width >= textureViewWidth && option.height >= textureViewHeight) {
                        bigEnough.add(option)
                    } else {
                        notBigEnough.add(option)
                    }
                }
            }

            if (bigEnough.size > 0) {
                return Collections.min(bigEnough) { lhs, rhs ->
                    sign((lhs.width * lhs.height - rhs.width * rhs.height).toDouble()).toInt()
                }
            } else if (notBigEnough.size > 0) {
                return Collections.max(notBigEnough) { lhs, rhs ->
                    sign((lhs.width * lhs.height - rhs.width * rhs.height).toDouble()).toInt()
                }
            } else {
                Log.e(TAG, "Couldn't find any suitable preview size")
                return choices[0]
            }
        }

        fun newInstane():Camera2Fragment = Camera2Fragment()
    }

    override fun onClick(v: View?) {

    }
}


















