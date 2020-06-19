import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';

class TipsDialog {
  Future<T> show<T>(BuildContext context, String tip) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          List<Widget> actions = List();
          actions.add(FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              MyLocalizations.of(context).getString(confirm),
            ),
          ));
          return AlertDialog(
            actions: actions,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  MyLocalizations.of(context).getString(tips),
                  style: TextStyle(
                      fontSize: sp_16,
                      color: color_text_333333,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: dp_frame, right: dp_frame, top: dp_frame),
                  child: Text(
                    tip,
                    style: TextStyle(fontSize: sp_14, color: color_text_333333),
                  ),
                )
              ],
            ),
          );
        });
  }
}
