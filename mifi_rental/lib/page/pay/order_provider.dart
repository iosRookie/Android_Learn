import 'dart:convert';
import 'package:core_log/core_log.dart';
import 'package:core_net/net_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/dialog/tips_dialog.dart';
import 'package:mifi_rental/entity/auth_paypal.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/page/query/query_page.dart';
import 'package:mifi_rental/repository/order_repository.dart';
import 'package:mifi_rental/util/net_util.dart';
import 'package:mifi_rental/util/route_util.dart';

class OrderProvider extends BaseProvider {

  static const MethodChannel methodChannel = MethodChannel("com.uklink.common/methodChannel");

  static const EventChannel eventChannel = EventChannel("com.uklink.common/payPageState");
  @override
  void init() {
//    checkOrder();
  }

  void checkOrder() async {
    var order = await OrderDb().query();
    if (order != null) {
      showLoading(barrierDismissible: true);
      var user = await UserDb().query();
      OrderRepository.cancelOrder(
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
    OrderRepository.createOrder(
        terminalSn: terminalSn,
        langType: MyLocalizations.of(context).getLanguage(),
        success: (any) {
          dismissLoading();
          var authPaypal = AuthPaypal(
            totalAmount: any.deposit.toString(),
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
          String json = jsonEncode(authPaypal);
          ULog.d(json);
//          if (Platform.isAndroid) {
//            RouteUtil.openNative(PAY_NATIVE, urlParams: {'params': json})
//                .then((map) {
//              if (map.containsKey('cancel') && map['cancel'] == true) {
//                checkOrder();
//              }
//            });
//          } else {
            var map = authPaypal.toJson();
            map['terminalSn'] = terminalSn;
//            FlutterBoost.singleton.closeCurrent();
//            FlutterBoost.singleton
//                .open(PAY_NATIVE, urlParams: map, exts: {"animated": true});
            platformMethod("payWebPage", arguments: map);
          eventChannel.receiveBroadcastStream().listen(_onEvent,
              onError: _onError,
              onDone: (){},
              cancelOnError: true);
//          }
        },
        error: (e) {
          dismissLoading();
          if (e is NetException) {
            switch (e.code) {
              case '02000013':
//                if (Platform.isAndroid) {
//                  RouteUtil.openFlutter(RENT_FAIL);
//                } else {
//                  FlutterBoost.singleton
//                      .open(RENT_FAIL, exts: {"animated": true});
//                }

                break;
              case '02000011':
              case '02000014':
              case '02000017':
                TipsDialog().show(context, e.message);
                break;
              default:
                handleError(e);
            }
          }
        });
  }

  Future<void> platformMethod(String methodName, {dynamic arguments}) async {
    try {
      final int result = await methodChannel.invokeMethod(methodName, arguments);
    } on PlatformException {

    }
  }

  void _onEvent(Object event) {
    var message = event as String;
    switch (message) {
      case "cancelOrder": // 取消订单
      // 调用取消订单接口
        checkOrder();
        break;

      case "paySuccess": // 支付成功
      // 进入查询界面
        Navigator.of(context).push(
            MaterialPageRoute(builder:(context) {
              return QueryPage();
            })
        );
        break;
      default:

        break;
    }
  }

  void _onError(Object error) {

  }
}
