import 'package:flutter/cupertino.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/db/db_refresh.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/entity/refresh.dart';
import 'package:mifi_rental/entity/user.dart';
import 'package:mifi_rental/page/device/device_provider.dart';
import 'package:mifi_rental/page/device/order_provider.dart';

import 'goods_provider.dart';

class RefreshProvider extends BaseProvider with ChangeNotifier {
  Order order;
  BuildContext context;

  String date;
  int refreshNum;
  User user;

  OrderProvider orderProvider;
  DeviceProvider deviceProvider;
  GoodsProvider goodsProvider;

  RefreshProvider(this.order, this.context) {
    orderProvider = OrderProvider(this.order, this.context);
    deviceProvider = DeviceProvider(this.order, this.context);
    goodsProvider = GoodsProvider(this.order, this.context);

    _refreshTime();
  }

  _refreshTime() async {
    var refresh = await RefreshDb().query();
    if (refresh != null && refresh.date != null) {
      _setDate = refresh.date;
    } else {
      _saveDate();
    }
  }

  @override
  void init() async {
  }

  set _setDate(String date) {
    if (date != null) {
      this.date = date;
      notifyListeners();
    }
  }

  void refreshData({bool showLoad, Order order}) async {
    this.order = order;
    if (showLoad == true) {
      showLoading();
    }
    refreshNum = 0;
    orderProvider.updateOrder(order);

    deviceProvider.updateWithOrder(order, complete: () {
      _update();
    });
    goodsProvider.updateWithOrder(order, complete: () {
      _update();
    });
  }

  void _update() {
    refreshNum += 1;
    if (refreshNum == 2) {
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
