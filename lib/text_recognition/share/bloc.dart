import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readnod/text_recognition/repository.dart';
import 'package:readnod/text_recognition/share/events.dart';
import 'package:readnod/text_recognition/share/states.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {

  final TextRecognitionRepository repository;

  ShareBloc({ @required this.repository });

  @override
  ShareState get initialState => EditingTextState(text: "");

  @override
  Stream<ShareState> mapEventToState(ShareEvent event) async* {
    if (event is TextChangedEvent) {
      yield state.copy(text: event.newText);
    }
    if (event is SaveTextEvent) {
      repository.storeRecognizedText(state.text);
    }
  }
}