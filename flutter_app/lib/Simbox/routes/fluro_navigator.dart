import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'application.dart';

class NavigatorUtils {

  static push(BuildContext context, String path,
  {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native);
  }

  static pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native)
        .then((result) {
      if (result == null) return;
      function(result);
    }).catchError((error) {
      print('$error');
    });
  }

  static void pop(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  static void popResult(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

}