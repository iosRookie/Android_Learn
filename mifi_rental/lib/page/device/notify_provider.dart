import 'package:flutter/cupertino.dart';

class DeviceNotifyProvider extends ChangeNotifier {

  bool refreshState = false;

  void refresh() {
    refreshState = true;
    notifyListeners();
  }
}
