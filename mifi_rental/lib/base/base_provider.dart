import 'package:core_net/net_exception.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifi_rental/dialog/loading.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/res/strings.dart';

abstract class BaseProvider {
  BuildContext context;
  GlobalKey<ScaffoldState> globalKey;
  var isShowLoading = false;

  void init();

  // UNKNOWN, CONNECT_TIMEOUT, RECEIVE_TIMEOUT, SEND_TIMEOUT, CANCEL, SOCKET, RESPONSE
  void handleError(error) {
    if (error is NetException) {
        switch (error.errorType) {
          case ErrorType.SOCKET:
            Fluttertoast.showToast(
                msg: MyLocalizations.of(context).getString(network_exceptions),
                gravity: ToastGravity.CENTER
            );
            break;
          case ErrorType.CONNECT_TIMEOUT:
          case ErrorType.RECEIVE_TIMEOUT:
          case ErrorType.SEND_TIMEOUT:
            Fluttertoast.showToast(
                msg: "连接超时",
                gravity: ToastGravity.CENTER
            );
            break;
          case ErrorType.CANCEL:
            // 取消请求
            break;
          case ErrorType.RESPONSE:
            // 服务异常
            Fluttertoast.showToast(
                msg: "服务异常 + ${error.code}  + " " + ${error.message}",
                gravity: ToastGravity.CENTER
            );
            break;
          default:
            Fluttertoast.showToast(
                msg: "${error.code}  + " " + ${error.message}",
                gravity: ToastGravity.CENTER
            );
        }
    }
  }

  void showLoading({String text, bool barrierDismissible = true}) {
    if (!isShowLoading) {
      isShowLoading = true;
      showDialog(
          barrierDismissible: barrierDismissible,
          context: context,
          builder: (BuildContext context) {
            return LoadingDialog(
              text: 'loading',
            );
          }).then((_) {
        isShowLoading = false;
      });
    }
  }

  void dismissLoading() {
    if (isShowLoading) {
      Navigator.pop(context);
    }
  }
}
