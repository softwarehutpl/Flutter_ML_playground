import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

abstract class PreviewEvent { }

class InitializePreviewEvent extends PreviewEvent { }

class InitializedPreviewEvent extends PreviewEvent { }

class SwitchCameraPreviewEvent extends PreviewEvent { }

class RecognizedTextsPreviewEvent extends PreviewEvent {

  final List<TextBlock> texts;
  final double imageAspectRatio;
  final NativeDeviceOrientation deviceOrientation;

  RecognizedTextsPreviewEvent({
    @required this.texts,
    @required this.imageAspectRatio,
    @required this.deviceOrientation,
  });
}