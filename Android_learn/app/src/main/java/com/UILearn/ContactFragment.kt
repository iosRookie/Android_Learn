package com.UILearn

import android.content.Context
import android.os.Bundle
import android.support.v4.app.Fragment
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

import com.example.myapplication.R

class ContactFragment : Fragment() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("ContactFragment", "onCreate")
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_contact, container, false)
    }


    override fun onAttach(context: Context) {
        super.onAttach(context)
        Log.d("ContactFragment", "onAttach")

    }

    override fun onDetach() {
        super.onDetach()
        Log.d("ContactFragment", "onDetach")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("ContactFragment", "onDestroy")
    }

}
