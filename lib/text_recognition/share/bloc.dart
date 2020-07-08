import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readnod/text_recognition/share/events.dart';
import 'package:readnod/text_recognition/share/states.dart';

class PreviewBloc extends Bloc<ShareEvent, ShareState> {

  @override
  // TODO: implement initialState
  ShareState get initialState => throw UnimplementedError();

  @override
  Stream<ShareState> mapEventToState(ShareEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}