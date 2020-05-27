package com.ucloudlink.core_log

/**
 * Author: 肖扬威
 * Date: 2020/3/3 15:23
 * Description:
 */
fun <T1, T2> checkNotNull(value1: T1?, value2: T2?, bothNotNull: (T1, T2) -> (Unit)): Boolean {
    return if (value1 != null && value2 != null) {
        bothNotNull(value1, value2)
        true
    } else {
        false
    }
}