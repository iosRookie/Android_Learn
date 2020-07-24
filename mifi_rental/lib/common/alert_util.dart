import 'package:flutter/material.dart';
import 'package:mifi_rental/dialog/loading.dart';

class AlertUtil {
  static void showNetLoadingDialog(BuildContext context, {String text, bool barrierDismissible = true}) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return LoadingDialog(
            text: 'loading',
          );
        }).then((_) {
    });
  }

  static void dismissNetLoading(BuildContext context) {
    Navigator.pop(context);
  }
}