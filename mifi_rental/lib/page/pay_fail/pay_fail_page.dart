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

class PayFailPage extends BasePage {
  final String _sn;
  BuildContext _context;

  PayFailPage(this._sn);

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
    _context = context;
    return AppBar(
      title: Text(
        MyLocalizations.of(context).getString(pay_fail),
        style: TextStyle(fontSize: sp_title),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
//      leading: GestureDetector(
//          onTap: () {
////            FlutterBoost.singleton.closeCurrent();
//              // 退出并取消订单
//              Navigator.of(context).pop();
//          },
//          child: Icon(
//            Icons.arrow_back_ios,
//            color: color_bg_333333,
//          )),
    );
  }

  @override
  Widget setBody(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.fromLTRB(dp_frame, 70, dp_frame, 0),
      child: Column(
        children: <Widget>[
          Image.asset('images/no_rent_device.png'),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(MyLocalizations.of(context).getString(pay_fail),
                style: TextStyle(color: color_text_E4393C, fontSize: sp_20)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              MyLocalizations.of(context).getString(pay_fail_tip),
              style: TextStyle(fontSize: sp_14, color: color_text_333333),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 30),
              child: FlatButton(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Text(
                  MyLocalizations.of(context).getString(repay),
                  style: TextStyle(fontSize: sp_16, color: color_text_333333),
                ),
                onPressed: () {
//                  if (Platform.isAndroid) {
//                    RouteUtil.openFlutter(PAY,
//                        urlParams: {'sn': _sn}, clearTask: true);
//                  } else {
////                    FlutterBoost.singleton.open(PAY, urlParams: {'sn': _sn});
//                  }
                    // 退出并取消订单
//                  cancelOrder();
                  Navigator.of(context).popUntil(ModalRoute.withName(PAY));
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: color_line),
                    borderRadius: BorderRadius.circular(5.0)),
              )),
        ],
      ),
    ));
  }

//  void cancelOrder() {
//    OrderRepository.cancelOrder(
//        langType: MyLocalizations.of(_context).getLanguage(),
//        orderSn: _sn,
//        success: (() {
//          ULog.d('取消订单请求成功');
//        }),
//        error: ((e) {
//          ULog.d('取消订单请求失败 + ${e.toString()}');
//        }));
//  }
}
