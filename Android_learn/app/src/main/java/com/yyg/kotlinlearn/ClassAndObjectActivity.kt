package com.yyg.kotlinlearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import com.example.myapplication.R
import kotlin.reflect.KProperty

// 类的修饰符
/*
* classModifier 类修饰语
*   abstract   抽象类
*   final      不可继承，默认属性
*   enum       枚举类
*   open       科技城。默认是final的
*   annotation 注解类
*
* accessModifier 权限修饰语
*   private     仅在同一文件中可见
*   protected   同一文件或子类可见
*   public      所有调用的地方都可见
*   internal    同一模块中可见
* */

class Car {
    var color: String? = null
    var type: String? = null
    var brand: String? = null
}

class Person constructor(firstName: String, secondName: String, age: Int = 20) {  // 主构造器 只能有一个 可以默认值
    var firstName = firstName
        get() = field.toUpperCase()
        set(value) {
            field = "ddd"
        }

    var secondName = secondName
        get() = field
        set

    var age = age
        get() = field
        set(value) {
            if (value in 1..100) {
             field = value
            } else {
                field = 100
            }
        }

    var address: String = "xian"
        private set

    lateinit var mayCar: Car
        fun setup() {
             mayCar = Car()
        }

    init {

    }

    // 次构造器，可以有多个，次构造器必须直接或间接的代理主构造器，关键字this
    // 如果一个非抽象类没有声名构造函数，会自动产生一个没有参数的构造器。构造函数是public，如果不想类有公有构造函数，需要声明一个空的主构函数
    constructor(secondName: String):this("aaa", secondName, 35) {
        this.address = "beijing"
    }
}

// 嵌套类
class Outer {               // 外部类
    private val bar = 1
    class Nested {          // 嵌套类
        fun foo() = 2
    }
}

// 内部类
/*
* 内部类使用inner关键字来表示
* 内部类会有一个对外部类的对象引用，所以内部类可以访问外部类的成员属性和成员函数
* */
class OuterInner {
    private val bar = 1
    var v = "成员属性"
    inner class Inner {
        fun foo() = bar // 访问外部类成员
        fun innerTest() {
            // 获取外部类的成员变量
            var o = this@OuterInner   // 为了区别this 加上@OuterInner，说明这个this是OuterInner
            Log.d("ClassAndObject", "内部类可以引用外部类的成员，例如：${o.v}")
        }
    }
}

// 匿名内部类
class Test {
    var v = "成员属性"
    fun <T: TestInterFace>setInterFace(test: T) {
        test.test()
    }
}
// 接口
interface TestInterFace {
    fun test()
}

class ClassAndObjectActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_class_and_object)

        var person1 = Person("aaa", "bc", 305)
        Log.d("ClassAndObject","person1 name = ${person1.firstName + person1.secondName}, age = ${person1.age}, address = ${person1.address}")

        var person2 = Person("gggg")
        Log.d("ClassAndObject","person2 name = ${person2.firstName + person2.secondName}, age = ${person2.age}, address = ${person2.address}")

        var test:Test = Test()
        // 采用对象表达式来创建接口对象，即匿名内部类的实例
//        test.setInterFace(object : TestInterFace {
//            override fun test() {
//               Log.d("ClassAndObject", "对象表达式创建匿名内部类的实例")
//            }
//        })

        // 嵌套类和内部类区别
        // 1.嵌套类在生成内部类对象时不需要先生成外部类队象，内部类在创建内部类对象时需要先创建外部类对象
        val outer1 = Outer.Nested()               // 嵌套类
        val outerInner = OuterInner().Inner()     // 内部类
        // 2.引用外部类成员变量时嵌套内部类需要先生成一个外部类对象，内部类不需要。因为内部类会带有一个对外部类的对象的引用，即对象-对一

        val good1 = Goods(Apple())
        val good2 = Goods(Pear())
        Goods.comparePrice(good1, good2)

        val b = BaseInterfaceImpl(10)
        val de = DerivedInterface(b)
        de.print()
        println(de.message)

        val e = Example()
        println(e.p)
        e.p = "NEW"

        val lazyValue: String by lazy(LazyThreadSafetyMode.SYNCHRONIZED) {
            println("computed!")
            "holle"
        }
        println(lazyValue)
        println(lazyValue)
    }
}

open class Base(val name: String) {
    init { println("Initializing Base")}

    open val size: Int = name.length.also {
        println("Initializing size in Base : $it")
    }
}

class Derived(name: String, private val lastName: String) : Base(name.capitalize().also { println("Argument for Base $it") }) {
    init {
        println("Initializing Derived")
    }

    override val size: Int
        get() = (super.size + lastName.length).also { println("Initializing size in Derived $it") }
}

interface IA {
    var aaa: Int
    fun foo(){}
    fun bar()
}

interface IB {
    fun foo(){}
    fun bar()
}

class IC : IA, IB {
    override var aaa: Int = 1
        get() = field
        set(value) { field = value }

    override fun foo() {
        super<IA>.foo()
        super<IB>.foo()
    }

    override fun bar() {

    }
}

open class Food(var name: String, var price: Float) {

}



class Goods<out T:Food>(good: T) {
    val god = good
    companion object {
        fun <T>comparePrice(good: Goods<T>, good2: Goods<T>) : Boolean where T : Food {
            return good.god.price > good2.god.price
        }
    }
}

class Apple() : Food("apple", 12.5f) {

}

class Pear() : Food("pear", 10.0f) {

}

interface BaseInterface {
    val message: String
    fun print()
}

class BaseInterfaceImpl(val x: Int) : BaseInterface {
    override val message: String = "BaseImpl: x = $x"
    override fun print() {
        println(message)
    }
}

class DerivedInterface(b: BaseInterface) : BaseInterface by b {
    override val message: String = "Message of Derived"
}

class Example {
    var p: String by Delegate()
}

class Delegate {
    operator fun getValue(thisRef: Any?, property: KProperty<*>): String {
        return "$thisRef, thank you for delegating '${property.name}' to me!"
    }

    operator fun setValue(thisRef: Any?, property: KProperty<*>, value: String) {
        println("$value has been assigned to '${property.name}' in $thisRef.")
    }
}