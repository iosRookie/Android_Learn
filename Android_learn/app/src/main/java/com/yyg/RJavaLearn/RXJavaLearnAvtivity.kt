package com.yyg.RJavaLearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.util.Consumer
import android.util.Log
import com.example.myapplication.R
import io.reactivex.Observable
import io.reactivex.ObservableEmitter
import io.reactivex.ObservableOnSubscribe
import io.reactivex.internal.operators.observable.ObservableFlatMap
import java.util.*

class RXJavaLearnAvtivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_rxjava_learn_avtivity)
        var observable = Observable.create(object<String> : ObservableOnSubscribe<kotlin.String> {
            override fun subscribe(emitter: ObservableEmitter<kotlin.String>) {
                emitter.onNext("Hello")
                emitter.onNext("Hi")
                emitter.onNext("Aloha")
                emitter.onComplete()
            }
        })

        /*
        * scheduler  调度器
        * Schedulers.immediate():直接在当前线程运行，相当于不指定线程。默认的
        * Schedulers.newThread():总是启用新线程，并在新线程执行
        * Schedulers.io():I/O操作（读写文件、读写数据库、网络信息交互）。行为模式和newThread()差不多，区别在于io()的内部实现是用一个无数量上线的线程池，可以重用空闲的线程，
        *                 因此多数情况下io()比newThread()更有效率。不要把计算工作放在io()中，可以避免创建不必要的线程。
        * Schedulers.computation():计算所使用的Scheduler。这个计算指的是CPU核数。不要把I/O操作放在computation()中，否则I/O操作的等待时间会浪费CPU。
        * 另外，Android还有一个专用的AndroidSchedulers.mainThread()，它指定的操作将在Android主线程运行。
        * 可以使用subscribeOn()和observeOn()两个方法来对线程进行控制。
        * */
        observable.subscribe { Log.d("RXJavaLearnAvtivity", it) }.dispose()

        Observable.just("1","2","3").doOnNext{ Log.d("RXJavaLearnAvtivity", it) }.subscribe().dispose()

        var datas = arrayOf("1","2","3","4")
        Observable.fromArray(datas).subscribe({

        }, {

        }, {

        }, {

        }).dispose()
    }
}

