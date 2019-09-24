package com.UILearn

import android.content.Context
import android.net.Uri
import android.os.Bundle
import android.support.v4.app.Fragment
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

import com.example.myapplication.R

class IndividualFragment : Fragment() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("IndividualFragment", "onCreate")
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_individual, container, false)
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        Log.d("IndividualFragment", "onAttach")

    }

    override fun onDetach() {
        super.onDetach()
        Log.d("IndividualFragment", "onDetach")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("IndividualFragment", "onDestroy")
    }
}
