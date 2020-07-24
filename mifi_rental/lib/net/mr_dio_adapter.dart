import 'dart:io';

import 'package:core_log/core_log.dart';
import 'package:core_net/core_net.dart';
import 'package:core_net/net_exception.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MRDioAdapter extends INetAdapter {
  Dio _dio;

  MRDioAdapter(this._dio);

  @override
  Future<String> request(HttpMethod method, String url,
      {Map<String, dynamic> params,
        Map<String, dynamic> headers,
        extra}) async {
    if (extra is Map) {
      RequestOptions options;
      if (extra.containsKey("options")) {
        options = extra["options"];
      }
      CancelToken cancelToken;
      if (extra.containsKey("cancelToken")) {
        cancelToken = extra[cancelToken];
      }
      Response response = await _dio.request(url,
          queryParameters: params,
          options: _checkOptions(HttpMethodValues[method], headers,
              options: options),
          cancelToken: cancelToken);
      return response.data.toString();
    }
    Response response = await _dio.request(url,
        data: params,
        options: _checkOptions(HttpMethodValues[method], headers));
    return response.data.toString();
  }

  Options _checkOptions(method, Map headers, {Options options}) {
    if (options == null) {
      options = new Options();
    }
    if (headers != null) {
      options.headers.addAll(headers);
    }
    options.method = method;
    return options;
  }

  @override
  dynamic handleError(dynamic e) {
    if (e is DioError) {
      ULog.e("net error ===>  " + e.request.baseUrl + " " + e.message);
      Fluttertoast.showToast(msg: e.message, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
      switch (e.type) {
        case DioErrorType.DEFAULT:
          if(e.error is SocketException){
            return  NetException(errorType: ErrorType.SOCKET, message: e.message, e: e);
          }else{
            return NetException(
                errorType: ErrorType.UNKNOWN, message: e.message, e: e);
          }
          break;
        case DioErrorType.CANCEL:
          {
            return NetException(
                errorType: ErrorType.CANCEL, message: "请求取消", e: e);
          }
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          {
            return NetException(
                errorType: ErrorType.CONNECT_TIMEOUT, message: "连接超时", e: e);
          }
          break;
        case DioErrorType.SEND_TIMEOUT:
          {
            return NetException(
                errorType: ErrorType.SEND_TIMEOUT, message: "请求超时", e: e);
          }
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          {
            return NetException(
                errorType: ErrorType.RECEIVE_TIMEOUT, message: "响应超时", e: e);
          }
          break;
        case DioErrorType.RESPONSE:
          {
            try {
              String errMsg = e.response.toString();
              return NetException(errorType: ErrorType.RESPONSE, message: errMsg);
            } on Exception catch (_) {
              return NetException(errorType: ErrorType.UNKNOWN, message: "未知错误", e: e);
            }
          }
          break;
        default:
          {
            return NetException(errorType: ErrorType.UNKNOWN, message: e.message, e: e);
          }
      }
    }
    else {
      ULog.e("net error ===>" + e.toString());
    }
    return e;
  }
}