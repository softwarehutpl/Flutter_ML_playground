import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readnod/text_recognition/preview/events.dart';
import 'package:readnod/text_recognition/preview/states.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {

  static final _firstCameraIndex = 0;

  final _cameraResolution =  ResolutionPreset.high;
  List<CameraDescription> _cameras = [];
  CameraController _controller;
  int _currentCameraIndex = _firstCameraIndex;

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

    if (event is SwitchCameraPreviewEvent) {
      _calculateNewCameraIndex();
      yield* initializeCamera();
    }
  }

  Stream<PreviewState> initializeCamera() async* {
    try {
      _cameras = await availableCameras();
      await _controller?.dispose();
      _controller = CameraController(_cameras[_currentCameraIndex], _cameraResolution);
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

  void _calculateNewCameraIndex() {
    _currentCameraIndex++;
    if (_currentCameraIndex >= _cameras.length) {
      _currentCameraIndex = _firstCameraIndex;
    }
  }

  @override
  Future<void> close() async {
    await  _controller?.dispose();
    return super.close();
  }
}