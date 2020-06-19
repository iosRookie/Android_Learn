package com.ucloudlink.mifi_rental

class MessageEvent internal constructor(message: String) {

    private var message: String? = null
    init {
        this.message = message
    }
    internal fun getMessage(): String? {
        return message
    }
    fun setMessage(message: String) {
        this.message = message
    }
}