import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';

class ReturnDialog {
  Future<T> show<T>(BuildContext context, Order order) {
    var usedTm = order.usedTmStr.split("|");
    var usedTmStr =
        '${usedTm[0]}${MyLocalizations.of(context).getString(hours)} ${usedTm[1]}${MyLocalizations.of(context).getString(minutes)}';
    var shouldPay =
        '${order.currencyCode} ${(order.shouldPay / 100).toStringAsFixed(2)}';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                    child: Text(
                  MyLocalizations.of(context).getString(return_success),
                  style: TextStyle(
                      fontSize: sp_16,
                      color: color_text_333333,
                      fontWeight: FontWeight.bold),
                )),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      '${MyLocalizations.of(context).getString(lease_duration)}: $usedTmStr',
                      style:
                          TextStyle(fontSize: sp_14, color: color_text_333333),
                    )),
                Text(
                  '${MyLocalizations.of(context).getString(buckle_amount)}: $shouldPay',
                  style: TextStyle(fontSize: sp_14, color: color_text_333333),
                )
              ],
            ),
          );
        });
  }
}
