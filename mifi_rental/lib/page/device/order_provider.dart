import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/res/strings.dart';

class OrderProvider extends BaseProvider with ChangeNotifier {
  Order order;
  BuildContext context;
  String usedTmStr;
  String rentDate;
  String shouldPay;
  String deposit;

  OrderProvider(this.order, this.context) {
    updateOrder(this.order);
  }

  void updateOrder(Order order) {
    this.order = order;

    var usedTm = order.usedTmStr != null ? order.usedTmStr.split("|") : ['',''];
    usedTmStr = '${usedTm[0]}${MyLocalizations.of(context).getString(hours)} ${usedTm[1]}${MyLocalizations.of(context).getString(minutes)}';
    rentDate = DateTime.fromMillisecondsSinceEpoch(order.rentTm.toInt())
        .toString()
        .substring(0, 19)
        .replaceAll('-', '/');
    shouldPay = order.shouldPay != null ? '${order.currencyCode} ${(order.shouldPay / 100).toStringAsFixed(2)}' : '0';
    deposit =  order.deposit != null ? '${order.currencyCode} ${(order.deposit / 100).toStringAsFixed(2)}' : '0';
    notifyListeners();
  }

  @override
  void init() async {
  }

//  void query({Function() complete}) {
//    if (order == null) {
//      if (complete != null) {
//        complete();
//      }
//      return;
//    }
//    OrderRepository.queryOrderInfo(
//      pay: false,
//      success: ((o) {
//        if (o == null ||
//            o.orderStatus == OrderStatus.FINISHED ||
//            o.orderStatus == OrderStatus.CANCELED) {
//          ResetUtil.reset();
//          if (o.orderStatus == OrderStatus.FINISHED) {
//            ReturnDialog().show(context, o).then((_) {
//              _openRent();
//            });
//          } else {
//            _openRent();
//          }
//        } else {
//          _setOrder = o;
//          if (complete != null) {
//            complete();
//          }
//        }
//      }),
//      error: ((e) {
//        handleError(e);
//        if (complete != null) {
//          complete();
//        }
//      }),
//    );
//  }
//
//  _openRent() {
//    if (Platform.isAndroid) {
//      RouteUtil.openFlutter(RENT, clearTask: true);
//    } else {
////      FlutterBoost.singleton.open(RENT);
//    }
//  }
}
