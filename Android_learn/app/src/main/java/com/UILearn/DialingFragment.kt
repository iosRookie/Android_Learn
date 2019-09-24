package com.UILearn

import android.content.Context
import android.net.Uri
import android.os.Bundle
import android.support.v4.app.Fragment
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView

import com.example.myapplication.R

class DialingFragment : Fragment() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("DialingFragment", "onCreate")
//        activity?.findViewById<TextView>(R.id.txt_dialing_channel)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_dialing, container, false)
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        Log.d("DialingFragment", "onAttach")

    }

    override fun onDetach() {
        super.onDetach()
        Log.d("DialingFragment", "onDetach")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("DialingFragment", "onDestroy")
    }
}
