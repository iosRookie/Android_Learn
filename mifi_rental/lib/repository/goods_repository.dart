import 'package:core_net/core_net.dart';
import 'package:mifi_rental/db/db_goods.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/goods.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';
import 'package:mifi_rental/util/net_util.dart';

class GoodsRepository extends BaseRepository {
  void queryGoods({
    String langType,
    String loginCustomerId,
    String imei,
    Function(Goods) success,
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
    NetClient().post<Goods>(
      UrlApi.BASE_HOST + UrlApi.QUERY_GOODS_INFO,
      params: {
        'streamNo': NetUtil.getSteamNo(),
        'partnerCode': "partnerCode",
        'langType': langType,
        'loginCustomerId': loginCustomerId,
        'imei': imei,
      },
      success: ((any) {
        if (any is Goods) {
          GoodsDb().update(any);
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
