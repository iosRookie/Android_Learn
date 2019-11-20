import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SimboxLocalizations {
  final Locale locale;

  SimboxLocalizations(this.locale);

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'contact': 'Contact',
      'call_log': 'CallLog',
      'message': 'Message',
      'individual': 'Individual',
    },
    'zh': {
      'contact': '联系人',
      'call_log': '通话记录',
      'message': '短信',
      'individual': '个人',
    }
  };

  String get contact => _localizedValues[locale.languageCode]['contact'];
  String get callLog => _localizedValues[locale.languageCode]['call_log'];
  String get message => _localizedValues[locale.languageCode]['message'];
  String get individual => _localizedValues[locale.languageCode]['individual'];


  static SimboxLocalizationsDelegate delegate = const SimboxLocalizationsDelegate();

  static SimboxLocalizations of(BuildContext context) {
    return Localizations.of(context, SimboxLocalizations);
  }
}

class SimboxLocalizationsDelegate extends LocalizationsDelegate<SimboxLocalizations> {

  const SimboxLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<SimboxLocalizations> load(Locale locale) {
    return SynchronousFuture<SimboxLocalizations>(SimboxLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<SimboxLocalizations> old) {
    return false;
  }
}