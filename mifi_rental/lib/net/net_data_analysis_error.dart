import 'package:core_net/net_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/res/strings.dart';

class NetDataAnalysisError {
  static void showErrorToast(NetException error, BuildContext context) {
    if (error.message != null && error.message.length > 0) {
      _show(error.message);
    } else {
      int code = -1;
      switch (error.code) {
        case '00000003':
          code = e00000003;
          break;
        case '00000006':
          code = e00000006;
          break;
        case '00000007':
          code = e00000007;
          break;
        case '00000008':
          code = e00000008;
          break;
        case '00000022':
          code = e00000022;
          break;
        case '00000023':
          code = e00000023;
          break;
        case '00000024':
          code = e00000024;
          break;
        case '00000025':
          code = e00000025;
          break;
        case '00000026':
          code = e00000026;
          break;
        case '00000027':
          code = e00000027;
          break;
        case '00000028':
          code = e00000028;
          break;
        case '00000029':
          code = e00000029;
          break;
        case '00000030':
          code = e00000030;
          break;
        case '00000031':
          code = e00000031;
          break;
        case '00000032':
          code = e00000032;
          break;
        case '00000044':
          code = e00000044;
          break;
        case '00000045':
          code = e00000045;
          break;
        case '00000046':
          code = e00000046;
          break;
        case '00000047':
          code = e00000047;
          break;
        case '99999999':
          code = e99999999;
          break;
        case '02000100':
          code = e02000100;
          break;
        case '02000101':
          code = e02000101;
          break;
        case '02000102':
          code = e02000102;
          break;
        case '02000103':
          code = e02000103;
          break;
        case '02000104':
          code = e02000104;
          break;
        case '02000105':
          code = e02000105;
          break;
        case '02000106':
          code = e02000106;
          break;
        case '02000200':
          code = e02000200;
          break;
        case '02000201':
          code = e02000201;
          break;
        case '02000202':
          code = e02000202;
          break;
        case '02000300':
          code = e02000300;
          break;
        case '02000301':
          code = e02000301;
          break;
        case '02000302':
          code = e02000302;
          break;
        default:
          break;
      }
      if (code == -1) {
        _show(error.code);
      } else {
        _show("E->" + MyLocalizations.of(context).getString(code));
      }
    }
  }

  static _show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
    );
  }
}