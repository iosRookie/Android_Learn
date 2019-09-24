package com.common_ui

import android.content.Context
import android.util.AttributeSet
import android.util.Log
import android.view.View
import android.widget.CompoundButton
import android.widget.RadioGroup
import com.example.myapplication.R
import kotlinx.android.synthetic.main.tab_bar_layout.view.*

public interface onSelectedItem {
    public fun changedCurrentSelected(btn: CompoundButton, index: Int)
}

class TabBar @JvmOverloads constructor(context: Context, attributeSet: AttributeSet? = null) : RadioGroup(context, attributeSet) {

    public var onSelectedItem: onSelectedItem? = null

    init {
        val typeArray = context.obtainStyledAttributes(attributeSet, R.styleable.TabBar)
        initView()
        typeArray.recycle()
    }

    private fun initView() {
        View.inflate(context, R.layout.tab_bar_layout, this)

        radioButton_dialing.setOnCheckedChangeListener { buttonView, isChecked ->
            Log.d("radioButton_dialing", "selected + $isChecked")
            if (isChecked)onSelectedItem?.changedCurrentSelected(buttonView, 0)
        }

        radioButton_contact.setOnCheckedChangeListener { buttonView, isChecked ->
            Log.d("radioButton_contact", "selected + $isChecked")
            if (isChecked)onSelectedItem?.changedCurrentSelected(buttonView, 1)
        }

        radioButton_message.setOnCheckedChangeListener { buttonView, isChecked ->
            Log.d("radioButton_message", "selected + $isChecked")
            if (isChecked)onSelectedItem?.changedCurrentSelected(buttonView, 2)
        }

        radioButton_individual.setOnCheckedChangeListener { buttonView, isChecked ->
            Log.d("radioButton_individual", "selected + $isChecked")
            if (isChecked)onSelectedItem?.changedCurrentSelected(buttonView, 3)
        }
    }

    public fun selectedCurrentItem(index: Int) {
        when(index) {
            0 -> this.check(R.id.radioButton_dialing)
            1 -> this.check(R.id.radioButton_contact)
            2 -> this.check(R.id.radioButton_message)
            3 -> this.check(R.id.radioButton_individual)
        }
    }
}