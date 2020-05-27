import 'package:core_net/core_net.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/popup.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';
import 'package:mifi_rental/util/net_util.dart';

class PopupRepository extends BaseRepository {
  void handlerOrder({
    String langType,
    String loginCustomerId,
    String orderSn,
    Function() success,
    Function(dynamic) error,
  }) async {
    if (loginCustomerId == null) {
      var user = await UserDb().query();
      loginCustomerId = user.loginCustomerId;
    }
    if (orderSn == null) {
      var order = await OrderDb().query();
      orderSn = order.orderSn;
    }

    NetClient().post(
      UrlApi.BASE_HOST + UrlApi.HANDLER_ORDER,
      params: {
        'streamNo': NetUtil.getSteamNo(),
        'loginCustomerId': loginCustomerId,
        'langType': langType,
        'partnerCode': "partnerCode",
        'orderSn': orderSn,
      },
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

  queryPopupResult({
    String langType,
    String loginCustomerId,
    String orderSn,
    Function(Popup) success,
    Function(dynamic) error,
  }) async {
    if (loginCustomerId == null) {
      var user = await UserDb().query();
      loginCustomerId = user.loginCustomerId;
    }
    if (orderSn == null) {
      var order = await OrderDb().query();
      orderSn = order.orderSn;
    }
    NetClient().post<Popup>(
      UrlApi.BASE_HOST + UrlApi.QUERY_POPUP_RESULT,
      params: {
        'streamNo': NetUtil.getSteamNo(),
        'loginCustomerId': loginCustomerId,
        'langType': langType,
        'partnerCode': "partnerCode",
        'orderSn': orderSn,
      },
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
