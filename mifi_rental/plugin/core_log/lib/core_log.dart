import 'dart:async';
import 'dart:collection';

import 'package:flutter/services.dart';

class ULog {
  static const MethodChannel _channel = const MethodChannel('core_log');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static v(String message, {String tag}) {
    _log(LogLevel.VERBOSE, message);
  }

  static d(String message, {String tag}) {
    _log(LogLevel.DEBUG, message, tag: tag);
  }

  static i(String message, {String tag}) {
    _log(LogLevel.INFO, message, tag: tag);
  }

  static w(String message, {String tag}) {
    _log(LogLevel.WARN, message, tag: tag);
  }

  static e(String message, {String tag}) {
    _log(LogLevel.ERROR, message, tag: tag);
  }

  static a(String message, {String tag}) {
    _log(LogLevel.ASSERT, message, tag: tag);
  }

  static void _log(LogLevel level, String message, {String tag}) {
    String stackStr = StackTrace.current.toString();
    if (tag == null || tag.isEmpty) {
      List<String> tags = stackStr
          .substring(stackStr.indexOf("#2") + 2, stackStr.indexOf("#3"))
          .split("(");
      if (tags.length == 2) {
        tag =
            "${tags[0].trim().replaceAll(".", "#")}${tags[1].substring(tags[1].lastIndexOf("/"), tags[1].lastIndexOf(")"))}";
      }
    }
    HashMap map = new HashMap<String, String>();
    map["message"] = message;
    if (tag != null) {
      map["tag"] = tag;
    }
    switch (level) {
      case LogLevel.VERBOSE:
        _channel.invokeMethod("v", map);
        break;
      case LogLevel.DEBUG:
        _channel.invokeMethod("d", map);
        break;
      case LogLevel.INFO:
        _channel.invokeMethod("i", map);
        break;
      case LogLevel.WARN:
        _channel.invokeMethod("w", map);
        break;
      case LogLevel.ERROR:
        _channel.invokeMethod("e", map);
        break;
      case LogLevel.ASSERT:
        _channel.invokeMethod("a", map);
        break;
      default:
        break;
    }
  }
}

enum LogLevel { VERBOSE, DEBUG, INFO, WARN, ERROR, ASSERT }
