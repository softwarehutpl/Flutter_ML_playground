import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

abstract class PreviewState {

  PreviewState copy({
    CameraController controller,
    List<TextBlock> texts,
    double imageAspectRatio,
    NativeDeviceOrientation deviceOrientation,
  }) { return this; }
}

class InitialPreviewState extends PreviewState {}

class ReadyPreviewState extends PreviewState {

  final CameraController controller;
  final List<TextBlock> texts;
  final double imageAspectRatio;
  final NativeDeviceOrientation deviceOrientation;

  ReadyPreviewState({
    @required this.controller,
    this.texts,
    this.imageAspectRatio,
    this.deviceOrientation,
  });

  @override
  PreviewState copy({
    CameraController controller,
    List<TextBlock> texts,
    double imageAspectRatio,
    NativeDeviceOrientation deviceOrientation,
  }) {
    return ReadyPreviewState(
        controller: controller ?? this.controller,
        texts: texts ?? this.texts,
        imageAspectRatio: imageAspectRatio ?? this.imageAspectRatio,
        deviceOrientation: deviceOrientation ?? this.deviceOrientation,
    );
  }
}

class PermissionsNotGrantedPreviewState extends PreviewState {}

class UnknownErrorPreviewState extends PreviewState {}
