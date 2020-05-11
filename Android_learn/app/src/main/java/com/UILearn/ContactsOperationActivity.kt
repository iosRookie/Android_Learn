package com.UILearn

import android.database.Cursor
import android.net.Uri
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.ListView
import android.widget.Toast
import com.example.myapplication.R
import com.tbruyelle.rxpermissions2.RxPermissions

class ContactsOperationActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_contacts_operation)

        var array: MutableList<ContactModel> = mutableListOf()
        for (i in 0 .. 3) {
            array.add(ContactModel("$i", "241234213"))
        }
        findViewById<ListView>(R.id.contact_list_view).adapter = ContactsAdapter(R.id.contact_item, array)
    }

    private fun permissionRequest() {
        RxPermissions(this).request(android.Manifest.permission.READ_SMS, android.Manifest.permission.READ_CONTACTS, android.Manifest.permission.WRITE_CONTACTS).subscribe({
            if (it) {
                Toast.makeText(this, "短信读取权限获取成功", Toast.LENGTH_SHORT).show()
            } else {
                Toast.makeText(this, "拒绝短信读取权限", Toast.LENGTH_SHORT).show()
            }
        }, {

        }).dispose()
    }

    private fun queryContacts(number: String) {
        val uri = Uri.parse("content://com.android.contacts/data/phones/filter/$number")
        val cursor = contentResolver.query(uri, arrayOf("display_name"), null, null, null)
        if (cursor is Cursor && cursor.moveToFirst()) {
            val name = cursor.getString(0)
            Log.d("MainActivity", name)
        }
        cursor?.close()
    }

    private fun querySMS() {
        val cursor = contentResolver.query(Uri.parse("content://sms/"), arrayOf("address","date","type","body"), null, null, null)
        if (cursor is Cursor) {
            while (cursor.moveToNext()) {
                Log.d("MainActivity", "address ${cursor.getString(0)}")
                Log.d("MainActivity", "date ${cursor.getString(1)}")
                Log.d("MainActivity", "type ${cursor.getString(2)}")
                Log.d("MainActivity", "body ${cursor.getString(3)}")
            }
        }
        cursor?.close()
    }
}
