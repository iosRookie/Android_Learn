import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  factory SharedPreferenceUtil() => _getInstance();
  static SharedPreferenceUtil _instance;
  static Locale _nativeDefaultLocale;

  SharedPreferenceUtil._internal();
  static SharedPreferenceUtil _getInstance() {
    if (_instance == null) {
      _instance = new SharedPreferenceUtil._internal();
    }
    return _instance;
  }

  static saveNativeLocal(Map map) {
    _nativeDefaultLocale = Locale(map["languageCode"], map["countryCode"]);
  }

  static Locale get nativeLocal => SharedPreferenceUtil._nativeDefaultLocale;

  static Future<String> getLoginCustomId() async {
    String id = await SharedPreferenceUtil.getString("loginCustomId");
    if (id == null) {
      String alphabet = '0123456789qwertyuiopasdfghjklzxcvbnm';
      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < 30; i++) {
        buffer.write(alphabet[Random().nextInt(alphabet.length)]);
      }
      id = buffer.toString();
      await SharedPreferenceUtil.setString("loginCustomId", id);
    }
    return id;
  }

  static Future<bool> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<bool> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> setDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setDouble(key, value);
  }

  static Future<double> getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<bool> setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(key, value);
  }

  static Future<List<String>> getStringList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  static Future<bool> containsKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<bool> clear(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
