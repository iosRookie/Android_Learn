import 'package:core_net/core_net.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';

class RentAgreementRepository extends BaseRepository {
  void getAgreement(
      {String mvno,
      String langType,
      Function(String) success,
      Function(dynamic) error}) {
    var lang;
    if (langType == null) {
      lang = 'en';
    }
    if (lang == null) {
      if (langType.startsWith('zh')) {
        lang = langType.toLowerCase();
      } else {
        lang = langType.substring(0, langType.indexOf('-'));
      }
    }
    NetClient().get(
        '${UrlApi.DOCUMENT_HOST}MiFiRent/$mvno/rental_agreement_$lang.json',
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
