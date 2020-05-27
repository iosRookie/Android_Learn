import 'package:core_net/core_net.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/terminal.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';
import 'package:mifi_rental/util/net_util.dart';

class TerminalRepository extends BaseRepository {
  void queryTerminalInfo({
    String langType,
    String loginCustomerId,
    String terminalSn,
    Function(Terminal) success,
    Function(dynamic) error,
  }) async {
    if (loginCustomerId == null) {
      var user = await UserDb().query();
      loginCustomerId = user.loginCustomerId;
    }
    NetClient().post<Terminal>(
      UrlApi.BASE_HOST + UrlApi.QUERY_TERMINAL_INFO,
      params: {
        'streamNo': NetUtil.getSteamNo(),
        'langType': langType,
        'loginCustomerId': loginCustomerId,
        'terminalSn': terminalSn,
        'partnerCode': "partnerCode",
      },
      success: ((any) {
        if (any is Terminal) {
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
