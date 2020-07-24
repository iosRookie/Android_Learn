package com.ucloudlink.mifi_rental

class MessageEvent internal constructor(message: String, params:Map<String, Any>? = null) {

    private var message: String? = null
    var params: Map<String, Any>? = null
    init {
        this.message = message
        this.params = params
    }
    internal fun getMessage(): String? {
        return message
    }
    fun setMessage(message: String) {
        this.message = message
    }
}