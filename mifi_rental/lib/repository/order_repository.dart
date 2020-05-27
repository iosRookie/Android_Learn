import 'package:core_log/core_log.dart';
import 'package:core_net/core_net.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';
import 'package:mifi_rental/util/net_util.dart';

class OrderRepository extends BaseRepository {
  void createOrder({
    String loginCustomerId,
    String terminalSn,
    String langType,
    Function(Order) success,
    Function(dynamic) error,
  }) async {
    if (loginCustomerId == null) {
      var user = await UserDb().query();
      loginCustomerId = user.loginCustomerId;
    }
    NetClient().post<Order>(UrlApi.BASE_HOST + UrlApi.CREATE_ORDER, params: {
      'streamNo': NetUtil.getSteamNo(),
      'loginCustomerId': loginCustomerId,
      'langType': langType,
      'partnerCode': "partnerCode",
      'terminalSn': terminalSn,
    }, success: (any) {
      if (any is Order) {
        OrderDb().insert(any);
        if (success != null) {
          success(any);
        }
      } else {
        if (success != null) {
          success(null);
        }
      }
    }, error: (e) {
      if (error != null) {
        error(e);
      }
    });
  }

  void queryOrderInfo({
    String loginCustomerId,
    String langType,
    String orderSn,
    Function(Order) success,
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
    NetClient().post<Order>(UrlApi.BASE_HOST + UrlApi.QUERY_ORDER_INFO, params: {
      'streamNo': NetUtil.getSteamNo(),
      'loginCustomerId': loginCustomerId,
      'langType': langType,
      'partnerCode': "partnerCode",
      'orderSn': orderSn,
    }, success: (any) {
      if (any is Order) {
        if (any.orderStatus == OrderStatus.FINISHED ||
            any.orderStatus == OrderStatus.CANCELED) {
          OrderDb().deleteAll();
        } else {
          OrderDb().update(any);
        }
        if (success != null) {
          success(any);
        }
      } else {
        if (success != null) {
          success(null);
        }
      }
    }, error: (e) {
      if (error != null) {
        error(e);
      }
    });
  }

  void cancelOrder({
    String langType,
    String loginCustomerId,
    String orderSn,
    Function() success,
    Function(dynamic) error,
  }) async {
    ULog.d('取消订单');
    if (loginCustomerId == null) {
      var user = await UserDb().query();
      loginCustomerId = user.loginCustomerId;
    }
    if (orderSn == null) {
      var order = await OrderDb().query();
      orderSn = order.orderSn;
    }

    NetClient().post(
      UrlApi.BASE_HOST + UrlApi.CANCEL_ORDER,
      params: {
        'streamNo': NetUtil.getSteamNo(),
        'loginCustomerId': loginCustomerId,
        'langType': langType,
        'partnerCode': "partnerCode",
        'orderSn': orderSn,
      },
      success: ((any) {
        ULog.d('订单取消成功');
        OrderDb().deleteAll();
        if (success != null) {
          success();
        }
      }),
      error: ((e) {
        ULog.d('订单取消失败');
        if (error != null) {
          error(e);
        }
      }),
    );
  }
}
