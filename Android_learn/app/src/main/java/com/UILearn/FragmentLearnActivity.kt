package com.UILearn

import android.os.Bundle
import android.support.v4.app.Fragment
import android.support.v4.app.FragmentManager
import android.support.v4.app.FragmentTransaction
import android.support.v4.view.ViewPager
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.View
import android.widget.CompoundButton
import android.widget.FrameLayout
import android.widget.RadioGroup
import android.widget.TextView
import com.common_ui.TabBar
import com.common_ui.onSelectedItem
import com.example.myapplication.R
import kotlinx.android.synthetic.main.activity_fragment_learn.*
import kotlinx.android.synthetic.main.top_bar_layout.*

class FragmentLearnActivity : AppCompatActivity() {
    private lateinit var contact: TextView
    private lateinit var message: TextView
    private lateinit var dialing: TextView
    private lateinit var individual: TextView
    private lateinit var content: FrameLayout
    private val fragmentManager: FragmentManager = supportFragmentManager

    private var contactFragment: ContactFragment? = null
    private var messageFragment: MessageFragment? = null
    private var dialingFragment: DialingFragment? = null
    private var individualFragment: IndividualFragment? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_fragment_learn)

//        contact = findViewById(R.id.txt_contact_channel)
//        message = findViewById(R.id.txt_message_channel)
//        dialing = findViewById(R.id.txt_dialing_channel)
//        individual = findViewById(R.id.txt_individual_channel)
//        content = findViewById(R.id.ly_content)
//
//        contact.setOnClickListener(this)
//        message.setOnClickListener(this)
//        dialing.setOnClickListener(this)
//        individual.setOnClickListener(this)
//
//        dialing.performClick()
        Log.d("Activity Life Cycle", "onCreate")

        var fragments = arrayListOf<Fragment>(DialingFragment(), ContactFragment(), MessageFragment(), IndividualFragment())
        fragments_view_pager.adapter = MyFragmentPagerAdapter(fragmentManager, fragments = fragments)
        fragments_view_pager.addOnPageChangeListener(object : ViewPager.OnPageChangeListener {
            override fun onPageScrollStateChanged(p0: Int) {

            }

            override fun onPageScrolled(p0: Int, p1: Float, p2: Int) {

            }

            override fun onPageSelected(p0: Int) {
                 bottom_tab_bar.selectedCurrentItem(p0)
            }
        })

        bottom_tab_bar.onSelectedItem = object : onSelectedItem {
            override fun changedCurrentSelected(btn: CompoundButton, index: Int) {
                Log.d("changedCurrentSelected", "index = $index")
                fragments_view_pager.setCurrentItem(index, false)
            }
        }
    }

//    override fun onClick(v: View?) {
//        val fTransaction = fragmentManager.beginTransaction()
//        hiddenAllFragment(fTransaction)
//        setSelectedChannel(v)
//        when (v?.id) {
//            R.id.txt_dialing_channel -> {
//                if (dialingFragment == null) {
//                    dialingFragment = DialingFragment()
//                    fTransaction.add(R.id.ly_content, dialingFragment!!)
//                } else {
//                    fTransaction.show(dialingFragment!!)
//                }
//            }
//            R.id.txt_contact_channel -> {
//                if (contactFragment == null) {
//                    contactFragment = ContactFragment()
//                    fTransaction.add(R.id.ly_content, contactFragment!!)
//                } else {
//                    fTransaction.show(contactFragment!!)
//                }
//            }
//            R.id.txt_message_channel -> {
//                if (messageFragment == null) {
//                    messageFragment = MessageFragment()
//                    fTransaction.add(R.id.ly_content, messageFragment!!)
//                } else {
//                    fTransaction.show(messageFragment!!)
//                }
//            }
//            R.id.txt_individual_channel -> {
//                if (individualFragment == null) {
//                    individualFragment = IndividualFragment()
//                    fTransaction.add(R.id.ly_content, individualFragment!!)
//                } else {
//                    fTransaction.show(individualFragment!!)
//                }
//            }
//        }
//        fTransaction.commit()
//    }
//
//    private fun setSelectedChannel(v: View?) {
//        txt_contact_channel.isSelected = false
//        txt_dialing_channel.isSelected = false
//        txt_message_channel.isSelected = false
//        txt_individual_channel.isSelected = false
//        v?.isSelected = true
//    }
//
//    private fun hiddenAllFragment(fragmentTransaction:FragmentTransaction) {
//        if (contactFragment != null)fragmentTransaction.hide(contactFragment!!)
//        if (dialingFragment != null)fragmentTransaction.hide(dialingFragment!!)
//        if (messageFragment != null)fragmentTransaction.hide(messageFragment!!)
//        if (individualFragment != null)fragmentTransaction.hide(individualFragment!!)
//    }


    override fun onAttachFragment(fragment: Fragment?) {
        super.onAttachFragment(fragment)
        Log.d("Activity Life Cycle","onAttachFragment")
    }

    override fun onContentChanged() {
        super.onContentChanged()
        Log.d("Activity Life Cycle","onContentChanged")
    }

    override fun onStart() {
        super.onStart()
        Log.d("Activity Life Cycle","onStart")
    }

    override fun onRestart() {
        super.onRestart()
        Log.d("Activity Life Cycle","onRestart")
    }

    override fun onResume() {
        super.onResume()
        Log.d("Activity Life Cycle","onResume")
    }

    override fun onPause() {
        super.onPause()
        Log.d("Activity Life Cycle","onPause")
    }

    override fun onStop() {
        super.onStop()
        Log.d("Activity Life Cycle","onStop")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("Activity Life Cycle","onDestroy")
    }

}
