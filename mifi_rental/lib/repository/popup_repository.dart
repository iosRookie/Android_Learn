import 'package:core_net/core_net.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/popup.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';

class PopupRepository extends BaseRepository {
  void handlerOrder(
    String orderSn,
      {Function() success,
    Function(dynamic) error,}
    ) async {
    assert(orderSn != null || orderSn.length != 0);

    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({'orderSn': orderSn}));

    NetClient().post(
      UrlApi.HANDLER_ORDER,
      params: params,
      success: ((any) {
        if (success != null) {
          success();
        }
      }),
      error: ((e) {
        if (error != null) {
          error(e);
        }
      }),
    );
  }

  queryPopupResult(
    String orderSn,
      { int count = 0,
        Function(Popup) success,
    Function(dynamic) error,}
  ) async {
    assert(orderSn != null || orderSn.length != 0);

    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({'orderSn': orderSn, "count" : count}));

    NetClient().post<Popup>(
      UrlApi.QUERY_POPUP_RESULT,
      params: params,
      success: ((any) {
        if (any is Popup) {
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
