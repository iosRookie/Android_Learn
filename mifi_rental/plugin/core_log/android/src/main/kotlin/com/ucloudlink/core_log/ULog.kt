package com.ucloudlink.core_log

import android.util.Log

/**
 * Author: 肖扬威
 * Date: 2020/3/3 15:29
 * Description:
 */
object ULog {
    fun builder(): LogClient {
        return LogClient.instance
    }

    fun v(message: String) {
        LogClient.instance.log(Log.VERBOSE, null, message, null)
    }

    fun v(tag: String, message: String) {
        LogClient.instance.log(Log.VERBOSE, tag, message, null)
    }

    fun v(tag: String, message: String, throwable: Throwable) {
        LogClient.instance.log(Log.VERBOSE, tag, message, throwable)
    }

    fun v(throwable: Throwable) {
        LogClient.instance.log(Log.VERBOSE, null, null, throwable)
    }

    fun d(message: String) {
        LogClient.instance.log(Log.DEBUG, null, message, null)
    }

    fun d(tag: String, message: String) {
        LogClient.instance.log(Log.DEBUG, tag, message, null)
    }

    fun d(tag: String, message: String, throwable: Throwable) {
        LogClient.instance.log(Log.DEBUG, tag, message, throwable)
    }

    fun d(throwable: Throwable) {
        LogClient.instance.log(Log.DEBUG, null, null, throwable)
    }

    fun i(message: String) {
        LogClient.instance.log(Log.INFO, null, message, null)
    }

    fun i(tag: String, message: String) {
        LogClient.instance.log(Log.INFO, tag, message, null)
    }

    fun i(tag: String, message: String, throwable: Throwable) {
        LogClient.instance.log(Log.INFO, tag, message, throwable)
    }

    fun i(throwable: Throwable) {
        LogClient.instance.log(Log.INFO, null, null, throwable)
    }

    fun w(message: String) {
        LogClient.instance.log(Log.WARN, null, message, null)
    }

    fun w(tag: String, message: String) {
        LogClient.instance.log(Log.WARN, tag, message, null)
    }

    fun w(tag: String, message: String, throwable: Throwable) {
        LogClient.instance.log(Log.WARN, tag, message, throwable)
    }

    fun w(throwable: Throwable) {
        LogClient.instance.log(Log.WARN, null, null, throwable)
    }

    fun e(message: String) {
        LogClient.instance.log(Log.ERROR, null, message, null)
    }

    fun e(tag: String, message: String) {
        LogClient.instance.log(Log.ERROR, tag, message, null)
    }

    fun e(message: String, throwable: Throwable) {
        LogClient.instance.log(Log.ERROR, null, message, throwable)
    }

    fun e(tag: String, message: String, throwable: Throwable) {
        LogClient.instance.log(Log.ERROR, tag, message, throwable)
    }

    fun e(throwable: Throwable) {
        LogClient.instance.log(Log.ERROR, null, null, throwable)
    }

    fun a(message: String) {
        LogClient.instance.log(Log.ASSERT, null, message, null)
    }

    fun a(tag: String, message: String) {
        LogClient.instance.log(Log.ASSERT, tag, message, null)
    }

    fun a(tag: String, message: String, throwable: Throwable) {
        LogClient.instance.log(Log.ASSERT, tag, message, throwable)
    }

    fun a(throwable: Throwable) {
        LogClient.instance.log(Log.ASSERT, null, null, throwable)
    }
}