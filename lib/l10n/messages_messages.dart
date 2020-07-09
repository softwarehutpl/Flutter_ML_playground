// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
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
  String get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "cameraPermissionsNotGranted" : MessageLookupByLibrary.simpleMessage("Camera & Microphone permissions are required. Please grant them in App settings and then retry initialization."),
    "cameraPreview" : MessageLookupByLibrary.simpleMessage("Start camera preview"),
    "cameraUnknownError" : MessageLookupByLibrary.simpleMessage("Unable to initialize camera preview due to unknown error. Please try again later"),
    "retry" : MessageLookupByLibrary.simpleMessage("Retry"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "saveEditLabel" : MessageLookupByLibrary.simpleMessage("Text to save"),
    "share" : MessageLookupByLibrary.simpleMessage("Share"),
    "shareEditLabel" : MessageLookupByLibrary.simpleMessage("Text to share"),
    "title" : MessageLookupByLibrary.simpleMessage("Readnod")
  };
}
