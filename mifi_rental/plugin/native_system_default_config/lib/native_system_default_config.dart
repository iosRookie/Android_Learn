import 'dart:async';

import 'package:flutter/services.dart';

class NativeSystemDefaultConfig {
  static const MethodChannel _channel =
      const MethodChannel('native_system_default_config');
  
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Map<String,String>> get nativeDefaultLanguage async {
    final Map<String, String> local = await _channel.invokeMapMethod('getNativeDefaultLanguage');
    return local;
  }
}
