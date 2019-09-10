package com.yyg.RJavaLearn

import android.annotation.SuppressLint
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.AdapterView
import com.UILearn.ListViewAdapter
import com.example.myapplication.R
import io.reactivex.Observable
import io.reactivex.ObservableOnSubscribe
import io.reactivex.Single
import io.reactivex.SingleOnSubscribe
import io.reactivex.functions.Consumer
import io.reactivex.schedulers.Schedulers
import kotlinx.android.synthetic.main.activity_rxjava_learn_avtivity.*
import java.util.concurrent.TimeUnit

class RXJavaLearnAvtivity : AppCompatActivity() {
    @SuppressLint("CheckResult")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_rxjava_learn_avtivity)
        val datas = mutableListOf("Observable,Observer,subscribe", "do操作符", "Hot or Cold Observable")
        rxcontentList.adapter = object : ListViewAdapter<String>(android.R.layout.simple_list_item_1, datas) {
            override fun bindView(holder: ViewHolder, obj: String) {
                holder.setText(android.R.id.text1, obj)
            }
        }
        rxcontentList.onItemClickListener = AdapterView.OnItemClickListener { parent, view, position, id ->
            Log.d("RXJavaLearnActivity", datas[position])
            if (datas[position] == "Observable,Observer,subscribe") {
                observable()
            }
            if (datas[position] == "do操作符") {
                do_operation()
            }
            if (datas[position] == "Hot or Cold Observable") {
                hotAndCold()
            }
        }

        Single.create(SingleOnSubscribe<Int> {

        })
    }

    private fun observable() {
        Observable.just("1234")
                .subscribe({
                    Log.d("RXJavaLearnActivity", "onNext() $it")
                }, {
                    Log.d("RXJavaLearnActivity", "onError() " + it.message)
                }, {
                    Log.d("RXJavaLearnActivity", "onCompleted() ")
                })
                .dispose()
    }

    private fun do_operation() {
        Observable.just("1234")
                // 一旦观察者订阅了Observable，就会调用
                .doOnSubscribe {
                    Log.d("RXJavaLearnActivity", "doOnSubscribe() ")
                }
                // 可以在观察者订阅之后，设置是否取消订阅
                .doOnLifecycle({
                    Log.d("RXJavaLearnActivity", "doOnLifecycle() onSubscribe()")
                }, {
                    Log.d("RXJavaLearnActivity", "doOnLifecycle() onDispose()")
                })
                // Observable每发一项数据就会调用,onNext之前
                .doOnNext {
                    Log.d("RXJavaLearnActivity", "doOnNext() $it")
                }
                // Observable每发一项数据就会调用，包括onNext(), onError(), onCompleted()
                .doOnEach {
                    Log.d("RXJavaLearnActivity", "doOnEach() " + it.value)
                }
                // onNext()之后执行
                .doAfterNext {
                    Log.d("RXJavaLearnActivity", "doAfterNext() $it")
                }
                // onCompleted之后
                .doOnComplete {
                    Log.d("RXJavaLearnActivity", "doOnComplete() ")
                }
                // Observable终止之后
                .doFinally {
                    Log.d("RXJavaLearnActivity", "doFinally() ")
                }
                // 注册一个Action,当Observable调用onCompleted或onError时触发
                .doAfterTerminate {
                    Log.d("RXJavaLearnActivity", "doAfterTerminate() ")
                }
                .subscribe({
                    Log.d("RXJavaLearnActivity", "onCompleted() $it")
                }, {
                    Log.d("RXJavaLearnActivity", "onError()")
                }, {
                    Log.d("RXJavaLearnActivity", "onCompleted()")
                })
                .dispose()
    }

    private fun hotAndCold() {
        val sub1 = Consumer<Long> {
            Log.d("RXJavaLearnActivity", "sub1  $it")
        }
        val sub2 = Consumer<Long> {
            Log.d("RXJavaLearnActivity", "sub2  $it")
        }

        val observable = Observable.create(ObservableOnSubscribe<Long> {
            Observable.interval(10, TimeUnit.MILLISECONDS, Schedulers.computation())
                    .take(Long.MAX_VALUE)
                    .subscribe(it::onNext)
        }).observeOn(Schedulers.newThread())

        observable.subscribe(sub1)
        observable.subscribe(sub2)

        try {
            Thread.sleep(100L)
        }catch (e: InterruptedException) {
            e.printStackTrace()
        }
    }
}


