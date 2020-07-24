import 'package:core_net/core_net.dart';
import 'package:mifi_rental/entity/config.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';

class ConfigRepository extends BaseRepository {
  static void getConfByMvno({
    String mvnoCode,
    Function(Config) success,
    Function(dynamic) error,
  }) async {
    Map<String, dynamic> params = await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({'mvnoCode': mvnoCode}));

    NetClient().post<Config>(
      UrlApi.GET_CONF_BY_MVNO,
      params: params,
      success: ((any) {
        if (success != null) {
          if (any is Config) {
            success(any);
          } else {
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
