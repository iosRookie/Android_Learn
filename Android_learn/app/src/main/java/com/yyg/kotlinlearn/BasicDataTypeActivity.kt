package com.yyg.kotlinlearn

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.example.myapplication.R
import java.lang.IllegalArgumentException

class BasicDataTypeActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_basic_data_type)

        // kotlin支持Byte、Short、Int、Long、Float、Double等，但是字符不属于数值类型，是一个独立的数据类型
        // kotlin中没有基础类型，只有封装的数字类型，你没定义一个变量，kotlin帮你封装了一个对象，这样保证不会出现空指针
        // 所以在比较两个数字的时候，就存在对象相同或者数值大小相同 == 表示值相等  === 表示对象地址相等，即同一对象

        // 十进制：123
        // 长整型以大写的 L 结尾：123L
        // 16 进制以 0x 开头：0x0F
        // 2 进制以 0b 开头：0b00001011
        // 注意：8进制不支持

        // Doubles 默认写法: 123.5, 123.5e10
        // Floats 使用 f 或者 F 后缀：123.5f
        // 支持下划线分割
        val oneMillion = 1_000_000
        val creditCardNumber = 1234_5678_9012_3456L
        val socialSecurityNumber = 999_99_9999L
        val hexBytes = 0xFF_EC_DE_5E
        val bytes = 0b11010010_01101001_10010100_10010010

        // 类型转换
        /*
        * 由于不同的表达方式，较小的类型并不较大类型的自类型，较小的类型不能隐式转换为较大类型
        * 各类型都提供了显式的转换方法
        * toByte(): Byte
        * toShort(): Short
        * toInt(): Int
        * toLong(): Long
        * toFloat(): Float
        * toDouble(): Double
        * toChar(): Char
        * */

        // 位操作符
        1.shl(1) // 1向左移一位
        1.shr(1) // 1向右移一位
        1.ushr(1) // 1无符号向右移一位
        1.and(1) // 1与1
        1.or(1) // 1或1
        1.xor(1) // 1异或1
        1.inv() // 1反向

        //字符
        /*
        * Kotlin中 Char 不能直接和数字操作，Char必须是单引号'包起来的
        * 特殊字符可以用反斜杠转义
        * \t、 \b、 \n、 \r、 \'、 \"、 \\、 \$
        * 编码其他字符要用Unicode转义序列语法：'\uFF00'
        * */
    }

    // 字符转Int类型
    // 当需要可空引用时，像数字、字符会被装箱。装箱操作不会保留同一性。            不太明白啥意思
    fun decimalDigitValue(c: Char): Int {
        if (c !in '0'..'9') throw IllegalArgumentException("Out of range")
        return c.toInt() - '0'.toInt() // 显式转换为数字
    }
}
