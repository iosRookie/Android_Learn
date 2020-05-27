library core_net;

import 'dart:collection';

import 'package:core_net/net_exception.dart';
import 'package:core_net/net_proxy.dart';
import 'package:rxdart/rxdart.dart';

import 'net_configurator.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

abstract class INetAdapter {
  Future<String> request(HttpMethod method, String url,
      {Map<String, dynamic> params, Map<String, dynamic> headers, extra});

  dynamic handleError(dynamic e);
}

class NetClient {
  static const DEFAULT_RETRY_TIMES = 3;
  static const DEFAULT_DELAY_SEC = 3;

  final INetAdapter _adapter =
      NetConfigurator.singleton.getConfiguration(Config.ADAPTER);

  final IRequestProxy _requestProxy =
      NetConfigurator.singleton.getConfiguration(Config.REQUEST_PROXY);

  final IResponseProxy _responseProxy =
      NetConfigurator.singleton.getConfiguration(Config.RESPONSE_PROXY);

  final IErrorProxy _errorProxy =
      NetConfigurator.singleton.getConfiguration(Config.ERROR_PROXY);

  HashMap<String, int> retryMap = HashMap();

  void post<T>(String url,
      {Map<String, dynamic> params,
      Map<String, dynamic> headers,
      extra,
      Function success,
      Function(dynamic) error}) {
    _request(HttpMethod.POST, url,
        params: params,
        headers: headers,
        extra: extra,
        success: success,
        error: error,
        cls: T.toString());
  }

  void get<T>(String url,
      {Map<String, dynamic> params,
      Map<String, dynamic> headers,
      extra,
      Function success,
      Function(dynamic) error}) {
    _request(HttpMethod.GET, url,
        params: params,
        headers: headers,
        extra: extra,
        success: success,
        error: error,
        cls: T.toString());
  }

  void put<T>(String url,
      {Map<String, dynamic> params,
      Map<String, dynamic> headers,
      extra,
      Function success,
      Function(dynamic) error}) {
    _request(HttpMethod.PUT, url,
        params: params,
        headers: headers,
        extra: extra,
        success: success,
        error: error,
        cls: T.toString());
  }

  void delete<T>(String url,
      {Map<String, dynamic> params,
      Map<String, dynamic> headers,
      extra,
      Function success,
      Function(dynamic) error}) {
    _request(HttpMethod.DELETE, url,
        params: params,
        headers: headers,
        extra: extra,
        success: success,
        error: error,
        cls: T.toString());
  }

  void _request(HttpMethod method, String url,
      {Map<String, dynamic> params,
      Map<String, dynamic> headers,
      extra,
      Function success,
      Function(dynamic) error,
      String cls}) {
    if (_requestProxy != null) {
      var result = _requestProxy
          .proxy({"url": url, "params": params, "headers": headers});
      url = result["url"];
      params = result["params"];
      headers = result["headers"];
    }

    Rx.retryWhen(
        () => Stream.fromFuture(_adapter.request(method, url, params: params))
                .map((data) {
              return _responseProxy?.proxy(
                      url, data, cls == "dynamic" ? null : cls) ??
                  data;
            }).onErrorResume((e) {
              var error = _adapter.handleError(e) ?? e;
              return Stream.error(_errorProxy?.proxy(url, error) ?? error);
            }), (e, s) {
      if (e is RetryException) {
        int retryTimes = retryMap[e.retryKey] ?? 0;
        retryMap[e.retryKey] = ++retryTimes;
        if (retryTimes <= (e.maxRetryTimes ?? DEFAULT_RETRY_TIMES)) {
          return Rx.timer(
              null, Duration(seconds: e.delaySec ?? DEFAULT_DELAY_SEC));
        } else {
          return Stream.error(e.e);
        }
      }
      return Stream.error(e);
    }).listen((result) {
      if (success != null) {
        success(result);
      }
    }, onError: (e) {
      if (error != null) {
        if (e is RetryError && e.errors.length > 0) {
          var realError = e.errors[e.errors.length - 1].error;
          error(realError);
        } else {
          error(e);
        }
      }
    });
  }
}

enum HttpMethod { GET, POST, DELETE, PUT }

const HttpMethodValues = {
  HttpMethod.GET: "GET",
  HttpMethod.POST: "POST",
  HttpMethod.DELETE: "DELETE",
  HttpMethod.PUT: "PUT"
};
