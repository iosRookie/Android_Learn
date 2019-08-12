package com.UILearn

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.example.myapplication.R

class RecyclerViewCustomAdapter(private var mData:List<String>) : RecyclerView.Adapter<RecyclerViewCustomAdapter.VH>() {

    //ViewHolder
    class VH(item:View) : RecyclerView.ViewHolder(item) {
        val title: TextView = item.findViewById(R.id.rc_item_text)
    }

    override fun onCreateViewHolder(viewHolder: ViewGroup, postion: Int): VH {
        return VH(LayoutInflater.from(viewHolder.context).inflate(R.layout.activity_recycler_item, viewHolder, false))
    }

    override fun getItemCount(): Int {
        return mData.count()
    }

    override fun onBindViewHolder(viewHolder: VH, p1: Int) {
        viewHolder.title.text = mData[p1]
        viewHolder.itemView.setOnClickListener {

        }
    }

}