import 'package:connectivity/connectivity.dart';

class ConnectUtil{
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}