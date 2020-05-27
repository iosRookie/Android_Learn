import 'dart:io';

import 'package:core_log/core_log.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/auth_paypal.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/repository/order_repository.dart';
import 'package:mifi_rental/util/net_util.dart';

class OrderProvider extends BaseProvider {
  @override
  void init() {
    checkOrder();
  }

  void checkOrder() async {
    var order = await OrderDb().query();
    if (order != null) {
      showLoading(barrierDismissible: true);
      var user = await UserDb().query();
      OrderRepository().cancelOrder(
        loginCustomerId: user.loginCustomerId,
        orderSn: order.orderSn,
        langType: MyLocalizations.of(context).getLanguage(),
        success: (() {
          dismissLoading();
        }),
        error: ((e) {
          dismissLoading();
          handleError(e);
        }),
      );
    }
  }

  void createOrder(String terminalSn,
      {Function(Order) success, Function(dynamic) error}) {
    showLoading();
    OrderRepository().createOrder(
        terminalSn: terminalSn,
        langType: MyLocalizations.of(context).getLanguage(),
        success: (any) {
          dismissLoading();
          var authPaypal = AuthPaypal(
            loginCustomerId: any.customerId,
            orderSn: any.orderSn,
            streamNo: NetUtil.getSteamNo(),
            currencyCode: any.currencyCode,
            langType: MyLocalizations.of(context).getLanguage(),
            mvnoCode: any.mvnoCode,
            localeCode:
                MyLocalizations.of(context).getLanguage().replaceAll('-', '_'),
            projectName: 'authPaypal.App.${any.mvnoCode}',
          );
          ULog.d(authPaypal.toString());
          var map = authPaypal.toJson();
          map['terminalSn'] = terminalSn;
          if (Platform.isAndroid) {
            FlutterBoost.singleton.open(PAY_NATIVE, urlParams: map);
            FlutterBoost.singleton.closeCurrent();
          } else {
            FlutterBoost.singleton.closeCurrent();
            FlutterBoost.singleton.open(PAY_NATIVE, urlParams: map, exts: {"animated":true});
          }
        },
        error: (e) {
          dismissLoading();
          handleError(e);
        });
  }
}
