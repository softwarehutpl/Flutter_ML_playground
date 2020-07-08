import 'package:flutter/material.dart';

abstract class ShareState {
  final String text;

  ShareState({ @required this.text });

  ShareState copy({ String text });
}

class EditingTextState extends ShareState {

  EditingTextState({ @required text }) : super(text: text);

  EditingTextState.from(ShareState state) : super(text: state.text);

  @override
  ShareState copy({ String text }) {
    return EditingTextState(text: text ?? this.text);
  }
}

class DelegateShareState extends ShareState {

  DelegateShareState({ @required text }) : super(text: text);

  DelegateShareState.from(ShareState state) : super(text: state.text);

  @override
  ShareState copy({ String text }) {
    return DelegateShareState(text: text ?? this.text);
  }
}