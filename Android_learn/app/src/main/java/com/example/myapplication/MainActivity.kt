package com.example.myapplication

import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.View
import android.widget.*
import com.UILearn.*
import com.common.NetWorkReceiver
import com.common.ServiceActivity
import com.yyg.RJavaLearn.RXJavaLearnAvtivity
import com.yyg.kotlinlearn.KoltinLearn
import kotlinx.android.synthetic.main.activity_main.*
import java.lang.reflect.Array

class MainActivity : AppCompatActivity(), AdapterView.OnItemClickListener {

    private val networkReceiver:NetWorkReceiver = NetWorkReceiver()

    private val titles = arrayOf("kotlin", "RXJava", "WebView", "ListView", "Fragment", "LayoutInflater", "Service", "RecylerView", "Contacts")

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val mainList = main_list_view
        mainList.adapter = ArrayAdapter(this, android.R.layout.simple_expandable_list_item_1, titles)
        mainList.onItemClickListener = this

        Log.d(MAIN_ACTIVITY_LOG, "onCreate: ")

        val intentFilter: IntentFilter = IntentFilter()
        intentFilter.addAction("android.net.conn.CONNECTIVITY_CHANGE")
        registerReceiver(networkReceiver, intentFilter)

        personal_banner_layout.bannerSelected = object : PersonalBannerSelected {
            override fun selectedIndex(index: Int) {
                when (index) {
                    0 -> Toast.makeText(this@MainActivity, "图片1被点击", Toast.LENGTH_SHORT).show();
                    1 -> Toast.makeText(this@MainActivity, "图片2被点击", Toast.LENGTH_SHORT).show();
                    2 -> Toast.makeText(this@MainActivity, "图片3被点击", Toast.LENGTH_SHORT).show();
                    3 -> Toast.makeText(this@MainActivity, "图片4被点击", Toast.LENGTH_SHORT).show();
                }
            }
        }
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
        unregisterReceiver(networkReceiver)
    }


    override fun onItemClick(parent: AdapterView<*>, view: View, position: Int, id: Long) {
        if (Array.get(titles, position) == "kotlin") {
            val intent = Intent(this, KoltinLearn::class.java)
            startActivity(intent)
        }
        if (Array.get(titles, position) == "RXJava") {
            val intent = Intent(this, RXJavaLearnAvtivity::class.java)
            startActivity(intent)
        }
        if (Array.get(titles, position) == "ListView") {
            val intent = Intent(this, ListViewLearn::class.java)
            startActivity(intent)
        }
        if (Array.get(titles, position) == "Fragment") {
            val intent = Intent(this, FragmentLearnActivity::class.java)
            startActivity(intent)
        }
        if (Array.get(titles, position) == "Service") {
            val intent = Intent(this, ServiceActivity::class.java)
            startActivity(intent)
        }

        if (Array.get(titles, position) == "RecylerView") {

        }
        if (Array.get(titles, position) == "LayoutInflater") {
            startActivity(Intent(this, LayoutInflaterActivity::class.java))
        }

        if (Array.get(titles, position) == "WebView") {
            val intent = Intent(this, WebViewActivity::class.java)
            startActivity(intent)
        }

        if (Array.get(titles, position) == "Contacts") {
            val intent = Intent(this, ContactsOperationActivity::class.java)
            startActivity(intent)
        }
    }

    companion object {
        var MAIN_ACTIVITY_LOG = "activity_life_cycle"
    }
}
