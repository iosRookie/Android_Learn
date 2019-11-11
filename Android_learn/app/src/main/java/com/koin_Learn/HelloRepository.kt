package com.koin_Learn

//import org.koin.dsl.module
//
//interface HelloRepository {
//    fun giveHello(): String
//}
//
//class HelloRepositoryImpl() : HelloRepository {
//    override fun giveHello() = "Hello Koin"
//}
//
//class MySimplePresenter(private val repo: HelloRepository) {
//    fun sayHello() = "${repo.giveHello()} from $this"
//}
//
//val appModule = module {
//    single<HelloRepository> { HelloRepositoryImpl() }
//
//    factory { MySimplePresenter(get()) }
//}