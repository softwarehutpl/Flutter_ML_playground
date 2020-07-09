# Readnod

An App that will bring your handwriting into internet world.

It's  a playground for text recognition using machine learning & Flutter.

## Tech Stack

* [BLoC & Provider](https://pub.dev/packages/flutter_bloc)
\- for business logic & dependency injection.
* [Camera](https://pub.dev/packages/camera)
\- live camera feed & data source for machine learning process.
* [ML Kit Vision](https://pub.dev/packages/firebase_ml_vision#-readme-tab-)
\- machine learning kit that contains among others OCR.
* [Internationalization and localization](https://pub.dev/packages/intl)
\- for App hardcoded text to be localized.
* [Native Device Orientation](https://pub.dev/packages/native_device_orientation#-readme-tab-)
\- allow to determinate correct image rotation based on device sensors.
Which is needed for ML Kit to work properly.
* [Share](https://pub.dev/packages/share#-readme-tab-)
\- to allow recognized text to be shared through other Apps.
* [Moor](https://pub.dev/packages/moor#-readme-tab-)
\- persistent storage on top of sqlite.


## iOS config disclaimer
During development there were none iOS configuration done for project dependencies.  
So be aware that currently project can have issues with compiling for iOS.  
This will be addressed later down the line.  
To see current state please refer to issue [#9 iOS dependecies setup](https://github.com/softwarehutpl/Flutter_ML_playground/issues/9)
PR with required changes are welcome.

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

## Database
If there is a need to add new table go to `lib/persistence_storage/databse.dart`.  
Please add table & dao class. Once you define table add it's class to `tables`  
array in annotation for `Database` class. Do same for dao.  
After that you should run
`flutter packages pub run build_runner build` in CLI to generate code or
just run `flutter packages pub run build_runner watch` to auto generate it
on every save.

Ref. [https://moor.simonbinder.eu/docs/getting-started/](https://moor.simonbinder.eu/docs/getting-started/)

## App usage showcase

![App usage video](https://raw.githubusercontent.com/softwarehutpl/Flutter_ML_playground/master/gifs/app_usage.gif)
