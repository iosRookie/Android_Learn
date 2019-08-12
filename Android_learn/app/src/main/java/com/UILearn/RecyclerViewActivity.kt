package com.UILearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v7.widget.DefaultItemAnimator
import android.support.v7.widget.DividerItemDecoration
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.OrientationHelper
import com.example.myapplication.R
import kotlinx.android.synthetic.main.activity_recycler_view.*

class RecyclerViewActivity : AppCompatActivity() {

    private val linearAdapter : QuickRecyclerAdapter<String> = object : QuickRecyclerAdapter<String>(arrayListOf("1","2","3")) {
        override fun getLayoutId(viewType: Int): Int = R.layout.activity_recycler_item
        override fun convert(viewHolder: VH, data: String, position: Int) = viewHolder.setText(R.id.rc_item_text, data)
    }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_recycler_view)

        initLinearRecycler()
    }

    private fun initLinearRecycler() {
        val linearLayoutManager = LinearLayoutManager(this)
        //设置默认布局管理器
        linear_layout_recycler_view.layoutManager = linearLayoutManager
        //设置为垂直布局
        linearLayoutManager.orientation = OrientationHelper.VERTICAL
        //设置Adapter
        linear_layout_recycler_view.adapter = linearAdapter
        //设置分隔线
        linear_layout_recycler_view.addItemDecoration(DividerItemDecoration(this, OrientationHelper.VERTICAL))
        //设置增加或删除条目的动画
        linear_layout_recycler_view.itemAnimator = DefaultItemAnimator()

        add_item_btn.setOnClickListener {
            linearAdapter.addNewItem((linearAdapter.itemCount + 1).toString(), 0)
            linearLayoutManager.scrollToPosition(0)
        }

        delete_item_btn.setOnClickListener {
            linearAdapter.deleteItem(0)
        }
    }

    private fun initGridRecycler() {

    }

    private fun initStaggeredGridRecycler() {

    }
}
