
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

extension CameraToTextRecognizerBridge on TextRecognizer {

  Future<VisionText> processCameraImage(CameraImage image, int sensorOrientation, NativeDeviceOrientation deviceOrientation) {
    final bytes = _concatenatePlanes(image.planes);
    final metadata = _prepareMetadata(image, sensorOrientation, deviceOrientation);
    final visionImage = FirebaseVisionImage.fromBytes(bytes, metadata);
    return this.processImage(visionImage);
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    planes.forEach((Plane plane) => allBytes.putUint8List(plane.bytes));
    return allBytes.done().buffer.asUint8List();
  }

  FirebaseVisionImageMetadata _prepareMetadata(CameraImage image, int sensorOrientation, NativeDeviceOrientation deviceOrientation) {
    return FirebaseVisionImageMetadata(
      size: Size(image.width.toDouble(),image.height.toDouble()),
      rawFormat: image.format.raw,
      planeData: image.planes.map((currentPlane) => FirebaseVisionImagePlaneMetadata(
          bytesPerRow: currentPlane.bytesPerRow,
          height: currentPlane.height,
          width: currentPlane.width
      )).toList(),
      rotation: _pickImageRotation(sensorOrientation, deviceOrientation),
    );
  }

  ImageRotation _pickImageRotation(int sensorOrientation, NativeDeviceOrientation deviceOrientation) {
    int deviceOrientationCompensation = 0;
    switch (deviceOrientation) {
      case NativeDeviceOrientation.landscapeLeft:
        deviceOrientationCompensation = -90;
        break;
      case NativeDeviceOrientation.landscapeRight:
        deviceOrientationCompensation = 90;
        break;
      case NativeDeviceOrientation.portraitDown:
        deviceOrientationCompensation = 180;
        break;
      default:
        deviceOrientationCompensation = 0;
        break;
    }

    final complexOrientation = (sensorOrientation + deviceOrientationCompensation) % 360;
    switch(complexOrientation) {
      case 0: return ImageRotation.rotation0;
      case 90: return ImageRotation.rotation90;
      case 180: return ImageRotation.rotation180;
      case 270: return ImageRotation.rotation270;
      default: throw Exception("CameraToTextRecognizerBridge: Rotation must be 0, 90, 180, or 270.");
    }
  }
}