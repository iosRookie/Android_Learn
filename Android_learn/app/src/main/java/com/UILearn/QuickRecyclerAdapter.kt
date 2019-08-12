package com.UILearn

import android.support.v7.widget.RecyclerView
import android.util.SparseArray
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView

abstract class QuickRecyclerAdapter<T>(private var mData: MutableList<T>) : RecyclerView.Adapter<QuickRecyclerAdapter.VH>() {

    // item布局
    abstract fun getLayoutId(viewType: Int) : Int
    // 设置内容
    abstract fun convert(viewHolder: VH, data: T, position: Int)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): VH = VH.get(parent, getLayoutId(viewType))

    override fun getItemCount(): Int = mData.count()

    override fun onBindViewHolder(viewHolder: VH, position: Int) = convert(viewHolder, mData[position], position)

    fun addNewItem(data: T, position: Int) {
        mData.add(position, data)
        notifyItemInserted(0)
    }

    fun deleteItem(position: Int) {
        if (mData.count() > position) {
            mData.removeAt(position)
            notifyItemRemoved(position)
        }
    }

    class VH(val item : View) : RecyclerView.ViewHolder(item) {
        private val mViews : SparseArray<View> = SparseArray()
        companion object {
            fun get(parent: ViewGroup, layoutId: Int): VH {
                return VH(LayoutInflater.from(parent.context).inflate(layoutId, parent, false))
            }
        }

        private fun <T: View> getView(id: Int): T {
            var view = mViews.get(id)
            if (view == null) {
                view = item.findViewById(id)
                mViews.put(id, view)
            }
            return view as T
        }

        fun setText(id: Int, value: String) {
            val tp = getView(id) as TextView
            tp.text = value
        }
    }
}