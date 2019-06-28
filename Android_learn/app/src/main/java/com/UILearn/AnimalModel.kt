package com.UILearn

data class AnimalModel constructor(val name: String, val aSpeak: String, val aIcon: Int) {
    override fun equals(other: Any?): Boolean {
        return super.equals(other)
    }

    override fun toString(): String {
        return "Animal(name = ${name}, aSpeak = ${aSpeak}, aIcon = ${aIcon})"
    }
}