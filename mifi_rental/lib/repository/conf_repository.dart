import 'package:core_net/core_net.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/config.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';
import 'package:mifi_rental/util/net_util.dart';

class ConfigRepository extends BaseRepository {
  void getConfByMvno({
    String mvnoCode,
    String langType,
    String loginCustomerId,
    Function(Config) success,
    Function(dynamic) error,
  }) async {
    if (loginCustomerId == null) {
      var user = await UserDb().query();
      loginCustomerId = user.loginCustomerId;
    }
    NetClient().post<Config>(
      UrlApi.BASE_HOST + UrlApi.GET_CONF_BY_MVNO,
      params: {
        'streamNo': NetUtil.getSteamNo(),
        'partnerCode': "partnerCode",
        'langType': langType,
        'loginCustomerId': loginCustomerId,
        'mvnoCode': mvnoCode,
      },
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
