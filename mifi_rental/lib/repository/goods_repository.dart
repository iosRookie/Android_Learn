import 'package:core_net/core_net.dart';
import 'package:mifi_rental/db/db_goods.dart';
import 'package:mifi_rental/entity/goods.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';

class GoodsRepository extends BaseRepository {
  void queryGoods({
    String imei,
    Function(Goods) success,
    Function(dynamic) error,
  }) async {
    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({'imei': imei}));

    NetClient().post<Goods>(
      UrlApi.QUERY_GOODS_INFO,
      params: params,
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
