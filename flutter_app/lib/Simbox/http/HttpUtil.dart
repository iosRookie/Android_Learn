import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/Simbox/common/util/Log.dart';
import 'package:flutter_app/Simbox/http/HTTPResponseEntity.dart';
import 'package:flutter_app/Simbox/http/HTTPExceptionHandle.dart';
import 'package:flutter_app/Simbox/http/Interceptor/LoggingIterceptor.dart';
import 'package:rxdart/rxdart.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  Dio _httpClient;

  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    if (null == _httpClient) {
      BaseOptions options = BaseOptions();
      options.baseUrl = "http://124.89.116.203:10005";
      /// Timeout in milliseconds for opening url.
      options.connectTimeout = 30 * 1000;
      ///  Timeout in milliseconds for receiving data.
//      options.receiveTimeout = 5 * 1000;
      /// Timeout in milliseconds for sending data.
//      options.sendTimeout = 15 * 1000;

      options.responseType = ResponseType.plain;
      options.receiveDataWhenStatusError = true;

      options.headers.addAll(
          {"Accept-Language" : "zh-CN",
            "App-Version" : "1.8.00",
            "User-Agent" : "GlocalmeCall/1.8.00 (iPhone; iOS 10.3.3; Scale/2.00)",
            "userLabel" : "businessUser",
            "voipId" : ""});
      _httpClient = Dio(options);

      //代理
//      (_httpClient.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//        (HttpClient client) {
//      client.findProxy = (uri) {
//        //proxy all request to localhost:8888
//        return "PROXY 192.168.1.121:8080";
//      };
//      client.badCertificateCallback =
//          (X509Certificate cert, String host, int port) => true;
//    };

      _httpClient.interceptors.add(LoggingInterceptor());    //添加请求打印拦截器
    }
  }

  // 数据返回格式统一，统一处理异常
  Future<HTTPResponseEntity<T>> _request<T>(String method, String url, {
    dynamic data, Map<String, dynamic> queryParameters,
    CancelToken cancelToken, Options options
  }) async {
    var response = await _httpClient.request(url, data: data, queryParameters: queryParameters, options: _checkOptions(method, options), cancelToken: cancelToken);
    try {
      /// 集成测试无法使用 isolate
//      Map<String, dynamic> _map = Constant.isTest ? parseData(response.data.toString()) : await compute(parseData, response.data.toString());
      Map<String, dynamic> _map = parseData(response.data.toString());
      return HTTPResponseEntity<T>.fromJson(_map);
    } catch(e) {
      print(e);
      return HTTPResponseEntity(HTTPExceptionHandle.parse_error.toString(), "数据解析错误");
    }
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Future requestNetwork<T>(Method method, String url, {
    Function(T t) onSuccess,
    Function(List<T> list) onSuccessList,
    Function(String code, String msg) onError,
    dynamic params, Map<String, dynamic> queryParameters,
    CancelToken cancelToken, Options options, bool isList : false
  }) async {
    String m = _getRequestMethod(method);
    return await _request<T>(m, url,
        data: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken).then((HTTPResponseEntity<T> result){
      if (result.resultCode == "00000000"){
        if (isList){
          if (onSuccessList != null){
            onSuccessList(result.listData);
          }
        }else{
          if (onSuccess != null){
            onSuccess(result.data);
          }
        }
      }else{
        _onError(result.resultCode, result.resultDesc, onError);
      }
    }, onError: (e, _){
      _cancelLogPrint(e, url);
      NetError error = HTTPExceptionHandle.handleException(e);
      _onError(error.code.toString(), error.msg, onError);
    });
  }

  /// 统一处理(onSuccess返回T对象，onSuccessList返回List<T>)
  void asyncRequestNetwork<T>(Method method, String url, {
    Function(T t) onSuccess,
    Function(List<T> list) onSuccessList,
    Function(String code, String msg) onError,
    dynamic params, Map<String, dynamic> queryParameters,
    CancelToken cancelToken, Options options, bool isList : false
  }){
    String m = _getRequestMethod(method);
    Observable.fromFuture(_request<T>(m, url, data: params, queryParameters: queryParameters, options: options, cancelToken: cancelToken))
        .asBroadcastStream()
        .listen((result){
      if (result.resultCode == "00000000"){
        if (isList){
          if (onSuccessList != null){
            onSuccessList(result.listData);
          }
        }else{
          if (onSuccess != null){
            onSuccess(result.data);
          }
        }
      }else{
        _onError(result.resultCode, result.resultDesc, onError);
      }
    }, onError: (e){
      _cancelLogPrint(e, url);
      NetError error = HTTPExceptionHandle.handleException(e);
      _onError(error.code.toString(), error.msg, onError);
    });
  }

  _cancelLogPrint(dynamic e, String url){
    if (e is DioError && CancelToken.isCancel(e)){
      Log.i("取消请求接口： $url");
    }
  }

  _onError(String code, String msg, Function(String code, String msg) onError){
    if (code == null){
      code = HTTPExceptionHandle.unknown_error.toString();
      msg = "未知异常";
    }
    Log.e("接口请求异常： code: $code, mag: $msg");
    if (onError != null) {
      onError(code, msg);
    }
  }

  String _getRequestMethod(Method method){
    String m;
    switch(method){
      case Method.get:
        m = "GET";
        break;
      case Method.post:
        m = "POST";
        break;
      case Method.put:
        m = "PUT";
        break;
      case Method.patch:
        m = "PATCH";
        break;
      case Method.delete:
        m = "DELETE";
        break;
      case Method.head:
        m = "HEAD";
        break;
    }
    return m;
  }
}

Map<String, dynamic> parseData(String data){
  return json.decode(data);
}

enum Method {
  get,
  post,
  put,
  patch,
  delete,
  head
}