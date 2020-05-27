import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/db/db_device.dart';
import 'package:mifi_rental/db/db_goods.dart';
import 'package:mifi_rental/db/db_refresh.dart';

class ResetUtil {
  static void reset() async {
    await GoodsDb().deleteAll();
    await DeviceDb().deleteAll();
    await RefreshDb().deleteAll();
  }
}
