import 'package:flutter/material.dart';

abstract class SaveEvent {}

class TextChangedEvent extends SaveEvent {

  final String newText;

  TextChangedEvent({ @required this.newText });
}

class SaveTextEvent extends SaveEvent {}