package com.UILearn

import com.example.myapplication.R

data class ContactModel(val name: String, val phoneNumber: String)

class ContactsAdapter(private val layoutRes: Int, private var mData: MutableList<ContactModel>): ListViewAdapter<ContactModel>(layoutRes, mData) {
    override fun bindView(holder: ViewHolder, obj: ContactModel) {
        holder.setText(R.id.contact_name_text, obj.name)
        holder.setText(R.id.contact_phone_text, obj.phoneNumber)
    }
}