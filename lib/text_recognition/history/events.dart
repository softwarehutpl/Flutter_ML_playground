import 'package:flutter/material.dart';

abstract class HistoryEvent {}

class LoadHistoryEvent extends HistoryEvent {}

class HistoryListEvent extends HistoryEvent {

  final List<String> textsHistory;

  HistoryListEvent({ @required this.textsHistory});
}