import 'package:flutter/cupertino.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/util/connect_util.dart';

class PrivacyPolicyProvider extends BaseProvider with ChangeNotifier {
  String url;

  set setUrl(String url) {
    this.url = url;
    notifyListeners();
  }

  @override
  void init() {
    _getConfig();
  }

  _getConfig() {
    ConnectUtil.isConnected().then((b) {
      var language = MyLocalizations.of(context).getLanguage();
      var file;
      if (language.startsWith('zh')) {
        file = 'help_center_${language.toLowerCase()}.html';
      } else {
        file = 'help_center_en.html';
      }
      if (b) {
        setUrl = '${UrlApi.DOCUMENT_HOST}MiFiRent/Public/' + file;
      } else {
        setUrl = file;
      }
    });
  }
}
