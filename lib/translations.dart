
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readnod/l10n/messages_all.dart';

class Translations {

  final String localeName;

  Translations({@required this.localeName});

  static Future<Translations> load(Locale locale) {
    final String name = (locale.countryCode != null && locale.countryCode.isNotEmpty) ? locale.toString() : locale.languageCode;
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      return Translations(localeName: localeName);
    });
  }

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String get title {
    return Intl.message(
        "Readnod",
        name: 'title',
        desc: 'Application title/name',
        locale: localeName,
    );
  }

  String get cameraPreview {
    return Intl.message(
      "Start camera preview",
      name: 'cameraPreview',
      desc: 'Text used on button for starting camera preview for text recognition',
      locale: localeName,
    );
  }

  String get cameraPermissionsNotGranted {
    return Intl.message(
      "Camera & Microphone permissions are required. Please grant them in App settings and then retry initialization.",
      name: 'cameraPermissionsNotGranted',
      desc: 'Text used to inform user that camera related permissions are required',
      locale: localeName,
    );
  }

  String get cameraUnknownError {
    return Intl.message(
      "Unable to initialize camera preview due to unknown error. Please try again later",
      name: 'cameraUnknownError',
      desc: 'Text used to inform user that some unknown error occurred during camera initialization',
      locale: localeName,
    );
  }

  String get retry {
    return Intl.message(
      "Retry",
      name: 'retry',
      desc: "Not much to say it's retry",
      locale: localeName,
    );
  }

  String get share {
    return Intl.message(
      "Share",
      name: "share",
      locale: localeName,
    );
  }

  String get shareEditLabel {
    return Intl.message(
      "Text to share",
      name: "shareEditLabel",
      locale: localeName,
    );
  }

  String get save {
    return Intl.message(
      "Save",
      name: "save",
      locale: localeName,
    );
  }

  String get saveEditLabel {
    return Intl.message(
        "Text to save",
      name: "saveEditLabel",
      locale: localeName,
    );
  }
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'pl'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}