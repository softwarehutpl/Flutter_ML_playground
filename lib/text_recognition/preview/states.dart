import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

abstract class PreviewState {

  PreviewState copy({ CameraController controller, List<TextBlock> texts, double imageAspectRatio }) { return this; }
}

class InitialPreviewState extends PreviewState {}

class ReadyPreviewState extends PreviewState {

  final CameraController controller;
  final List<TextBlock> texts;
  final double imageAspectRatio;

  ReadyPreviewState({@required this.controller, this.texts, this.imageAspectRatio });

  @override
  PreviewState copy({ CameraController controller, List<TextBlock> texts, double imageAspectRatio }) {
    return ReadyPreviewState(
        controller: controller ?? this.controller,
        texts: texts ?? this.texts,
        imageAspectRatio: imageAspectRatio ?? this.imageAspectRatio
    );
  }
}

class PermissionsNotGrantedPreviewState extends PreviewState {}

class UnknownErrorPreviewState extends PreviewState {}
