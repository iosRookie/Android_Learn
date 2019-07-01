package com.UILearn

import com.example.myapplication.R
import kotlinx.android.synthetic.main.list_view_item_learn.*

class AnimalAdapter<T>(private val layoutRes: Int, private var mData: MutableList<T>):ListViewAdapter<T>(layoutRes, mData) {
    override fun bindView(holder: ViewHolder, obj: T) {
        holder.setText(R.id.list_name_text, (obj as AnimalModel).name)
        holder.setText(R.id.list_speak_text, (obj as AnimalModel).aSpeak)
    }
}
