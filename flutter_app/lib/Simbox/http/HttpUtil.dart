import 'package:dio/dio.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  Dio _httpClient;

  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    if (null == _httpClient) {
      BaseOptions options = BaseOptions();
      options.baseUrl = "https://voip-tsm.ucloudlink.com";
      /// Timeout in milliseconds for opening url.
      options.connectTimeout = 15 * 1000;
      ///  Timeout in milliseconds for receiving data.
      options.receiveTimeout = 5 * 1000;
      /// Timeout in milliseconds for sending data.
      options.sendTimeout = 15 * 1000;
      _httpClient = Dio(options);
    }
  }

  Future<Response>get(String path, [Map<String, dynamic> params]) async {
    Response response = null == params ? await _httpClient.get(path) : await _httpClient.get(path, queryParameters: params);
    return response;
  }

  Future<Response>post(String path, [Map<String, dynamic> params]) async {
    Response response = null == params ? await _httpClient.post(path) : await _httpClient.post(path, queryParameters: params);
    return response;
  }

}