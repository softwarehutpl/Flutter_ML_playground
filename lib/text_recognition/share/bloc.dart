import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readnod/text_recognition/share/events.dart';
import 'package:readnod/text_recognition/share/states.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {

  @override
  ShareState get initialState => EditingTextState(text: "");

  @override
  Stream<ShareState> mapEventToState(ShareEvent event) async* {
    if (event is TextChangedEvent) {
      yield state.copy(text: event.newText);
    }
    if (event is ShareTextEvent) {
      yield DelegateShareState.from(state);
    }
    if (event is ShareCanceledEvent) {
      yield EditingTextState.from(state);
    }
  }
}