import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readnod/text_recognition/preview/events.dart';
import 'package:readnod/text_recognition/preview/states.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {

  final _cameraResolution =  ResolutionPreset.high;
  List<CameraDescription> _cameras = [];
  CameraController _controller;

  @override
  PreviewState get initialState {
    return InitialPreviewState();
  }

  @override
  Stream<PreviewState> mapEventToState(PreviewEvent event) async* {
    if (event is InitializePreviewEvent) {
      yield* initializeCamera();
    }

    if (event is InitializedPreviewEvent) {
      yield ReadyPreviewState(controller: _controller);
    }
  }

  Stream<PreviewState> initializeCamera() async* {
    try {
      _cameras = await availableCameras();
      _controller = CameraController(_cameras.first, _cameraResolution);
      await _controller.initialize();
      add(InitializedPreviewEvent());
    } catch(e) {
      if (_isPermissionMissingException(e)) {
        yield PermissionsNotGrantedPreviewState();
      } else {
        yield UnknownErrorPreviewState();
      }
    }
  }

  bool _isPermissionMissingException(Exception e) {
    return e is CameraException && e.description.contains("permission not granted");
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}