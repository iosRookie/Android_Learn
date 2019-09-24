package com.UILearn

import android.support.v4.app.Fragment
import android.support.v4.app.FragmentManager
import android.support.v4.app.FragmentPagerAdapter
import android.support.v4.app.FragmentStatePagerAdapter
import android.view.ViewGroup

class MyFragmentPagerAdapter(fragmentManager: FragmentManager, var fragments: List<Fragment>) : FragmentStatePagerAdapter(fragmentManager) {
    override fun getItem(p0: Int): Fragment {
        return fragments[p0]
    }

    override fun getCount(): Int {
        return fragments.count()
    }

    override fun instantiateItem(container: ViewGroup, position: Int): Any {
        return super.instantiateItem(container, position)
    }

    override fun destroyItem(container: ViewGroup, position: Int, `object`: Any) {
        super.destroyItem(container, position, `object`)
    }

    override fun startUpdate(container: ViewGroup) {
        super.startUpdate(container)
    }

    override fun finishUpdate(container: ViewGroup) {
        super.finishUpdate(container)
    }
}