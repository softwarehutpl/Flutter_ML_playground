import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:readnod/extensions/firebase_ml_vision/TextRecognizer.dart';
import 'package:readnod/extensions/camera/CameraImage.dart';
import 'package:readnod/text_recognition/preview/events.dart';
import 'package:readnod/text_recognition/preview/states.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {

  static final _firstCameraIndex = 0;

  final _cameraResolution =  ResolutionPreset.high;
  List<CameraDescription> _cameras = [];
  CameraController _controller;
  int _currentCameraIndex = _firstCameraIndex;

  final NativeDeviceOrientationCommunicator _deviceOrientationProvider = NativeDeviceOrientationCommunicator();

  final TextRecognizer _textRecognizer = FirebaseVision.instance.textRecognizer();
  bool isRecognizing = false;

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

    if (event is RecognizedTextsPreviewEvent) {
      yield state.copy(
          texts: event.texts,
          imageAspectRatio: event.imageAspectRatio,
          deviceOrientation: event.deviceOrientation,
      );
    }
  }

  Stream<PreviewState> initializeCamera() async* {
    try {
      _cameras = await availableCameras();
      await _controller?.dispose();
      _controller = CameraController(_cameras[_currentCameraIndex], _cameraResolution);
      await _controller.initialize();
      await _controller.startImageStream((image) async {
        if (isRecognizing) { return null; }
        await _recognize(image);
      });
      add(InitializedPreviewEvent());
    } catch(e) {
      if (_isPermissionMissingException(e)) {
        yield PermissionsNotGrantedPreviewState();
      } else {
        yield UnknownErrorPreviewState();
      }
    }
  }

  Future<void> _recognize(CameraImage image) async {
    isRecognizing = true;
    NativeDeviceOrientation deviceOrientation;
    try {
      deviceOrientation = await _deviceOrientationProvider.orientation(useSensor: true).timeout(Duration(milliseconds: 300));
    } catch (e) { /*MARK do nothing, should assume orientation portraitUp */ }
    final sensorOrientation = _controller.description.sensorOrientation;
    final recognition = await _textRecognizer.processCameraImage(image, sensorOrientation, deviceOrientation);
    final imageAspectRatio = image.calculateAspectRatio(sensorOrientation);
    isRecognizing = false;
    add(RecognizedTextsPreviewEvent(
        texts: recognition.blocks,
        imageAspectRatio: imageAspectRatio,
        deviceOrientation: deviceOrientation,
    ));
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
    await _textRecognizer?.close();
    return super.close();
  }
}