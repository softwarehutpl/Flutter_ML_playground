import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readnod/text_recognition/save/events.dart';
import 'package:readnod/text_recognition/save/states.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {

  @override
  // TODO: implement initialState
  SaveState get initialState => throw UnimplementedError();

  @override
  Stream<SaveState> mapEventToState(SaveEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}