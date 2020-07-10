import 'package:flutter/material.dart';

abstract class HistoryState {

  final List<String> recognizedTextHistory;

  HistoryState({ @required this.recognizedTextHistory });
}

class InitialHistoryState extends HistoryState {

  InitialHistoryState() : super(recognizedTextHistory: []);
}

class LoadedHistoryState extends HistoryState {

  LoadedHistoryState({ @required List<String> recognizedTextHistory})
      : super(recognizedTextHistory: recognizedTextHistory);
}