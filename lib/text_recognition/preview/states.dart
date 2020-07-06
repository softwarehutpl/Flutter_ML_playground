import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

abstract class PreviewState {

  PreviewState copy({ CameraController controller, List<TextBlock> texts, Size imageSize }) { return this; }
}

class InitialPreviewState extends PreviewState {}

class ReadyPreviewState extends PreviewState {

  final CameraController controller;
  final List<TextBlock> texts;
  final Size imageSize;

  ReadyPreviewState({@required this.controller, this.texts, this.imageSize });

  @override
  PreviewState copy({ CameraController controller, List<TextBlock> texts, Size imageSize }) {
    return ReadyPreviewState(
        controller: controller ?? this.controller,
        texts: texts ?? this.texts,
        imageSize: imageSize ?? this.imageSize
    );
  }
}

class PermissionsNotGrantedPreviewState extends PreviewState {}

class UnknownErrorPreviewState extends PreviewState {}
