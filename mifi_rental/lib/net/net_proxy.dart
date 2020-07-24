import 'dart:convert';

import 'package:core_log/core_log.dart';
import 'package:core_net/net_exception.dart';
import 'package:core_net/net_proxy.dart';
import 'package:mifi_rental/entity/config.dart';
import 'package:mifi_rental/entity/device.dart';
import 'package:mifi_rental/entity/flow_packages.dart';
import 'package:mifi_rental/entity/goods.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/entity/popup.dart';
import 'package:mifi_rental/entity/terminal.dart';
import 'package:mifi_rental/entity/terminal_site.dart';

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
  proxy(String url, String result, String clazz) {
    ULog.i('url:$url --- response: $result');
    if (result != null) {
      Map<String, dynamic> map = jsonDecode(result);
      String resultCode = map['resultCode'];
      if (resultCode != '00000000') {
        String resultDesc = map['resultDesc'];
        throw NetException(
            errorType: ErrorType.RESPONSE,
            message: resultDesc,
            code: resultCode);
      } else {
        var data = map['data'];
        if (data != null && clazz != null) {
          return _parseData(clazz, data);
        } else {
          return data;
        }
      }
    }
    return result;
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
      case 'Config':
        return Config.fromJson(data);
      case 'TerminalSite':
        return TerminalSite.fromJson(data);
      case 'FlowPackageRespond':
        return FlowPackageRespond.fromJson(data);
    }
    return null;
  }
}

class ErrorProxy extends IErrorProxy {
  @override
  proxy(String url, e) {
    if (e is NetException) {
      switch (e.errorType) {
        case ErrorType.SOCKET:
        // 网络异常
          return RetryException('SOCKET', e);
          break;
        case ErrorType.CONNECT_TIMEOUT:
        case ErrorType.RECEIVE_TIMEOUT:
        case ErrorType.SEND_TIMEOUT:
        // 请求超时
          return RetryException('TIMEOUT', e);
          break;
        case ErrorType.CANCEL:
        // 取消请求
          return RetryException('CANCEL', e);
          break;
        case ErrorType.RESPONSE:
        // 服务异常
          return RetryException('SERVICE_EXCEPTION', e);
          break;
        default:
          return RetryException('UNKNOWN', e);
      }
    }
    return e;
  }
}
