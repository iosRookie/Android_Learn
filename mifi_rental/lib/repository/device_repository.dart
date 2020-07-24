import 'package:core_net/core_net.dart';
import 'package:mifi_rental/entity/device.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';

class DeviceRepository extends BaseRepository {
  static void queryMifiInfo(
    String imei,
      {
    Function(Device) success,
    Function(dynamic) error,
  }) async {

    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({'imei': imei}));
    NetClient().post<Device>(
      UrlApi.QUERY_MIFI_INFO,
      params: params,
      success: ((any) {
        if (any is Device) {
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

  static void buyMifi(
      String orderSn,
      Function(Device) success,
      Function(dynamic) error,
      ) async {
    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({'orderSn': orderSn}));
      NetClient().post(UrlApi.BUY_MIFI,
        params: params,
        success: ((any) {
          success ?? success(any);
        }),
        error: ((e) {
            error ?? error(e);
        }),
      );
  }
}
