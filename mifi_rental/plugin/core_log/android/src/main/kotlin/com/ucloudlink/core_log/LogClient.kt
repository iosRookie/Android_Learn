package com.ucloudlink.core_log

import android.content.Context
import com.ucloudlink.core_log.plan_direct.LogAdapterImpl

/**
 * Author: 肖扬威
 * Date: 2020/3/3 15:22
 * Description:
 */
class LogClient : ILogAdapter {

    internal var tag: String? = null
    internal var filePath: String? = null
    internal var showThread: Boolean? = null
    internal var logLevel: Int? = null
    internal var encrypt: Boolean? = null
    private var adapter: ILogAdapter? = null
    private var context: Context? = null

    companion object {
        val instance = SingletonHolder.holder
    }

    private object SingletonHolder {
        val holder = LogClient()
    }


    override fun log(priority: Int, tag: String?, message: String?, t: Throwable?) {
        adapter?.log(priority, tag, message, t)
    }

    fun tag(tag: String): LogClient {
        this.tag = tag
        return this
    }

    fun filePath(filePath: String?): LogClient {
        this.filePath = filePath
        return this
    }

    fun showThread(showThread: Boolean?): LogClient {
        this.showThread = showThread
        return this
    }

    fun logLevel(logLevel: Int?): LogClient {
        this.logLevel = logLevel
        return this
    }

    fun encrypt(encrypt: Boolean): LogClient {
        this.encrypt = encrypt
        return this
    }

    fun adapter(adapter: ILogAdapter) {
        this.adapter = adapter
    }

    fun build(context: Context) {
        this.context = context.applicationContext
        if (adapter == null) {
            adapter = LogAdapterImpl()
        }
    }

    internal fun getContext(): Context {
        return context!!
    }


}