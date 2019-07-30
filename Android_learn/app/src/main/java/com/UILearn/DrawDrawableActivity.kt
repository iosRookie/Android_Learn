package com.UILearn

import android.content.Context
import android.graphics.*
import android.graphics.drawable.ShapeDrawable
import android.graphics.drawable.shapes.*
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.view.View
import com.UILearn.DrawDrawableActivity.MyShapeDrawable
import android.graphics.ComposePathEffect
import android.graphics.CornerPathEffect
import android.graphics.PathEffect
import android.graphics.DiscretePathEffect
import android.graphics.drawable.Drawable





class DrawDrawableActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(SampleView(this))
    }

    class SampleView(context: Context) : View(context) {
        private var mDrawables = arrayListOf<ShapeDrawable>()

        init {
            isFocusable = true

            val outerR = floatArrayOf(12.toFloat(), 12.toFloat(), 12.toFloat(), 12.toFloat(), 0.toFloat(), 0.toFloat(), 0.toFloat(), 0.toFloat())
            val inset = RectF(6.toFloat(),6.toFloat(),6.toFloat(),6.toFloat())
            val innerR = floatArrayOf(12.toFloat(),12.toFloat(),0.toFloat(),0.toFloat(),12.toFloat(),12.toFloat(),0.toFloat(),0.toFloat())

            val path = Path()
            path.moveTo(50.toFloat(),0.toFloat())
            path.lineTo(0.toFloat(),50.toFloat())
            path.lineTo(50.toFloat(),100.toFloat())
            path.lineTo(100.toFloat(),50.toFloat())
            path.close()

            mDrawables.add(ShapeDrawable(RectShape()))
            mDrawables.add(ShapeDrawable(OvalShape()))
            mDrawables.add(ShapeDrawable(RoundRectShape(outerR,null,null)))
            mDrawables.add(ShapeDrawable(RoundRectShape(outerR,inset,null)))
            mDrawables.add(ShapeDrawable(RoundRectShape(outerR,inset,innerR)))
            mDrawables.add(ShapeDrawable(PathShape(path, 100.toFloat(),100.toFloat())))
            mDrawables.add(MyShapeDrawable(ArcShape(45.toFloat(), (-270).toFloat())))

            mDrawables[0].paint.color = 0xFFFF0000.toInt()
            mDrawables[1].paint.color = 0xFF00FF00.toInt()
            mDrawables[2].paint.color = 0xFF0000FF.toInt()
            mDrawables[3].paint.shader = makeSweep()
            mDrawables[4].paint.shader = makeLinear()
            mDrawables[5].paint.shader = makeTiling()
            mDrawables[6].paint.color = 0x88FF8844.toInt()

            val pe = DiscretePathEffect(10f, 4f)
            val pe2 = CornerPathEffect(4f)
            mDrawables[3].paint.pathEffect = ComposePathEffect(pe2, pe)

            val msd = mDrawables[6] as MyShapeDrawable
            msd.mStrokePaint.strokeWidth = 4.toFloat()
        }

        override fun onDraw(canvas: Canvas?) {
            if (canvas == null) return

            val x = 10
            var y = 10
            val width = 400
            val height = 100
            for (dr in mDrawables) {
                dr.setBounds(x, y, x + width, y + height)
                dr.draw(canvas)
                y += height + 5
            }
        }

        companion object {
            private fun makeSweep(): Shader {
                return SweepGradient(150.toFloat(),25.toFloat(),
                        intArrayOf(0xFFFF0000.toInt(), 0xFF00FF00.toInt(), 0xFF0000FF.toInt(), 0xFFFF0000.toInt()),
                        null)

            }
            private fun makeLinear(): Shader {
                return LinearGradient(0.toFloat(),0.toFloat(),50.toFloat(),50.toFloat(),
                        intArrayOf(0xFFFF0000.toInt(), 0xFF00FF00.toInt(), 0xFF0000FF.toInt()),
                        null,Shader.TileMode.MIRROR)
            }

            private fun makeTiling(): Shader {
                val pixels = intArrayOf(0xFFFF0000.toInt(), 0xFF00FF00.toInt(), 0xFF0000FF.toInt(), 0)
                val bm = Bitmap.createBitmap(pixels,2,2,Bitmap.Config.ARGB_8888)
                return BitmapShader(bm,Shader.TileMode.REPEAT,Shader.TileMode.REPEAT)
            }
        }
    }

    class MyShapeDrawable(s: Shape): ShapeDrawable(s) {
        var mStrokePaint = Paint(Paint.ANTI_ALIAS_FLAG)

        init {
            mStrokePaint.style = Paint.Style.STROKE
        }

        override fun onDraw(shape: Shape?, canvas: Canvas?, paint: Paint?) {
            shape?.draw(canvas,paint)
            shape?.draw(canvas,mStrokePaint)
        }
    }
}