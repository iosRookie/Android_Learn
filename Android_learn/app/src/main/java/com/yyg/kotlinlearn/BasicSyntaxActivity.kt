package com.yyg.kotlinlearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.example.myapplication.R

class BasicSyntaxActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_basic_syntax)

        val tempSum = sum2(1,2)
        println(tempSum)
        print(vars(1,2,3))

        print(sumLambda(1,2))

        var a = 1
        val s1 = "a is $a"
        print(s1)
        val ts = s1
        a = 2
        val s2 = "${s1.replace("is", "was")}, but now is $a"
        print(s2)

        // NULL检查机制
        /*
        * Kotlin的空安全设计对于声明可为空的参数，在使用时要进行空判断处理。
        * 1.字段后加!!强制解析，抛出空异常
        * 2.字段后加?可不做处理返回值为空或者配合?:做空判断处理
        *
        * 当一个引用可能为null时，对应的类型声明必须明确的标记为可为null，即类型后加?
        * 处理可为null时，应该判断处理值为null的情况
        * */

        var age: String? = "23" // 表示age可为空
        val ages = age!!.toInt() // 强制解析age为非空字符串
        val ages1 = age?.toInt() // 不做处理返回null
        val ages2 = age?.toInt() ?: -1 // 为空时返回-1

        // 区间
        for (i in 1..4) print(i) // 输出1234  [1,4]
        for (i in 4..1) print(i) // 无输出
        // 使用 step 指定步长
        for (i in 1..4 step 2) print(i) //输出13  [1,4]步长为2
        for (i in 4 downTo 1 step 2) print(i) //输出42 [4,1]步长为2
        for (i in 1 until 4) print(i) //输出123 排除了4 [1,4)

        val fruits = listOf("banana", "avocado", "apple", "kiwifruit")
        fruits
                .filter { it.startsWith("a") }
                .sortedBy { it }
                .map { it.toUpperCase() }
                .forEach { println(it)  }

        val map = mapOf("a" to 1, "b" to 2, "c" to 3)
        map.filter { it.key.equals("a") }

        val p: String by lazy {
            return@lazy "bcd"
        }

        fun arrayOfMinusOnes(size: Int): IntArray {
            return IntArray(size).apply { fill(-1) }
        }

        var tma = 1
        var tmb = 2
        tma = tmb.also { tmb = tma }

        val tmArray = Array(5) { i: Int -> (i*i).toString()}

        val text = """
                    for (c in "foo")
                    print(c) """
        println(text)
        println(text.trimMargin())

        val text1 = """
                    |Tell me and I forget. 
                    |Teach me and I remember. 
                    |Involve me and I learn. 
                    |(Benjamin Franklin)
                    """
        println(text1)
        println(text1.trimMargin())
        println(text1.trimMargin("|"))

    }

    //函数定义
    fun sum(a:Int, b:Int): Int {  //有返回值函数
        return a + b
    }

    fun sum1(a:Int, b:Int) {  //无返回值

    }

    //表达式作为函数体，返回类型自动推断：
    fun sum2(a:Int, b:Int) = a + b
    fun sum3(a:Int, b:Int): Int = a + b

    //lambda表达式函数
    val sumLambda: (Int, Int) -> Int = {x,y -> x + y}

    //变长参数用vararg关键字表示
    fun vars(vararg v:Int) {
        for (vt in v) {
            print(vt)
        }
    }

    // 类型检测及自动类型转换
    /*
    * 使用is运算符检测一个表达式是否某类型的一个实例，
    * */
    fun getStringLength(obj: Any): Int? {
        if (obj is String) {
            // 做过类型判断以后，obj会被系统自动转换为String类型
            return obj.length
        }
        // obj未转换，还是any类型
        return null

//        // 或者
//        if (obj !is String) {
//            return null
//        }
//
//        // 在这个分支中，obj的类型会被转换为String
//        return obj.length
          //或者
//        // 在 `&&` 运算符的右侧, `obj` 的类型会被自动转换为 `String`
//        if (obj is String && obj.length > 0)
//            return obj.length
//        return null
    }
}
