import 'dart:io';

import 'package:core_log/core_log.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/preference_key.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/dialog/user_agreement.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/entity/user.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/repository/order_repository.dart';
import 'package:mifi_rental/util/reset_util.dart';
import 'package:mifi_rental/util/shared_preferences_util.dart';

class RentProvider extends BaseProvider {
  @override
  void init() {
    ULog.d('init RentProvider');
    checkUserAgreement();
    checkOrder();
  }

  checkUserAgreement() async {
    bool agree = await SharedPreferenceUtil.getBool(USER_AGREEMENT) ?? false;
    if (!agree) {
      UserAgreementDialog().show(context, showActions: !agree);
    }
  }

  checkOrder() async {
    var order = await OrderDb().query();
    if (order != null) {
      var user = await UserDb().query();
      showLoading(barrierDismissible: false);
      ULog.d('开始订单查询请求');
      OrderRepository().queryOrderInfo(
        orderSn: order.orderSn,
        loginCustomerId: user.loginCustomerId,
        langType: MyLocalizations.of(context).getLanguage(),
        success: ((o) {
          ULog.d('订单查询请求成功' + o.toString());
          if (o.payStatus == PayStatus.UN_PAYED) {
            _cancelOrder(o, user);
          } else {
            if (o.canPopup == 1) {
              dismissLoading();
              if(Platform.isAndroid) {
                FlutterBoost.singleton.open(QUERY);
                FlutterBoost.singleton.closeCurrent();
              } else {
                FlutterBoost.singleton.closeCurrent();
                FlutterBoost.singleton.open(QUERY, exts: {"animated":true});
              }
            } else if (o.orderStatus == OrderStatus.IN_USING) {
              dismissLoading();
              if(Platform.isAndroid) {
                FlutterBoost.singleton.open(DEVICE);
                FlutterBoost.singleton.closeCurrent();
              } else {
                FlutterBoost.singleton.closeCurrent();
                FlutterBoost.singleton.open(DEVICE, exts: {"animated":true});
              }
            } else if (o.orderStatus == OrderStatus.IN_ORDER) {
              _cancelOrder(o, user);
            } else {
              if (o.orderStatus == OrderStatus.FINISHED ||
                  o.orderStatus == OrderStatus.CANCELED) {
                ResetUtil.reset();
              }
              dismissLoading();
            }
          }
        }),
        error: ((e) {
          ULog.d('订单查询请求失败' + e.toString());
          dismissLoading();
          handleError(e);
        }),
      );
    }
  }

  void _cancelOrder(Order o, User user) {
    ULog.d('开始取消订单请求');
    OrderRepository().cancelOrder(
        langType: MyLocalizations.of(context).getLanguage(),
        orderSn: o.orderSn,
        loginCustomerId: user.loginCustomerId,
        success: (() {
          ULog.d('取消订单请求成功');
          dismissLoading();
        }),
        error: ((e) {
          ULog.d('取消订单请求失败');
          dismissLoading();
          handleError(e);
        }));
  }
}
