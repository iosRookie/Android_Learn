package com.UILearn

import android.content.Context
import android.graphics.*
import android.graphics.Bitmap.createBitmap
import android.util.AttributeSet
import android.util.Log
import android.view.MotionEvent
import android.view.View
import kotlin.math.abs

class PaintView @JvmOverloads constructor(context: Context, attributeSet: AttributeSet? = null, defStyleAttr: Int = 0): View(context, attributeSet, defStyleAttr) {

//    constructor(context: Context) : this(context, null)
//    constructor(context: Context, attrs: AttributeSet?) : this(context, attrs, 0)
//    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    private var mPaint: Paint = Paint()   // 画笔
    private var mPath: Path = Path()      // 绘图路径
    private var mCanvas: Canvas? = null
    private lateinit  var mBitmap: Bitmap

    private var mLastX: Float? = 0f
    private var mLastY: Float? = 0f

    init {
        mPaint.color = Color.GREEN
        mPaint.isAntiAlias = true
        mPaint.isDither = true
        mPaint.style = Paint.Style.STROKE
        mPaint.strokeJoin = Paint.Join.ROUND  // 结合处为圆角
        mPaint.strokeCap = Paint.Cap.ROUND    // 转弯处为圆形
        mPaint.strokeWidth = 20f              // 画笔宽度
    }

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec)

        mBitmap = createBitmap(
                this.measuredWidth,
                this.measuredHeight,
                Bitmap.Config.ARGB_8888
        )
    }

    override fun onDraw(canvas: Canvas?) {
        mCanvas?.drawPath(mPath, mPaint)
        canvas?.drawBitmap(mBitmap, 0f, 0f, null)
    }

    override fun onTouchEvent(event: MotionEvent?): Boolean {
        val action = event?.action
        val x = event?.x
        val y = event?.y

        when (action) {
            MotionEvent.ACTION_DOWN -> {
                if (mCanvas == null) {
                    mCanvas = Canvas(this.mBitmap)
                }
                mLastX = x
                mLastY = y
                mPath.moveTo(mLastX!!, mLastX!!)
                Log.d("moveTo", "$mLastX ++++ $mLastY")
            }
            MotionEvent.ACTION_MOVE -> {
                val dx = abs(x!!.minus(mLastX!!))
                val dy = abs(y!!.minus(mLastY!!))
                if (dx > 2f || dy > 2f) {
                    Log.d("lineTo", "$x ++++ $y")
                    mPath.lineTo(x, y)
                }

                mLastX = x
                mLastY = y
//                Log.d("ACTION_MOVE", "$mLastX ++++ $mLastY")
            }
        }
        invalidate()
        return true
    }

}