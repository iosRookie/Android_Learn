import 'dart:async';

import 'package:core_log/core_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/repository/order_repository.dart';
import 'package:mifi_rental/repository/popup_repository.dart';
import 'package:mifi_rental/res/strings.dart';

class QueryProvider extends BaseProvider {
  Order order;
  QueryProvider(this.order);

  @override
  void init() {
    _queryOrder();
  }

  void _queryOrder() async {
    int requestNum = 0;
    bool doPopup = false;
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (timer.tick == 20) {
        timer.cancel();
      }
      ULog.d('开始轮询等待支付成功');
      OrderRepository.queryOrderInfo(
        pay: true,
        count: requestNum,
        success: ((o) {
          requestNum++;
          if (!doPopup && o.payStatus == "PAY_AUTH") {
            doPopup = true;
            timer.cancel();
            _queryPopup(o);
          } else {
            if (!doPopup && requestNum == 20) {
              _payFail(o);
            }
          }
        }),
        error: ((e) {
          requestNum++;
          if (!doPopup && requestNum == 20) {
            _payFail(order);
          }
        }),
      );
    });
  }

  void _queryPopup(Order order) {
    int requestNum = 0;
    bool openDevice = false;
    ULog.d('开始轮询等待设备弹出');
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (timer.tick >= 20) {
        timer.cancel();
        // 弹机超时
        if (!openDevice) {
          _popupQueryTimeOut();
        }
      }
      PopupRepository().queryPopupResult(
        order.orderSn,
        count: requestNum,
        success: ((o) {
          requestNum++;

          // 弹机成功
          if (!openDevice && o.popResult != null && o.popResult.toInt() == 1) {
            openDevice = true;
            timer.cancel();
            _popupSuccess(o.mifiImei, order);
          } else if (!openDevice &&  o.popResult != null && o.popResult.toInt() == 0) {
            openDevice = false;
            timer.cancel();
            // 弹机失败
            _popupFail();
          }
        }),
        error: ((e) {
          requestNum++;
        }),
      );
    });
  }

  // 查询弹出状态超时，提示用户
  void _popupQueryTimeOut() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(MyLocalizations.of(context).getString(popup_timeout_title)),
            content: Text(MyLocalizations.of(context).getString(popup_timeout_message)),
            actions: <Widget>[
              FlatButton(
                child: Text(MyLocalizations.of(context).getString(confirm)),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(DEVICE, (Route<dynamic> route) => false, arguments: order);
                },
              ),
            ],
          );
        }
    );
  }

  void _popupSuccess(String imei, Order order) async {
    ULog.d('设备弹出成功');
    order.mifiImei = imei;

    Navigator.of(context).pushReplacementNamed(SUCCESS, arguments: order);
  }

  void _popupFail() {
    ULog.d('设备弹出失败');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(MyLocalizations.of(context).getString(popup_failure)),
            content: Text(MyLocalizations.of(context).getString(popup_failure_message)),
            actions: <Widget>[
              FlatButton(
                child: Text(MyLocalizations.of(context).getString(confirm)),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(RENT, (Route<dynamic> route) => false);
                },
              ),
            ],
          );
        }
    );
  }

  void _payFail(Order order) {
    ULog.d('支付失败');
    _cancelOrder(order);
    Navigator.of(context).pushReplacementNamed(PAY_FAIL, arguments: order.terminalSn);
  }

  void _cancelOrder(Order order) {
    ULog.d('取消订单');
    OrderRepository.cancelOrder(
       order.orderSn,
      success: () {
        ULog.d('支付失败 -> 取消订单成功');
      },
      error: (e) {
        ULog.d('支付失败 -> 取消订单失败');
      },
    );
  }
}
