import 'package:flutter/material.dart';

abstract class ShareEvent {}

class TextChangedEvent extends ShareEvent {

  final String newText;

  TextChangedEvent({ @required this.newText });
}

class ShareTextEvent extends ShareEvent {}

class ShareCanceledEvent extends ShareEvent {}