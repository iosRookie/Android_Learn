import 'dart:async';
import 'dart:io';

import 'package:core_log/core_log.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/entity/user.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/repository/order_repository.dart';
import 'package:mifi_rental/repository/popup_repository.dart';

class QueryProvider extends BaseProvider {
  @override
  void init() {
    _queryOrder();
  }

  void _queryOrder() async {
    var order = await OrderDb().query();
    var user = await UserDb().query();
    if (order.canPopup == 1) {
      _popup(order, user);
    } else {
      int requestNum = 0;
      bool doPopup = false;
      Timer.periodic(Duration(seconds: 3), (timer) {
        if (timer.tick == 10) {
          timer.cancel();
        }
        OrderRepository().queryOrderInfo(
          loginCustomerId: user.loginCustomerId,
          orderSn: order.orderSn,
          langType: MyLocalizations.of(context).getLanguage(),
          success: ((o) {
            requestNum++;
            if (!doPopup && o.canPopup != null && o.canPopup == 1) {
              doPopup = true;
              timer.cancel();
              _popup(order, user);
            } else {
              if (!doPopup && requestNum == 10) {
                _payFail(order, user);
              }
            }
          }),
          error: ((e) {
            requestNum++;
            if (!doPopup && requestNum == 10) {
              _payFail(order, user);
            }
          }),
        );
      });
    }
  }

  void _popup(Order order, User user) {
    PopupRepository().handlerOrder(
      loginCustomerId: user.loginCustomerId,
      orderSn: order.orderSn,
      langType: MyLocalizations.of(context).getLanguage(),
      success: () {
        _queryPopup(order, user);
      },
      error: ((e) {
        handleError(e);
      }),
    );
  }

  void _queryPopup(Order order, User user) {
    int requestNum = 0;
    bool openDevice = false;
    ULog.d('开始轮询等待设备弹出');
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (timer.tick == 10) {
        timer.cancel();
      }
      PopupRepository().queryPopupResult(
        loginCustomerId: user.loginCustomerId,
        orderSn: order.orderSn,
        langType: MyLocalizations.of(context).getLanguage(),
        success: ((o) {
          requestNum++;
          if (!openDevice && o.popStatus != null && o.popStatus == 1) {
            openDevice = true;
            timer.cancel();
            _popupSuccess(o.mifiImei, order);
          } else {
            if (!openDevice && requestNum == 10) {
              _rentFail(order, user);
            }
          }
        }),
        error: ((e) {
          requestNum++;
          if (!openDevice && requestNum == 10) {
            _rentFail(order, user);
          }
        }),
      );
    });
  }

  void _popupSuccess(String imei, Order order) async {
    ULog.d('设备弹出成功');
    order.mifiImei = imei;

    await OrderDb().update(order);
    if(Platform.isAndroid) {
      FlutterBoost.singleton.open(DEVICE);
      FlutterBoost.singleton.closeCurrent();
    } else {
      FlutterBoost.singleton.closeCurrent();
      FlutterBoost.singleton.open(DEVICE, exts: {"animated":true});
    }
  }

  void _payFail(Order order, User user) {
    ULog.d('设备弹出失败');
    _cancelOrder(order, user, () {
      if(Platform.isAndroid) {
        FlutterBoost.singleton.open(PAY_FAIL);
        FlutterBoost.singleton.closeCurrent();
      } else {
        FlutterBoost.singleton.closeCurrent();
        FlutterBoost.singleton.open(PAY_FAIL, exts: {"animated":true});
      }
    });
  }

  void _rentFail(Order order, User user) {
    _cancelOrder(order, user, () {
      if(Platform.isAndroid) {
        FlutterBoost.singleton.open(RENT_FAIL);
        FlutterBoost.singleton.closeCurrent();
      } else {
        FlutterBoost.singleton.closeCurrent();
        FlutterBoost.singleton.open(RENT_FAIL, exts: {"animated":true});
      }
    });
  }

  void _cancelOrder(Order order, User user, Function() complete) {
    OrderRepository().cancelOrder(
      loginCustomerId: user.loginCustomerId,
      orderSn: order.orderSn,
      langType: MyLocalizations.of(context).getLanguage(),
      success: (() {
        complete();
      }),
      error: ((e) {
        handleError(e);
        complete();
      }),
    );
  }
}
