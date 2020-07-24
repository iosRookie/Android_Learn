
import 'package:flutter/material.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/entity/goods.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/repository/goods_repository.dart';

class GoodsProvider extends BaseProvider with ChangeNotifier {
  Order order;
  BuildContext context;
  List<String> _units = ['MB', 'GB'];
  String unit;
  String surplusFlow;

  GoodsProvider(this.order, this.context) {
    _query(this.order);
  }

  void updateWithOrder(Order order, {Function complete}) {
    this.order = order;
    _query(order, complete: complete);
  }

  @override
  void init() async {
  }

  set _setGoods(Goods goods) {
    var t = 1.0;
    for (int i = 0; i < _units.length; i++) {
      var u = _units[i];
      if (goods.surplusFlowbyte < t * 1000 || i == _units.length - 1) {
        unit = u;
        var s = goods.surplusFlowbyte / t;
        if (i == 0) {
          surplusFlow = s.toStringAsFixed(0);
        } else {
          surplusFlow = s.toStringAsFixed(2);
        }
        break;
      } else {
        t = t * 1024;
      }
    }
    notifyListeners();
  }

  void _query(Order order, {Function() complete}) {
    if (order == null) {
      if (complete != null) {
        complete();
      }
      return;
    }
    GoodsRepository().queryGoods(
      imei: order.mifiImei,
      success: ((g) {
        _setGoods = g;
        if (complete != null) {
          complete();
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
