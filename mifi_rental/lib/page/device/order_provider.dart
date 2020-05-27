import 'package:flutter/foundation.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/entity/user.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/repository/order_repository.dart';
import 'package:mifi_rental/util/reset_util.dart';

class OrderProvider extends BaseProvider with ChangeNotifier {
  Order order;
  String usedTmStr;
  String rentDate;
  String shouldPay;
  String deposit;

  set _setOrder(Order order) {
    this.order = order;
    var usedTm = order.usedTmStr.split("|");
    usedTmStr =
        "${(int.parse(usedTm[0]) + int.parse(usedTm[1]) / 60).toStringAsFixed(1)}";
    rentDate = DateTime.fromMillisecondsSinceEpoch(order.rentTm.toInt())
        .toString()
        .substring(0, 19)
        .replaceAll('-', '/');
    shouldPay = (order.shouldPay / 100).toString();
    deposit = (order.deposit / 100).toString();
    notifyListeners();
  }

  @override
  void init() async {
    var order = await OrderDb().query();
    if (order != null) {
      if (order.usedTmStr != null) {
        _setOrder = order;
      } else {
        this.order = order;
        var user = await UserDb().query();
        query(user: user);
      }
    }
  }

  void query({User user, Function() complete}) {
    if (order == null) {
      if (complete != null) {
        complete();
      }
      return;
    }
    OrderRepository().queryOrderInfo(
      loginCustomerId: user.loginCustomerId,
      orderSn: order.orderSn,
      langType: MyLocalizations.of(context).getLanguage(),
      success: ((o) {
        if (o.orderStatus == OrderStatus.FINISHED ||
            o.orderStatus == OrderStatus.CANCELED) {
          ResetUtil.reset();
          FlutterBoost.singleton.open(RENT);
        } else {
          _setOrder = o;
          if (complete != null) {
            complete();
          }
        }
      }),
      error: ((e) {
        handleError(e);
        if (complete != null) {
          complete();
        }
      }),
    );
  }
}
