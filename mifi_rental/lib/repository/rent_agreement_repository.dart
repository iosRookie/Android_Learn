import 'package:core_net/core_net.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';
import 'package:mifi_rental/util/shared_preferences_util.dart';

class RentAgreementRepository extends BaseRepository {
  void getAgreement(
      {String mvno,
      Function(String) success,
      Function(dynamic) error}) {
    String lang = SharedPreferenceUtil.nativeLocal.languageCode.contains('zh') ? "zh-cn" : "en";
    NetClient().get(
        '${UrlApi.DOCUMENT_HOST}MiFiRent/DHIRental/rental_agreement_$lang.json',
        success: (str) {
      if (success != null) {
        success(str);
      }
    }, error: (e) {
      if (error != null) {
        error(e);
      }
    });
  }
}
