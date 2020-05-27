import 'package:flutter/cupertino.dart';

class NotifyProvider extends ChangeNotifier {

  bool refreshState = false;

  void refresh() {
    refreshState = true;
    notifyListeners();
  }
}
