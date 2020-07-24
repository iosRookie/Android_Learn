

import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/util/net_util.dart';
import 'package:mifi_rental/util/shared_preferences_util.dart';

class BaseRepository {
  static Future<Map<String, dynamic>> netCommonParams() async {
    // 初始化loginCustomId

    String loginCustomId = await SharedPreferenceUtil.getLoginCustomId();
    return {
      'streamNo': NetUtil.getSteamNo(),
      'langType': SharedPreferenceUtil.nativeLocal.languageCode,
      'loginCustomerId': loginCustomId,
      'partnerCode': UrlApi.PARTNER_CODE
    };
  }

}
