import 'package:core_log/core_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/db/db_device.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/device.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/entity/user.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/repository/device_repository.dart';

class DeviceProvider extends BaseProvider with ChangeNotifier {
  String wifiName;
  String wifiPwd;
  String imei;

  set _setDevice(Device device) {
    wifiName = device.wifiName;
    wifiPwd = device.wifiPwd;
    imei = device.mifiImei;
    notifyListeners();
  }

  @override
  void init() async {
    var device = await DeviceDb().query();
    if (device != null) {
      _setDevice = device;
    } else {
      var order = await OrderDb().query();
      var user = await UserDb().query();
      query(order, user);
    }
  }

  void query(Order order, User user, {Function complete}) {
    if (order == null || user == null) {
      if (complete != null) {
        complete();
      }
      return;
    }
    DeviceRepository().queryMifiInfo(
      langType: MyLocalizations.of(context).getLanguage(),
      loginCustomerId: user.loginCustomerId,
      imei: order.mifiImei,
      success: ((d) {
        _setDevice = d;
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
