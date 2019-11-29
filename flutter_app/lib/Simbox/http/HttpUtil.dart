import 'dart:io';

import 'package:dio/dio.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  Dio _httpClient;

  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    if (null == _httpClient) {
      BaseOptions options = BaseOptions();
      options.baseUrl = "http://124.89.116.203:10005";
      /// Timeout in milliseconds for opening url.
      options.connectTimeout = 15 * 1000;
      ///  Timeout in milliseconds for receiving data.
      options.receiveTimeout = 5 * 1000;
      /// Timeout in milliseconds for sending data.
      options.sendTimeout = 15 * 1000;

//      options.contentType = ContentType.JSON;
      options.responseType = ResponseType.plain;
      options.receiveDataWhenStatusError = true;

      options.headers.addAll(
          {"Accept-Language" : "zh-CN",
            "App-Version" : "1.8.00",
            "User-Agent" : "GlocalmeCall/1.8.00 (iPhone; iOS 10.3.3; Scale/2.00)",
            "userLabel" : "businessUser",
            "voipId" : ""});
      _httpClient = Dio(options);
//      _httpClient.interceptors.add();    //添加拦截器
    }
  }

  Future<Response> get(String path, Map<String, dynamic> params) async {
    Response response = null == params ? await _httpClient.get(path) : await _httpClient.get(path, queryParameters: params);
    return response;
  }

  Future<Response> post(String path, Map<String, dynamic> params) async {
    Response response = null == params ? await _httpClient.post(path) : await _httpClient.post(path, queryParameters: params);
    return response;
  }

}