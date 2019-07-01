package com.UILearn

import android.content.Context
import android.support.v7.widget.RecyclerView
import android.util.SparseArray
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.TextView
import com.example.myapplication.R

class AnimalAdapter<T>(val mContext: Context, val layout: Int, var mData: MutableList<T>):BaseAdapter() {

//    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
//        var holder:ViewHolder? = null
//        var itemView:View? = convertView
//        if (itemView == null) {
//            itemView = LayoutInflater.from(mContext).inflate(layout, parent, false)
//            val name = itemView.findViewById<TextView>(R.id.list_name_text)
//            val aspeak = itemView.findViewById<TextView>(R.id.list_speak_text)
//
//            holder = ViewHolder(name, aspeak)
//            itemView.tag = holder
//        } else {
//            holder = itemView.tag as ViewHolder
//        }
//        holder.nameText.text = (mData[position] as AnimalModel).name
//        holder.speakText.text = (mData[position] as AnimalModel).aSpeak
//
//        return itemView as View
//    }

    override fun getItem(position: Int): T {
            return mData[position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getCount(): Int {
        return mData.size
    }

    fun add(data: T) {
        mData.add(data)
        notifyDataSetChanged()
    }

    fun remove(data: T) {
        if (mData.contains(data)) {
            mData.remove(data)
            notifyDataSetChanged()
        }
    }

    fun remove(position: Int) {
        if (mData.size > position) {
            mData.removeAt(position)
            notifyDataSetChanged()
        }
    }

    fun clear() {
        mData.clear()
        notifyDataSetChanged()
    }

    private class ViewHolder constructor(val context: Context, val parent: ViewGroup, val layoutRes: Int) {
        private var mViews: SparseArray<View> = SparseArray()
        private lateinit var item: View
        private var position:Int = 0

        companion object {
            fun bind(context:Context, convertView: View?, parent:ViewGroup, layoutRes:Int, position: Int):ViewHolder {
                var bviewHolder = ViewHolder(context, parent, layoutRes)
                if (convertView !is View) {
                    bviewHolder = ViewHolder(context, parent, layoutRes)
                } else {
                    bviewHolder = convertView.tag as ViewHolder
                    bviewHolder.item = convertView
                }
                bviewHolder.position = position

                return bviewHolder
            }
        }
    }

}