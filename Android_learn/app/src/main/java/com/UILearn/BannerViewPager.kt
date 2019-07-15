package com.UILearn

import android.content.Context
import android.support.v4.view.PagerAdapter
import android.support.v4.view.ViewPager
import android.view.View
import android.view.ViewGroup

class BannerViewPager(context: Context, var datas: ArrayList<Any>? = null): ViewPager(context) {
    private var mViewLists: ArrayList<View> = ArrayList()

    private inner class BannerPagerAdapter : PagerAdapter() {
        override fun isViewFromObject(p0: View, p1: Any): Boolean {
            return p0 == p1
        }

        override fun getCount(): Int {
            return Int.MAX_VALUE
        }

        override fun instantiateItem(container: ViewGroup, position: Int): Any {
            container.addView(mViewLists[position])
            return super.instantiateItem(container, position)
        }

        override fun destroyItem(container: ViewGroup, position: Int, `object`: Any) {
            container.removeView(mViewLists[position])
            super.destroyItem(container, position, `object`)
        }

    }

}