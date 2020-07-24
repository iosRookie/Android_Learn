import 'package:core_net/core_net.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';

class FaultRepository extends BaseRepository {
  static void faultReport(
      String mifiImei,
      String problemClassify, //  	问题分类
      String orderSn,
      {
        Function(dynamic) success,
        Function(dynamic) failure,
        String problemDesc,  //  	问题描述
        String attachFileUrl // 上传图片/视频Url 	多个请用，号隔开
      }
      ) async {

    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({
      'mifiImei': mifiImei,
      'problemClassify': problemClassify,
      'problemDesc': problemDesc,
      'attachFileUrl': attachFileUrl,
      'orderSn': orderSn
    }));

    NetClient().post(UrlApi.ISSUE_REPORT,
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
}