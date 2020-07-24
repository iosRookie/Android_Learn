import 'package:core_log/core_log.dart';
import 'package:flutter/material.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/preference_key.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/dialog/privacy_policy.dart';
import 'package:mifi_rental/dialog/return_dialog.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/net/net_data_analysis_error.dart';
import 'package:mifi_rental/repository/order_repository.dart';
import 'package:mifi_rental/util/shared_preferences_util.dart';

class RentProvider extends BaseProvider {
  @override
  void init() {
    ULog.d('init RentProvider');
    checkUserAgreement();
    queryOrderInfo();
  }

  checkUserAgreement() async {
    bool agree = await SharedPreferenceUtil.getBool(USER_AGREEMENT) ?? false;
    if (!agree) {
      CustomBottomSheetDialog.show(context, BottomSheetType.user_agreement, showActions: !agree);
    }
  }

  Future<void> queryOrderInfo() async {
    showLoading(barrierDismissible: false);
    ULog.d('开始订单查询请求');
    await OrderRepository.queryOrderInfo(
      pay: false,
      success: ((o) {
        if (o == null) {
          dismissLoading();
          ULog.d('订单查询请求成功:null');
          return;
        }
        ULog.d('订单查询请求成功:' + o.toString());
        if (o.payStatus == PayStatus.UN_PAYED) {
//          _cancelOrder(o, user);
        } else {
          if (o.canPopup == 1) {
            dismissLoading();
            Navigator.of(context).pushNamed(QUERY);
          } else if (o.orderStatus == OrderStatus.IN_USING || (o.orderStatus == OrderStatus.IN_ORDER && o.payStatus == PayStatus.PAYED)) {
            dismissLoading();
            Navigator.of(context).pushReplacementNamed(DEVICE);
          } else if (o.orderStatus == OrderStatus.IN_ORDER) {
//            _cancelOrder(o, user);
          } else {
            dismissLoading();
            if (o.orderStatus == OrderStatus.FINISHED ||
                o.orderStatus == OrderStatus.CANCELED) {
              if (o.orderStatus == OrderStatus.FINISHED) {
                ReturnDialog().show(context, o);
              }
            }
          }
        }
      }),
      error: ((e) {
        ULog.d('订单查询请求失败' + e.toString());
        dismissLoading();
        NetDataAnalysisError.showErrorToast(e, context);
      }),
    );
  }
}
