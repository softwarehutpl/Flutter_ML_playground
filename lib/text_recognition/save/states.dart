import 'package:flutter/material.dart';

abstract class SaveState {
  final String text;

  SaveState({ @required this.text });

  SaveState copy({ String text });
}

class EditingTextState extends SaveState {

  EditingTextState({ @required text }) : super(text: text);

  EditingTextState.from(SaveState state) : super(text: state.text);

  @override
  SaveState copy({ String text }) {
    return EditingTextState(text: text ?? this.text);
  }
}

class CloseScreenState extends SaveState {

  CloseScreenState({ @required text }) : super(text: text);

  CloseScreenState.from(SaveState state) : super(text: state.text);

  @override
  SaveState copy({ String text }) {
    return CloseScreenState(text: text ?? this.text);
  }
}