import 'package:core_net/net_exception.dart';
import 'package:flutter/material.dart';
import 'package:mifi_rental/dialog/loading.dart';

abstract class BaseProvider {
  BuildContext context;
  GlobalKey<ScaffoldState> globalKey;
  var isShowLoading = false;

  void init();

  void handleError(error) {
    if (error is NetException) {
      if (globalKey != null) {
        globalKey.currentState
            .showSnackBar(SnackBar(content: new Text(error.message)));
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