import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

abstract class PreviewState { }

class InitialPreviewState extends PreviewState { }

class ReadyPreviewState extends PreviewState {

  final CameraController controller;

  ReadyPreviewState({@required this.controller});
}

class PermissionsNotGrantedPreviewState extends PreviewState { }

class UnknownErrorPreviewState extends PreviewState { }