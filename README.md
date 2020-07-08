# Readnod

An App that will bring your handwriting into internet world.

It's  a playground for text recognition using machine learning & Flutter.

## Tech Stack

* [BLoC & Provider](https://pub.dev/packages/flutter_bloc)
\- for business logic & dependency injection
* [Camera](https://pub.dev/packages/camera)
\- live camera feed & data source for machine learning process
* [ML Kit Vision](https://pub.dev/packages/firebase_ml_vision#-readme-tab-)
\- machine learning kit that contains among others OCR
* [Internationalization and localization](https://pub.dev/packages/intl)
\- for App hardcoded text to be localized
* [Native Device Orientation](https://pub.dev/packages/native_device_orientation#-readme-tab-)
\- allow to determinate correct image rotation based on device sensors.
Which is needed for ML Kit to work properly.


## Localization
To add new text & it's translations please add appropriate getter to
`Localizations.dart` file in same manner that is currently done for title.
Then run from app's root directory following command:
```
flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/translations.dart
```

This should result in update to template file called `intl_messages.arb`.  
Based on this file create new `intl_*.arb` files or update already existing ones.
When done run following command to generate appropriate `*.dart` files.
```
flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/translations.dart lib/l10n/intl_*.arb
```

Ref. [Flutter documentation](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

## Firebase project
Since ML Kit Vision is a Firebase library App has corresponding App in Firebase console.  
For security reasons `google-services.json` file is excluded from this repo.
If you need access to that file get in touch via `Issues` tab.  
Or create new project using instruction placed [here](https://codelabs.developers.google.com/codelabs/flutter-firebase/#6)  
File `google-services.json` should be placed in Android `app` module.