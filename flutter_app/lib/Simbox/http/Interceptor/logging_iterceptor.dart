import 'package:dio/dio.dart';
import 'package:flutter_app/Simbox/common/util/Log.dart';
import 'package:flutter_app/Simbox/http/http_exception_handle.dart';

class LoggingInterceptor extends Interceptor {
  DateTime _startTime;
  DateTime _endTime;

  @override
  Future onRequest(RequestOptions options) {
    _startTime = DateTime.now();
    Log.d("------start------");
    if (options.queryParameters.isEmpty) {
      Log.i("RequestUrl: " + options.baseUrl + options.path);
    } else {
      Log.i("RequestUrl: " + options.baseUrl + options.path + "?" + Transformer.urlEncodeMap(options.queryParameters));
    }
    Log.d('Method: ' + options.method);
    Log.d('Headers: ' + options.headers.toString());
    Log.d('ContentType: ' + options.contentType);
    Log.d('Data: ' + options.data.toString());
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    _endTime = DateTime.now();
    int duration = _endTime.difference(_startTime).inMilliseconds;
    if (response.statusCode == HTTPExceptionHandle.success) {
      Log.d('HTTPResponseCode: ${response.statusCode}');
    } else {
      Log.e('HTTPResponseCode: ${response.statusCode}');
    }
    Log.json(response.data.toString());
    Log.d("------End: $duration 毫秒------");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    Log.d("------Error: ${err.toString()}------");
    return super.onError(err);
  }
}