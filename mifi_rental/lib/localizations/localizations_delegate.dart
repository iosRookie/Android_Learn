import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'localizations.dart';

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    return new SynchronousFuture<MyLocalizations>(new MyLocalizations(locale));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
