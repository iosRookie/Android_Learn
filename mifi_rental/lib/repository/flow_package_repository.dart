import 'package:core_net/core_net.dart';
import 'package:mifi_rental/entity/flow_packages.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';

class FlowPackageRepository extends BaseRepository {
  static void queryOfferList(
      String mvnoCode,
      Function(FlowPackageRespond) success,
      Function(dynamic) failure,
      {
        String channelType = 'APP',
        int currentPage = 1,
        int perPageCount = 100,
        String goodsType = 'PKAG',
        String categoryCode = 'LLTC',
        String terminalType = 'MIFI',
      }
      ) async {
    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({
      'mvnoCode': mvnoCode,
      'channelType': channelType,
      'currentPage': currentPage,
      'perPageCount': perPageCount,
      'goodsType': goodsType,
      'categoryCode': categoryCode,
      'terminalType': terminalType
    }));
    NetClient().post<FlowPackageRespond>(UrlApi.QUERY_OFFER_LIST,
        params: params,
        success: ((any) {
          success(any);
        }),
        error: ((e) {
          if (failure != null) {
            failure(e);
          }
        })
    );
  }

  static void preCalcOrder(
      String payCurrencyType,
      String loginCustomerId,
      String accessToken,
      Map goodsList,
      Function(dynamic) success,
      Function(dynamic) failure,
      {
        String userCode, // 用户编码
        String langType, // 语言类型
        String promotionCode // 促销码
      }
      ) async {
    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({
      'payCurrencyType': payCurrencyType,
      'goodsList': [goodsList]
    }));
    params['loginCustomerId'] = loginCustomerId;
    NetClient().post(UrlApi.PRE_CALC_ORDER + "?access_token="+accessToken,
    params: params,
      success: ((any) {
        success(any);
      }
      ),
      error: ((e) {
        failure(e);
      })
    );
  }

  static void createFlowPackageOrder(
      String currencyType,
      String loginCustomerId,
      String accessToken,
      Map goodsList,
      Function(dynamic) success,
      Function(dynamic) failure,
      {
        String payMethod = 'PAYPAL',
        String channelType = 'APP',
        String orderType = 'BUYPKG',
        String userCode, // 用户编码
        String langType, // 语言类型
        String promotionCode // 促销码
      }
      ) async {
    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({
      'currencyType': currencyType,
      'goodsList': [goodsList],
      'payMethod': 'PAYPAL',
      'channelType': 'APP',
      'orderType': 'BUYPKG',
    }));
    params['loginCustomerId'] = loginCustomerId;
    NetClient().post(UrlApi.FLOW_PACKAGE_CREATE_ORDER + "?access_token="+accessToken,
        params: params,
        success: ((any) {
          success(any);
        }
        ),
        error: ((e) {
          failure(e);
        })
    );
  }

  static void queryBindingToken(
      String imei,
      Function(dynamic) success,
      Function(dynamic) failure
      ) async {
    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({
      'imei': imei
    }));
    NetClient().post(UrlApi.QUERY_BINDING_TOKEN,
        params: params,
        success: ((any) {
          success(any);
        }
        ),
        error: ((e) {
          failure(e);
        })
    );
  }

}