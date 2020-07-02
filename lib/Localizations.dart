
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readnod/l10n/messages_all.dart';

class AppsLocalizations {

  final String localeName;

  AppsLocalizations({@required this.localeName});

  static Future<AppsLocalizations> load(Locale locale) {
    final String name = (locale.countryCode != null && locale.countryCode.isNotEmpty) ? locale.toString() : locale.languageCode;
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      return AppsLocalizations(localeName: localeName);
    });
  }

  static AppsLocalizations of(BuildContext context) {
    return Localizations.of<AppsLocalizations>(context, AppsLocalizations);
  }

  String get title {
    return Intl.message(
        "Readnod",
        name: 'title',
        desc: 'Application title/name',
        locale: localeName,
    );
  }
}

class AppsLocalizationsDelegate extends LocalizationsDelegate<AppsLocalizations> {
  const AppsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'pl'].contains(locale.languageCode);

  @override
  Future<AppsLocalizations> load(Locale locale) => AppsLocalizations.load(locale);

  @override
  bool shouldReload(AppsLocalizationsDelegate old) => false;
}