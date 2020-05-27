import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/db/db_goods.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/goods.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/entity/user.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/repository/goods_repository.dart';

class GoodsProvider extends BaseProvider with ChangeNotifier {
  List<String> _units = ['MB', 'GB'];
  String unit;
  String surplusFlow;

  @override
  void init() async {
    var goods = await GoodsDb().query();
    if (goods != null) {
      _setGoods = goods;
    } else {
      var order = await OrderDb().query();
      var user = await UserDb().query();
      query(order, user);
    }
  }

  set _setGoods(Goods goods) {
    var t = 1048576.0;
    for (int i = 0; i < _units.length; i++) {
      var u = _units[i];
      if (goods.surplusFlowbyte < t * 1000 || i == _units.length - 1) {
        unit = u;
        var s = goods.surplusFlowbyte / t;
        if (i == 0) {
          surplusFlow = s.toStringAsFixed(0);
        } else {
          surplusFlow = s.toStringAsFixed(1);
        }
        break;
      } else {
        t = t * 1024;
      }
    }
    notifyListeners();
  }

  void query(Order order, User user, {Function() complete}) {
    if (order == null || user == null) {
      if (complete != null) {
        complete();
      }
      return;
    }
    GoodsRepository().queryGoods(
      langType: MyLocalizations.of(context).getLanguage(),
      loginCustomerId: user.loginCustomerId,
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
