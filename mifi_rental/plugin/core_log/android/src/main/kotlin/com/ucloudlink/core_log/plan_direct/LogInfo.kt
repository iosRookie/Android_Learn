package com.ucloudlink.core_log.plan_direct

/**
 * Author: 肖扬威
 * Date: 2020/3/3 15:18
 * Description:
 */
class LogInfo {
    internal var priority: Int? = null
    internal var message: String? = null
    internal var tag: String? = null
    internal var t: Throwable? = null
    internal var stackTrace: Throwable? = null
    internal var timeStamp: String? = null
    internal var threadName: String? = null
    internal var fileName: String? = null


    internal var next: LogInfo? = null
    private var use: Boolean = false

    companion object {
        private val sPoolSync = Any()//锁对象
        private var sPool: LogInfo? = null
        private var sPoolSize = 0
        private const val MAX_POOL_SIZE = 30//缓存池大小

        fun obtain(): LogInfo {
            synchronized(sPoolSync) {
                sPool?.let {
                    val m = it
                    sPool = m.next
                    m.next = null
                    m.use = true
                    sPoolSize--
                    return m
                }
            }
            return LogInfo()
        }
    }

    internal fun recycle() {
        if (use) {
            return
        }
        recycleUnchecked()
    }

    internal fun recycleUnchecked() {
        priority = null
        message = null
        tag = null
        t = null
        timeStamp = null
        stackTrace = null
        threadName = null
        fileName = null
        use = false

        synchronized(sPoolSync) {
            if (sPoolSize < MAX_POOL_SIZE) {
                next = sPool
                sPool = this
                sPoolSize++
            }
        }
    }
}