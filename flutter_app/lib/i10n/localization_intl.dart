import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class SimboxIntlLocalizations {
  static Future<SimboxIntlLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((b) {
        Intl.defaultLocale = localeName;
        return SimboxIntlLocalizations();
     });
  }

  static SimboxIntlLocalizations of(BuildContext context) {
    return Localizations.of(context, SimboxIntlLocalizations);
  }

  greetTo(name) => Intl.message("Nice to meet you, $name!",
      name: 'greetTo', desc: 'The application title', args: [name]);

  String get hello {
    return Intl.message('Hello!', name: 'hello');
  }

  String get contact => Intl.message('Contact', name: 'contact');

}

class SimboxIntlLocalizationsDelegate extends LocalizationsDelegate<SimboxIntlLocalizations> {
  const SimboxIntlLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<SimboxIntlLocalizations> load(Locale locale) => SimboxIntlLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<SimboxIntlLocalizations> old) => false;

}

// flutter pub pub run intl_translation:extract_to_arb --output-dir=i10n-arb lib/i10n/localization_intl.dart  生成arb文件
// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i10n --no-use-deferred-loading lib/i10n/localization_intl.dart i10n-arb/intl_*.arb 生成dart文件