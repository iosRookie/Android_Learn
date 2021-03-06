import 'dart:io';

import 'package:core_log/core_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/base/base_page.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/repository/order_repository.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:mifi_rental/util/route_util.dart';

class RentFailPage extends BasePage {
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
      title: Text(
        MyLocalizations.of(context).getString(rent_fail),
        style: TextStyle(fontSize: sp_title),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
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
      child:Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(dp_frame, 70, dp_frame, 0),
            child: Column(
              children: <Widget>[
                Image.asset('images/no_rent_device.png'),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(MyLocalizations.of(context).getString(no_rent_device),
                      style: TextStyle(color: color_text_E4393C, fontSize: sp_20)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    MyLocalizations.of(context).getString(no_rent_device_detail),
                    style: TextStyle(fontSize: sp_14, color: color_text_333333),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: FlatButton(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Text(
                        MyLocalizations.of(context).getString(return_home),
                        style: TextStyle(fontSize: sp_16, color: color_text_333333),
                      ),
                      onPressed: () {
//                  if (Platform.isAndroid) {
//                    RouteUtil.openFlutter(RENT, clearTask: true);
//                  } else {
////                    FlutterBoost.singleton.open(RENT);
//                  }
//                        OrderRepository.cancelOrder(
//                          message["orderSn"],
//                          success: () {
//                            ULog.d('主动取消 -> 取消订单成功');
//                          },
//                          error: (e) {
//                            ULog.d('主动取消 -> 取消订单失败');
//                          },
//                        );
                        Navigator.of(context).popUntil(ModalRoute.withName(RENT));
                      },
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: color_line),
                          borderRadius: BorderRadius.circular(5.0)),
                    )),
              ],
            ),
          )),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }
}
