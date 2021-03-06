import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class DemoLocalizations {
  static Future<DemoLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new DemoLocalizations();
    });
  }

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations)!;
  }

  String get title {
    return Intl.message(
      'Flutter App',
      name: 'title',
      desc: 'Title for the Demo Application',
    );
  }

  remainingEmailsMessage(int howMany) => Intl.plural(
        howMany,
        zero: 'There are no emails left',
        one: 'There is $howMany email left',
        other: 'There are $howMany emails left',
        name: "remainingEmailsMessage",
        args: [howMany],
        desc: "How many emails remain after archiving.",
        examples: const {'howMany': 42},
      );
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    return DemoLocalizations.load(locale);
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
