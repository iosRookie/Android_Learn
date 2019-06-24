package com.yyg.kotlinlearn

import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.ListView
import com.example.myapplication.R

class KoltinLearn : AppCompatActivity() {

    private val listItems:Array<String> = arrayOf("基本语法", "基本数据类型", "条件控制", "循环控制", "类和对象", "继承", "接口", "扩展", "数据类与密封类", "泛型", "枚举类", "对象表达式/声明", "委托")

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_koltin_learn)

        val mainlist = findViewById<ListView>(R.id.kotlic_main_list)
        mainlist.adapter = ArrayAdapter(this, android.R.layout.simple_list_item_1, listItems)
        mainlist.onItemClickListener = AdapterView.OnItemClickListener { parent, view, position, id ->
            println("点击了 ${listItems[position]}")
            if (listItems[position] == "基本语法") {
                val intent:Intent = Intent(this, BasicSyntaxActivity::class.java)
                startActivity(intent)
            }
            if (listItems[position] == "基本数据类型") {
                val intent:Intent = Intent(this, BasicDataTypeActivity::class.java)
                startActivity(intent)
            }
            if (listItems[position] == "条件控制") {
                val intent:Intent = Intent(this, ConditionControlActivity::class.java)
                startActivity(intent)
            }
            if (listItems[position] == "循环控制") {
                val intent:Intent = Intent(this, CycleControlActivity::class.java)
                startActivity(intent)
            }
        }
    }
}
