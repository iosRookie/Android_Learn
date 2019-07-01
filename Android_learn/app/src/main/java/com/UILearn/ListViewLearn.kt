package com.UILearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.AdapterView
import android.widget.Button
import android.widget.ListView
import android.widget.Toast
import com.example.myapplication.R


class ListViewLearn : AppCompatActivity(), View.OnClickListener {

    var datas = mutableListOf<AnimalModel>(AnimalModel("dog","wangwang",0),
            AnimalModel("cat","miaomiao",0),
            AnimalModel("pig","hengheng",0))

    var adapter: AnimalAdapter<AnimalModel> = AnimalAdapter(R.layout.list_view_item_learn, datas)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_list_view_learn)

        val listView = findViewById<ListView>(R.id.learn_list_view)
        listView.adapter = adapter

        listView.onItemClickListener = AdapterView.OnItemClickListener { parent, view, position, id ->
            Toast.makeText(this@ListViewLearn,"点击了第${position}个Item",Toast.LENGTH_SHORT).show()
        }

        val addBtn:Button = findViewById(R.id.list_view_add_btn)
        val deleteBtn:Button = findViewById(R.id.list_view_delete_btn)
        val clearBtn:Button = findViewById(R.id.list_view_clear_btn)
        clearBtn.setOnClickListener(this)

        addBtn.setOnClickListener(object : View.OnClickListener {
            override fun onClick(v: View?) {
                Toast.makeText(this@ListViewLearn, "click add btn", Toast.LENGTH_SHORT).show()
            }
        })

        deleteBtn.setOnClickListener{
            adapter.remove(0)
            Toast.makeText(this@ListViewLearn, "click delete btn", Toast.LENGTH_SHORT).show()
        }

    }

    override fun onClick(v: View?) {
        adapter.clear()
        Toast.makeText(this@ListViewLearn, "click clear btn", Toast.LENGTH_SHORT).show()
    }
}
