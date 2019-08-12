package com.UILearn

import android.content.Context
import android.util.SparseArray
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ImageView
import android.widget.TextView

abstract class ListViewAdapter<T>(private val layoutRes: Int, private var mData: MutableList<T>):BaseAdapter() {
    abstract fun bindView(holder: ViewHolder, obj: T)
    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        val holder:ViewHolder = ViewHolder.bind(parent.context, convertView, parent, layoutRes, position)
        bindView(holder, getItem(position))
        return holder.getItemView()
    }

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

    class ViewHolder constructor(val context: Context, val parent: ViewGroup, layoutRes: Int) {
        private var mViews: SparseArray<View> = SparseArray()
        private var item: View
        private var position:Int = 0

        init {
            val convertView = LayoutInflater.from(context).inflate(layoutRes, parent, false)
            item = convertView
            convertView.tag = this
        }

        private fun getView(viewId:Int): View {
            var t = mViews.get(viewId)
            if (t == null) {
                t = item.findViewById(viewId)
                mViews.put(viewId, t)
            }
            return t
        }

        fun getItemView(): View {
            return item
        }

        fun getItemPosition(): Int {
            return position
        }

        fun setText(id: Int, text: CharSequence): ViewHolder {
            val view:View = getView(id)
            if (view is TextView) {
                view.text = text
            }
            return this
        }

        fun setImageResource(id: Int, drawableRes: Int): ViewHolder {
            val view:View = getView(id)
            if (view is ImageView) {
                view.setImageResource(id)
            } else {
                view.setBackgroundResource(id)
            }
            return this
        }

        fun setOnClickListener(id: Int, listener: View.OnClickListener): ViewHolder {
            getView(id).setOnClickListener(listener)
            return this
        }

        fun setVisibility(id: Int, visible: Int): ViewHolder {
            getView(id).visibility = visible
            return this
        }

        fun setTag(id: Int, obj: Any): ViewHolder {
            getView(id).tag = obj
            return this
        }

        companion object {
            fun bind(context:Context, convertView: View?, parent:ViewGroup, layoutRes:Int, position: Int):ViewHolder {
                val viewHolder: ViewHolder
                if (convertView !is View) {
                    viewHolder = ViewHolder(context, parent, layoutRes)
                } else {
                    viewHolder = convertView.tag as ViewHolder
                    viewHolder.item = convertView
                }
                viewHolder.position = position

                return viewHolder
            }
        }
    }

}