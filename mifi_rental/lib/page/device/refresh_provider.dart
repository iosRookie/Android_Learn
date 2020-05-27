import 'package:flutter/cupertino.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/db/db_refresh.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/refresh.dart';
import 'package:mifi_rental/entity/user.dart';
import 'package:mifi_rental/page/device/device_provider.dart';
import 'package:mifi_rental/page/device/order_provider.dart';

import 'goods_provider.dart';

class RefreshProvider extends BaseProvider with ChangeNotifier {
  String date;
  int refreshNum;
  User user;

  OrderProvider orderProvider = OrderProvider();
  DeviceProvider deviceProvider = DeviceProvider();
  GoodsProvider goodsProvider = GoodsProvider();

  @override
  void init() async {
    var refresh = await RefreshDb().query();
    if (refresh != null && refresh.date != null) {
      _setDate = refresh.date;
    } else {
      _saveDate();
    }
  }

  set _setDate(String date) {
    if (date != null) {
      this.date = date;
      notifyListeners();
    }
  }

  void refreshData({bool showLoad}) async {
    if (showLoad == true) {
      showLoading();
    }
    if (user == null) {
      user = await UserDb().query();
    }
    refreshNum = 0;
    orderProvider.query(
        user: user,
        complete: () {
          _update();
        });
    deviceProvider.query(orderProvider.order, user, complete: () {
      _update();
    });
    goodsProvider.query(orderProvider.order, user, complete: () {
      _update();
    });
  }

  void _update() {
    refreshNum += 1;
    if (refreshNum == 3) {
      dismissLoading();
      _saveDate();
    }
  }

  void _saveDate() async {
    var s = DateTime.now().millisecondsSinceEpoch;
    var d = DateTime.fromMillisecondsSinceEpoch(s)
        .toString()
        .substring(0, 19)
        .replaceAll('-', '/');
    await RefreshDb().insert(Refresh(date: d));
    _setDate = d;
  }
}
