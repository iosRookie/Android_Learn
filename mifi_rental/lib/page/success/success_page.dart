import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/base/base_page.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:mifi_rental/util/route_util.dart';

class SuccessPage extends BasePage {
  final Order order;
  SuccessPage(this.order);

  @override
  Widget doBuild(BuildContext context, Widget scaffold) {
    return scaffold;
  }

  @override
  List<BaseProvider> setProviders() {
    return null;
  }

  @override
  PreferredSizeWidget setAppbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        MyLocalizations.of(context).getString(rent_success),
        style: TextStyle(fontSize: sp_title),
      ),
      centerTitle: true,

//      leading: GestureDetector(
//          onTap: () {
////            FlutterBoost.singleton.closeCurrent();
//          },
//          child: Icon(
//            Icons.arrow_back_ios,
//            color: color_bg_333333,
//          )),
    );
  }

  @override
  Widget setBody(BuildContext context) {
    return WillPopScope(
      child:ListView(
        padding: EdgeInsets.fromLTRB(40, 80, 40, 80),
        children: <Widget>[
          Center(child: Image.asset('images/success.png')),
          Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                      MyLocalizations.of(context).getString(device_pop_up),
                      style:
                      TextStyle(fontSize: sp_18, color: color_text_333333)))),
          Center(
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  MyLocalizations.of(context).getString(take_your_equipment),
                  style: TextStyle(fontSize: sp_12, color: color_text_999999),
                ),
              )),
          Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(DEVICE, (Route<dynamic> route) => false, arguments: order);
                  },
                  color: color_theme,
                  child: Text(
                    MyLocalizations.of(context).getString(check_device_information),
                    style: TextStyle(color: color_text_FFFFFF),
                  ),
                ),
              )),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                MyLocalizations.of(context).getString(rent_tip),
                style: TextStyle(fontSize: sp_14, color: color_text_999999),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(FAULR_REPORT, arguments: {"imei": order.mifiImei, "orderSn": order.orderSn});
                },
                child: Text(
                  MyLocalizations.of(context).getString(trouble_report),
                  style: TextStyle(color: color_theme),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: color_theme),
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
        ],
      ),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }
}
