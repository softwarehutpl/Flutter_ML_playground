import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

abstract class PreviewEvent { }

class InitializePreviewEvent extends PreviewEvent { }

class InitializedPreviewEvent extends PreviewEvent { }

class SwitchCameraPreviewEvent extends PreviewEvent { }

class RecognizedTextsPreviewEvent extends PreviewEvent {

  final List<TextBlock> texts;
  final Size imageSize;

  RecognizedTextsPreviewEvent({ @required this.texts, @required this.imageSize });
}