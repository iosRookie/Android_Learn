package com.ThreadLearn

import android.os.*
import android.support.v7.app.AppCompatActivity
import android.os.Process.THREAD_PRIORITY_DEFAULT
import android.util.Log
import com.example.myapplication.R
import kotlinx.android.synthetic.main.activity_thread_learn.*
import retrofit2.http.Url
import java.util.*
import java.util.concurrent.Executor
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit

class ThreadLearnActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_thread_learn)

        threadButton.setOnClickListener {
            threadTest()
        }

        handlerThreadButton.setOnClickListener {
            handlerThreadTest()
        }

        executorsButton.setOnClickListener {
            executorServiceTest()
        }

        AsyncButton.setOnClickListener {
            asyncTaskTest()
        }
    }

    private fun handlerThreadTest() {
        val handlerThread = HandlerThreadTest("handler_thread_test")
        Log.d("ThreadLearnActivity","handlerThread state ${handlerThread.state}")

        handlerThread.start()

        val handler = object : Handler(handlerThread.looper) {
            override fun handleMessage(msg: Message?) {
                Log.d("ThreadLearnActivity","handleMessage")
            }
        }

        try {
            handler.sendMessage(Message().apply { obj = "first" })
            Log.d("ThreadLearnActivity","handlerThread state ${handlerThread.state}")
            handler.sendMessage(Message().apply { obj = "second" })
            Log.d("ThreadLearnActivity","handlerThread state ${handlerThread.state}")
        } catch (e: IllegalStateException) {
            e.printStackTrace()
        }

        handlerThread.quitSafely()

        try {
            handler.sendMessage(Message().apply { obj = "third" })
        } catch (e: IllegalStateException) {
            e.printStackTrace()
        }
    }

    private fun threadTest() {
        val tThread = Thread(Runnable {
            Log.d("ThreadLearnActivity","Thread")
        })
        Log.d("ThreadLearnActivity","Thread state ${tThread.state}")
        tThread.start()
        Log.d("ThreadLearnActivity","Thread state ${tThread.state}")
    }

    private fun executorServiceTest() {
        // newCachedThreadPool 创建一个可缓存线程池，线程池的最大长度无限制，但如果线程池长度超过处理需要，可灵活回收空闲线程，若无可回收，则新建线程
        Log.d("newCachedThreadPool", "start. threadName = ${Thread.currentThread().name}")
        val cacheThreadPoolService = Executors.newCachedThreadPool()
        for (index in 0..100) {
            cacheThreadPoolService.execute {
                Log.d("", "index = $index threadName = ${Thread.currentThread().name}")
            }
        }
        Log.d("newCachedThreadPool", "end. threadName = ${Thread.currentThread().name}")

        // newFixedThreadPool  创建一个定长线程池，可控制线程最大并发数，超出的线程会在队列中等待
        Log.d("newFixedThreadPool", "start")
        val fixedThreadPool = Executors.newFixedThreadPool(5)
        for (index in 0..100) {
            fixedThreadPool.execute {
                Log.d("", "index = $index threadName = ${Thread.currentThread().name}")
            }
        }
        Log.d("newFixedThreadPool", "end")

        // newSingleThreadExecutor 创建一个单线程化的线程池，它只会用唯一的工作线程来执行任务，保证所有任务按照指定顺序(FIFO, LIFO, 优先级)执行。
        Log.d("newSingleThreadExecutor", "start")
        val singleThreadPool = Executors.newSingleThreadExecutor()
        for (index in 0..100) {
            singleThreadPool.execute {
                Log.d("", "index = $index threadName = ${Thread.currentThread().name}")
            }
        }
        Log.d("newSingleThreadExecutor", "end")

        // newScheduledThreadPool 创建一个定长线程池，支持定时及周期性任务执行。(FIFO)
        Log.d("newScheduledThreadPool", "start")
        val scheduledThreadPoolService = Executors.newScheduledThreadPool(5)
        for (index in 0..100) {
//            scheduledThreadPoolService.execute {
//                Log.d("", "index = $index threadName = ${Thread.currentThread().name}")
//            }
            scheduledThreadPoolService.schedule({
                Log.d("", "index = $index threadName = ${Thread.currentThread().name}")
            }, 0L, TimeUnit.SECONDS)
        }

//        scheduledThreadPoolService.scheduleAtFixedRate({
//            Log.d("", "threadName = ${Thread.currentThread().name}")
//        }, 100L, 2, TimeUnit.MILLISECONDS)

//        scheduledThreadPoolService.scheduleWithFixedDelay({
//            Log.d("", "threadName = ${Thread.currentThread().name}")
//    }, 100L, 100L, TimeUnit.MILLISECONDS)

        Log.d("newScheduledThreadPool", "end")
    }

    private fun asyncTaskTest() {
        val customerAsyncTask = CustomerAsyncTask()
        customerAsyncTask.execute("asyncTaskTest")
    }

    companion object {
        private class CustomerAsyncTask : AsyncTask<String, Float, Int>() {
            private val Downloading = 1
            private val DownloadFinished = 2

            // 在主线程，显示线程任务的进度
            // 根据需求复写
            override fun onProgressUpdate(vararg values: Float?) {
                Log.d("onProgressUpdate", "progress = ${values[0]}")
                super.onProgressUpdate(*values)
            }

            // 接受线程任务执行结果，将执行结果显示到UI组件
            override fun onPostExecute(result: Int?) {
                Log.d("onPostExecute", "$result")
                super.onPostExecute(result)
            }

            // 接受输入参数、执行任务中的耗时操作、返回线程任务执行的结果
            // 必须复写，自定线程任务
            override fun doInBackground(vararg params: String?): Int {
                // 自定义的线程任务
                var progress = 0f
                for (i in 0..10) {
                    progress = i * 0.1f
                    Log.d("doInBackground", "${params[0]}")
                    Thread.sleep(1)

                    // 可调用publishProgress()显示进度，之后将执行onProgressUpdate()
                    publishProgress(progress)
                }
                return if (progress >= 1f) {
                    DownloadFinished
                } else {
                    Downloading
                }

            }

            // 将异步任务设置为取消状态
            override fun onCancelled(result: Int?) {
                super.onCancelled(result)
            }

            override fun onCancelled() {
                super.onCancelled()
            }

            // 执行线程任务前的操作
            // 根据需求复写
            override fun onPreExecute() {
                super.onPreExecute()
            }
        }
    }
}

class HandlerThreadTest @JvmOverloads constructor(name: String, priority: Int = THREAD_PRIORITY_DEFAULT):HandlerThread(name, priority) {

}

class SerialExecutor(private val executor: Executor): Executor {
    private val tasks: Queue<Runnable> = ArrayDeque<Runnable>()
    var active: Runnable? = null

    @Synchronized
    override fun execute(command: Runnable?) {
        tasks.offer(Runnable {
            try {
                command?.run()
            } finally {
                scheduleNext()
            }
        })
        if (active == null) {
            scheduleNext()
        }
    }

    @Synchronized
    private fun scheduleNext() {
        active = tasks.poll()
        if (active != null) {
            executor.execute(active)
        }
    }

}
