// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pl';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "cameraPermissionsNotGranted" : MessageLookupByLibrary.simpleMessage("Uprawnienia do korzystania z Aparatu i Mikrofonu są niezbędne. Proszę udostępnij Aplikacji dostęp do nich w ustawieniach systemowych i spróbuj ponownie."),
    "cameraPreview" : MessageLookupByLibrary.simpleMessage("Uruchom podgląd z aparatu"),
    "cameraUnknownError" : MessageLookupByLibrary.simpleMessage("Nie udało się zainicjalizować podglądu z aparatu z powodu nieznanego błędu. Proszę spróbuj ponownie później."),
    "retry" : MessageLookupByLibrary.simpleMessage("Ponów"),
    "save" : MessageLookupByLibrary.simpleMessage("Zapisz"),
    "saveEditLabel" : MessageLookupByLibrary.simpleMessage("Tekst do zapisu"),
    "share" : MessageLookupByLibrary.simpleMessage("Udostępnij"),
    "shareEditLabel" : MessageLookupByLibrary.simpleMessage("Tekst do udostępnienia"),
    "title" : MessageLookupByLibrary.simpleMessage("Readnod PL")
  };
}
