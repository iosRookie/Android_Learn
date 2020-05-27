import 'dart:convert';

import 'package:core_log/core_log.dart';
import 'package:core_net/net_exception.dart';
import 'package:core_net/net_proxy.dart';
import 'package:mifi_rental/entity/device.dart';
import 'package:mifi_rental/entity/goods.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/entity/popup.dart';
import 'package:mifi_rental/entity/terminal.dart';

class RequestProxy extends IRequestProxy {
  @override
  Map<String, dynamic> proxy(Map<String, dynamic> requests) {
    String params = jsonEncode(requests["params"]);
    String headers = jsonEncode(requests["headers"]);
    String url = jsonEncode(requests["url"]);
    ULog.i('url:$url --- request headers:$headers --- request params:$params');
    return requests;
  }
}

class ResponseProxy extends IResponseProxy {
  @override
  proxy(String url, String data, String clazz) {
    ULog.i('url:$url --- response: $data');
    if (data != null) {
      Map<String, dynamic> map = jsonDecode(data);
      String resultCode = map['resultCode'];
      if (resultCode != '00000000') {
        String resultDesc = map['resultDesc'];
        throw NetException(errorType: ErrorType.RESPONSE, message: resultDesc);
      } else {
        if (clazz != null) {
          return _parseData(clazz, map['data']);
        } else {
          return map['data'];
        }
      }
    }
    return data;
  }

  dynamic _parseData(String clazz, data) {
    if (data is List) {
      var list = List();
      data.forEach((item) {
        list.add(_generateOBJ(clazz, item));
      });
      return list;
    } else {
      return _generateOBJ(clazz, data);
    }
  }

  dynamic _generateOBJ(String clazz, data) {
    switch (clazz) {
      case 'Order':
        return Order.fromJson(data);
      case 'Popup':
        return Popup.fromJson(data);
      case 'Device':
        return Device.fromJson(data);
      case 'Goods':
        return Goods.fromJson(data);
      case 'Terminal':
        return Terminal.fromJson(data);
    }
    return null;
  }
}

class ErrorProxy extends IErrorProxy {
  @override
  proxy(String url, e) {
    if (e is NetException) {
      ULog.i('url:$url --- error:${e.message}');
      if (e.errorType == ErrorType.TIMEOUT) {
        return RetryException('TIMEOUT', e);
      }
    } else {
      ULog.i('url:$url --- error:$e');
    }
    return e;
  }
}
