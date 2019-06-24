package com.example.myapplication

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.ListView
import com.yyg.kotlinlearn.KoltinLearn

import java.lang.reflect.Array

class MainActivity : AppCompatActivity(), AdapterView.OnItemClickListener {

    private val titles = arrayOf("kotlin", "ListView", "RecylerView")

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val mainList = findViewById<ListView>(R.id.main_list_view)
        mainList.adapter = ArrayAdapter(this, android.R.layout.simple_expandable_list_item_1, titles)
        mainList.onItemClickListener = this

        Log.d(MAIN_ACTIVITY_LOG, "onCreate: ")
    }

    override fun onStart() {
        super.onStart()

        Log.d(MAIN_ACTIVITY_LOG, "onStart: ")
    }

    override fun onPause() {
        super.onPause()

        Log.d(MAIN_ACTIVITY_LOG, "onPause: ")
    }

    override fun onResume() {
        super.onResume()

        Log.d(MAIN_ACTIVITY_LOG, "onResume: ")
    }

    override fun onRestart() {
        super.onRestart()

        Log.d(MAIN_ACTIVITY_LOG, "onRestart: ")
    }

    override fun onStop() {
        super.onStop()

        Log.d(MAIN_ACTIVITY_LOG, "onStop: ")
    }

    override fun onDestroy() {
        super.onDestroy()

        Log.d(MAIN_ACTIVITY_LOG, "onDestroy: ")
    }


    override fun onItemClick(parent: AdapterView<*>, view: View, position: Int, id: Long) {
        if (Array.get(titles, position) == "kotlin") {
            val intent = Intent(this, KoltinLearn::class.java)
            startActivity(intent)
        }
        if (Array.get(titles, position) == "ListView") {
            val intent = Intent(this, ListViewLearn::class.java)
            startActivity(intent)
        }

        if (Array.get(titles, position) == "RecylerView") {

        }
    }

    companion object {
        var MAIN_ACTIVITY_LOG = "activity_life_cycle"
    }
}
