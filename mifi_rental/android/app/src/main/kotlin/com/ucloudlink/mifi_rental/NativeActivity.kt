package com.ucloudlink.mifi_rental

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
//import com.idlefish.flutterboost.interfaces.IFlutterViewContainer.RESULT_KEY
import com.ucloudlink.mifi_rental.R

/**
 * Author: 肖扬威
 * Date: 2020/3/3 14:13
 * Description:
 */
class NativeActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native)
        val tvTest: TextView = findViewById(R.id.tv_test)
        tvTest.setOnClickListener {
            val map = HashMap<String, Any>()
            map["param1"] = "test"
            map["param2"] = "test"
            val intent = Intent()
//            intent.putExtra(RESULT_KEY, map)
            setResult(Activity.RESULT_OK, intent)
            finish()
        }
    }
}