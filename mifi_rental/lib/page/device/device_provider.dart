import 'package:flutter/material.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/entity/device.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/repository/device_repository.dart';

class DeviceProvider extends BaseProvider with ChangeNotifier {
  Order order;
  BuildContext context;
  String wifiName;
  String wifiPwd;
  String imei;

  String get deviceImei => imei;

  DeviceProvider(this.order, this.context) {
    _query(this.order);
  }

  void updateWithOrder(Order order, {Function complete}) {
    this.order = order;
    _query(order, complete: complete);
  }

  set _setDevice(Device device) {
    wifiName = device.wifiName;
    wifiPwd = device.wifiPwd;
    imei = device.mifiImei;
    notifyListeners();
  }

  @override
  void init() async {
  }

  void _query(Order order, {Function complete}) {
    if (order == null) {
      if (complete != null) {
        complete();
      }
      return;
    }
    DeviceRepository.queryMifiInfo(
      order.mifiImei,
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
