import 'package:flutter/material.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';

class LoadingDialog extends Dialog {
  final String text;

  const LoadingDialog({this.text});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List();
    widgets.add(CircularProgressIndicator(
      backgroundColor: Colors.grey,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    ));
    if (text != null) {
      widgets.add(Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            text,
            style: TextStyle(
                fontSize: sp_12,
                color: color_text_999999,
                decoration: TextDecoration.none),
          )));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }
}
