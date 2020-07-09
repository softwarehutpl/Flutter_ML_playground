import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readnod/text_recognition/repository.dart';
import 'package:readnod/text_recognition/save/events.dart';
import 'package:readnod/text_recognition/save/states.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {

  final TextRecognitionRepository repository;

  SaveBloc({ @required this.repository });

  @override
  SaveState get initialState => EditingTextState(text: "");

  @override
  Stream<SaveState> mapEventToState(SaveEvent event) async* {
    if (event is TextChangedEvent) {
      yield state.copy(text: event.newText);
    }
    if (event is SaveTextEvent) {
      await repository.storeRecognizedText(state.text);
      yield CloseScreenState.from(state);
    }
  }
}