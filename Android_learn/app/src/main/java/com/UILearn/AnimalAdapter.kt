package com.UILearn

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter

class AnimalAdapter(val mContext: Context, var mData: List<AnimalModel>):BaseAdapter() {

    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun getItem(position: Int): Any? {
        return null
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getCount(): Int {
        return mData.count()
    }

}