import 'package:core_net/core_net.dart';
import 'package:mifi_rental/db/db_device.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/device.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';
import 'package:mifi_rental/util/net_util.dart';

class DeviceRepository extends BaseRepository {
  void queryMifiInfo({
    String langType,
    String loginCustomerId,
    String imei,
    Function(Device) success,
    Function(dynamic) error,
  }) async {
    if (loginCustomerId == null) {
      var user = await UserDb().query();
      loginCustomerId = user.loginCustomerId;
    }
    if (imei == null) {
      var order = await OrderDb().query();
      imei = order.mifiImei;
    }
    NetClient().post<Device>(
      UrlApi.BASE_HOST + UrlApi.QUERY_MIFI_INFO,
      params: {
        'streamNo': NetUtil.getSteamNo(),
        'partnerCode': "partnerCode",
        'langType': langType,
        'loginCustomerId': loginCustomerId,
        'imei': imei,
      },
      success: ((any) {
        if (any is Device) {
          DeviceDb().update(any);
          if (success != null) {
            success(any);
          }
        } else {
          if (success != null) {
            success(null);
          }
        }
      }),
      error: ((e) {
        if (error != null) {
          error(e);
        }
      }),
    );
  }
}
