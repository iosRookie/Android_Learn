package com.UILearn

import android.content.Context
import android.os.Message
import android.support.v4.view.PagerAdapter
import android.support.v4.view.ViewPager
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.ImageView
import android.widget.Toast
import com.example.myapplication.R
import kotlinx.android.synthetic.main.personal_banner_layout.view.*
import java.util.*
import java.util.logging.Handler
import java.util.logging.LogRecord


interface PersonalBannerSelected {
    fun selectedIndex(index: Int)
}

class PersonalBannerLayout(context: Context, attrs: AttributeSet) : FrameLayout(context, attrs) {
    var bannerSelected:PersonalBannerSelected? = null
    private val imageIds = arrayListOf(R.mipmap.ad1, R.mipmap.ad2, R.mipmap.ad3, R.mipmap.ad4)
    private var imageViews = arrayListOf<ImageView>()
    private var mTimerTask: TimerTask? = null
    private var currentItem: Int = 0

    init {
        val view = LayoutInflater.from(context).inflate(R.layout.personal_banner_layout, this)
        for ((id, i) in imageIds.withIndex()) {
            val iv = ImageView(getContext())
            iv.setBackgroundResource(i)
            iv.id = id
            iv.setOnClickListener { v ->
                bannerSelected?.selectedIndex(v.id)
            }
            imageViews.add(iv)
        }

        viewPager.adapter = ViewPagerAdapter(imageViews, viewPager)
        viewPager.addOnPageChangeListener(object : ViewPager.OnPageChangeListener{
            override fun onPageScrollStateChanged(p0: Int) {

            }

            override fun onPageScrolled(p0: Int, p1: Float, p2: Int) {

            }

            override fun onPageSelected(p0: Int) {
                val newPosition = p0 % imageIds.size
            }
        })
    }

    fun showBanner() {
        this.visibility = View.VISIBLE
    }

    fun hidenBanner() {
        this.visibility = View.GONE
    }

    fun autoPlayView() {
        mTimerTask = object : TimerTask(){
            override fun run() {
                currentItem = (currentItem + 1) % imageIds.size
            }
        }
    }



    inner class ViewPagerAdapter(private var images: List<ImageView>, private var viewPager: ViewPager): PagerAdapter() {
        override fun isViewFromObject(p0: View, p1: Any): Boolean {
            return p0 == p1
        }

        override fun getCount(): Int {
            return  Int.MAX_VALUE
        }

        override fun instantiateItem(container: ViewGroup, position: Int): Any {
            val iv = images.get(position % images.size)
            viewPager.addView(iv)
            return iv
        }

        override fun destroyItem(container: ViewGroup, position: Int, `object`: Any) {
            viewPager.removeView(images.get(position % images.size))
        }
    }
}