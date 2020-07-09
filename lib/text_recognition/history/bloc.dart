import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readnod/text_recognition/history/events.dart';
import 'package:readnod/text_recognition/history/states.dart';
import 'package:readnod/text_recognition/repository.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {

  final TextRecognitionRepository repository;
  StreamSubscription<List<String>> _historySubscription;

  HistoryBloc({ @required this.repository });

  @override
  HistoryState get initialState => InitialHistoryState();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is LoadHistoryEvent) {
      await _historySubscription?.cancel();
      _historySubscription = repository.watchRecognizedTexts().listen((texts) {
        add(HistoryListEvent(textsHistory: texts));
      });
    }

    if (event is HistoryListEvent) {
      yield LoadedHistoryState(recognizedTextHistory: event.textsHistory);
    }
  }

  @override
  Future<void> close() {
    _historySubscription?.cancel();
    return super.close();
  }
}