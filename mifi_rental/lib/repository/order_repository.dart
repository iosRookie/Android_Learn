import 'package:core_log/core_log.dart';
import 'package:core_net/core_net.dart';
import 'package:mifi_rental/db/db_order.dart';
import 'package:mifi_rental/db/db_user.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';
import 'package:mifi_rental/util/net_util.dart';

class OrderRepository extends BaseRepository {
  static void createOrder({
    String terminalSn,
    Function(Order) success,
    Function(dynamic) error,
  }) async {
    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({'terminalSn': terminalSn}));

    NetClient().post<Order>(UrlApi.CREATE_ORDER,
        params: params,
        success: (any) {
      if (any is Order) {
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

  static Future<void> queryOrderInfo({
    bool pay,
    int count,
    Function(Order) success,
    Function(dynamic) error,
  }) async {
    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({'pay': pay, 'count': count})); // pay 标示是否 设备轮询弹出时 的查询

    NetClient().post<Order>(UrlApi.QUERY_ORDER_INFO,
        params: params,
        success: (any) {
      if (any is Order) {
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

  static void cancelOrder(
    String orderSn,
      {Function() success,
    Function(dynamic) error
      }
    ) async {
    ULog.d('取消订单');
    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({'orderSn': orderSn}));

    NetClient().post(
      UrlApi.CANCEL_ORDER,
      params: params,
      success: ((any) {
        ULog.d('订单取消成功');
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
