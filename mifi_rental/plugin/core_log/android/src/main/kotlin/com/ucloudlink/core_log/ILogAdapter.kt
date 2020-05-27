package com.ucloudlink.core_log

/**
 * Author: 肖扬威
 * Date: 2020/3/3 15:17
 * Description:
 */
interface ILogAdapter {
    fun log(priority: Int, tag: String?, message: String?, t: Throwable?)
}