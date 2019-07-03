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


/**
 * A simple [Fragment] subclass.
 * Activities that contain this fragment must implement the
 * [FirstFragment.OnFragmentInteractionListener] interface
 * to handle interaction events.
 * Use the [FirstFragment.newInstance] factory method to
 * create an instance of this fragment.
 *
 */

interface OnArticleSelectedLister {
    fun onArticleSelected(): Uri
}

class FirstFragment : Fragment() {
    var mlistener: OnArticleSelectedLister? = null

    override fun onAttach(context: Context) {
        super.onAttach(context)
        mlistener = context as OnArticleSelectedLister
        Log.d("Fragment Life Cycle","onAttach")
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("Fragment Life Cycle","onCreate")
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_first, container, false)
        Log.d("Fragment Life Cycle","onCreateView")
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        Log.d("Fragment Life Cycle","onViewCreated")
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        Log.d("Fragment Life Cycle","onActivityCreated")
    }

    override fun onViewStateRestored(savedInstanceState: Bundle?) {
        super.onViewStateRestored(savedInstanceState)
        Log.d("Fragment Life Cycle","onViewStateRestored")
    }

    override fun onStart() {
        super.onStart()
        Log.d("Fragment Life Cycle","onStart")
    }

    override fun onResume() {
        super.onResume()
        Log.d("Fragment Life Cycle","onResume")
    }

    override fun onPause() {
        super.onPause()
        Log.d("Fragment Life Cycle","onPause")
    }

    override fun onStop() {
        super.onStop()
        Log.d("Fragment Life Cycle","onStop")
    }

    override fun onDestroyView() {
        super.onDestroyView()
        Log.d("Fragment Life Cycle","onDestroyView")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("Fragment Life Cycle","onDestroy")
    }

    override fun onDetach() {
        super.onDetach()
        Log.d("Fragment Life Cycle","onDetach")
    }

}
