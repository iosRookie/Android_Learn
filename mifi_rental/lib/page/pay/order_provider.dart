import 'dart:convert';
import 'package:core_log/core_log.dart';
import 'package:core_net/net_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/dialog/tips_dialog.dart';
import 'package:mifi_rental/entity/auth_paypal.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/net/net_data_analysis_error.dart';
import 'package:mifi_rental/repository/order_repository.dart';
import 'package:mifi_rental/util/net_util.dart';

class OrderProvider extends BaseProvider {

  static const MethodChannel methodChannel = MethodChannel("com.uklink.common/methodChannel");

  static const EventChannel eventChannel = EventChannel("com.uklink.common/payPageState");

  Order currentOrder;

  @override
  void init() {
  }

  void createOrder(String terminalSn,
      {Function(Order) success, Function(dynamic) error}) {
    showLoading();
    OrderRepository.createOrder(
        terminalSn: terminalSn,
        success: (any) {
          currentOrder = any;

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
          var map = authPaypal.toJson();
          map.addAll({"terminalSn": terminalSn, "paypalUrl": UrlApi.PAYPAL_HOST});
          map.addAll({"payType": 'rental_device'});
          platformMethod("payWebPage", arguments: map);
          // 监听native回调
          eventChannel.receiveBroadcastStream().listen(_onEvent,
              onError: _onError,
              onDone: (){},
              cancelOnError: true);
        },
        error: (e) {
          dismissLoading();
          NetDataAnalysisError.showErrorToast(e, context);
        });
  }

  Future<void> platformMethod(String methodName, {dynamic arguments}) async {
    try {
      final int result = await methodChannel.invokeMethod(methodName, arguments);
    } on PlatformException {

    }
  }

  void _onEvent(Object event) {
    var message = event as Map;
    switch (message["method"]) {
      case "cancelOrder": // 取消订单
      // 调用取消订单接口
        OrderRepository.cancelOrder(
          message["orderSn"],
          success: () {
            ULog.d('主动取消 -> 取消订单成功');
          },
          error: (e) {
            ULog.d('主动取消 -> 取消订单失败');
          },
        );
        break;
      case "paySuccess": // 支付成功
      // 进入查询界面
        Navigator.of(context).pushNamed(QUERY, arguments: currentOrder);
        break;
      default:

        break;
    }
  }

  void _onError(Object error) {

  }
}
