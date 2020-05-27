package com.ucloudlink.core_log.plan_direct

import android.Manifest
import android.content.pm.PackageManager
import android.util.Log
import androidx.core.app.ActivityCompat
import com.ucloudlink.core_log.ILogAdapter
import com.ucloudlink.core_log.LogClient
import com.ucloudlink.core_log.Rc4
import com.ucloudlink.core_log.checkNotNull
import java.io.File
import java.io.FileWriter
import java.io.PrintWriter
import java.io.StringWriter
import java.text.SimpleDateFormat
import java.util.*
import java.util.concurrent.ConcurrentLinkedQueue
import java.util.regex.Pattern

/**
 * Author: 肖扬威
 * Date: 2020/3/3 15:18
 * Description:
 */
class LogAdapterImpl : ILogAdapter {
    private val callStackIndex = 3
    private val pattern = Pattern.compile("(\\$\\d+)+$")
    private val logs = ConcurrentLinkedQueue<LogInfo>()
    private val dateFormat = SimpleDateFormat("yyyyMMdd HH:mm:ss.SSS", Locale.getDefault())

    private val filePath: String? = LogClient.instance.filePath
    private val showThread = LogClient.instance.showThread ?: false
    private val defaultTag: String? = LogClient.instance.tag
    private val logLevel = LogClient.instance.logLevel ?: Log.VERBOSE
    private val encrypt = LogClient.instance.encrypt ?: false
    private val checkPermission = (filePath?.startsWith(LogClient.instance.getContext().getExternalFilesDir(null)!!.absolutePath) == true
            || filePath?.startsWith(LogClient.instance.getContext().externalCacheDir!!.absolutePath) == true).not()

    private var thread: Thread? = null

    companion object {
        internal val obj = Object()
    }

    override fun log(priority: Int, tag: String?, message: String?, t: Throwable?) {
        val logInfo = LogInfo.obtain()
        logInfo.priority = priority
        logInfo.tag = tag
        logInfo.t = t
        logInfo.message = message
        logInfo.stackTrace = Throwable()
        if (priority >= logLevel && filePath != null) {
            logInfo.timeStamp = dateFormat.format(Date())
            logInfo.timeStamp?.run {
                logInfo.fileName = "${this.substring(0, 8)}log.log"
            }
        }
        if (showThread) {
            logInfo.threadName = Thread.currentThread().name
        }
        logs.offer(logInfo)
        checkThreadAlive()
        synchronized(obj) {
            obj.notify()
        }
    }

    private fun checkThreadAlive() {
        if (thread?.isAlive != true) {
            thread?.interrupt()
            createLogThread()
        }
    }

    private fun createLogThread() {
        thread = Thread(Runnable {
            while (true) {
                var writer: FileWriter? = null
                var currentFileName: String? = null
                while (logs.size > 0) {
                    logs.poll()?.let { logInfo ->
                        val tag = createTag(logInfo)
                        val message = if (encrypt) {
                            " [JLog]  : ${Rc4.encrypt(createMessage(logInfo))}"
                        } else {
                            createMessage(logInfo)
                        }
                        logToConsole(logInfo.priority, tag, message)
                        logInfo.fileName?.let { fileName ->
                            currentFileName?.run {
                                if (this != fileName) {
                                    currentFileName = null
                                    writer?.flush()
                                    writer?.close()
                                    writer = null
                                }
                            }
                            if (currentFileName == null) {
                                if (!checkPermission || ActivityCompat.checkSelfPermission(LogClient.instance.getContext(), Manifest.permission.WRITE_EXTERNAL_STORAGE)
                                        == PackageManager.PERMISSION_GRANTED
                                ) {
                                    currentFileName = fileName
                                    val file = File(filePath + fileName)
                                    if (!file.exists()) {
                                        file.parentFile?.mkdirs()
                                    }
                                    writer = FileWriter(file, true)
                                }

                            }
                            writer?.let { writer ->
                                val content = createContent(
                                        logInfo.timeStamp,
                                        logInfo.priority,
                                        tag,
                                        message
                                )
                                content?.run {
                                    writer.write("\r\n$this")
                                }
                            }
                        }
                        logInfo.recycleUnchecked()
                    }
                }
                writer?.flush()
                writer?.close()
                synchronized(obj) {
                    obj.wait()
                }
            }

        }, "logThread")
        thread?.start()
    }


    private fun createTag(logInfo: LogInfo): String {
        var tag = logInfo.tag?.run { "[$this]" }
        if (tag == null) {
            tag = logInfo.stackTrace?.run {
                getClassTag(this)?.run {
                    "[$this]"
                }
            }
        }
        if (tag == null) {
            defaultTag?.run { tag = "[$this]" }
        }
        logInfo.threadName?.let {
            tag = tag?.run {
                "$this[$it]"
            } ?: "[$it]"
        }
        return tag ?: "null"
    }

    private fun getClassTag(t: Throwable): String? {
        val stackTrace = t.stackTrace
        if (stackTrace.size > callStackIndex) {
            return createStackElementTag(stackTrace[callStackIndex])
        }
        return null
    }

    private fun createStackElementTag(element: StackTraceElement): String {
        var className = element.className
        val methodName = element.methodName

        val m = pattern.matcher(className)
        if (m.find()) {
            className = className.substring(className.lastIndexOf('.') + 1)
        }
        return "$className#$methodName/${element.fileName}${element.lineNumber}"
    }

    private fun createMessage(logInfo: LogInfo): String? {
        var message: String? = logInfo.message
        logInfo.t?.run {
            val throwable = getStackTraceString(this)
            message = message?.run {
                "$this\n$throwable"
            } ?: throwable
        }
        return message
    }

    private fun getStackTraceString(t: Throwable): String {
        val sw = StringWriter(256)
        val pw = PrintWriter(sw, false)
        t.printStackTrace(pw)
        pw.use {
            it.flush()
        }
        return sw.toString()
    }

    private fun logToConsole(priority: Int?, tag: String, message: String?) {
        checkNotNull(priority, message) { p, msg ->
            when (p) {
                Log.VERBOSE -> {
                    Log.v(tag, msg)
                }
                Log.DEBUG -> {
                    Log.d(tag, msg)
                }
                Log.INFO -> {
                    Log.i(tag, msg)
                }
                Log.WARN -> {
                    Log.w(tag, msg)
                }
                Log.ERROR -> {
                    Log.e(tag, msg)
                }
                Log.ASSERT -> {

                }
            }
        }
    }

    private fun createContent(
            timeStamp: String?,
            priority: Int?,
            tag: String,
            message: String?
    ): String? {
        var content: String? = null
        timeStamp?.run {
            content = this
        }
        val priorityStr: String? = when (priority) {
            Log.VERBOSE -> "A"
            Log.DEBUG -> "D"
            Log.INFO -> "I"
            Log.WARN -> "W"
            Log.ERROR -> "E"
            Log.ASSERT -> "A"
            else -> null
        }
        priorityStr?.run {
            if (content == null) {
                content = this
            } else {
                content += " $this"
            }
        }
        if (content == null) {
            content = tag
        } else {
            content += " $tag"
        }
        message?.run {
            if (content == null) {
                content = this
            } else {
                content += " $this"
            }
        }
        return content
    }
}