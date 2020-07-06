
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension CameraToTextRecognizerBridge on TextRecognizer {

  Future<VisionText> processCameraImage(CameraImage image, int orientationAngle) {
    final bytes = _concatenatePlanes(image.planes);
    final metadata = _prepareMetadata(image, orientationAngle);
    final visionImage = FirebaseVisionImage.fromBytes(bytes, metadata);
    return this.processImage(visionImage);
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    planes.forEach((Plane plane) => allBytes.putUint8List(plane.bytes));
    return allBytes.done().buffer.asUint8List();
  }

  FirebaseVisionImageMetadata _prepareMetadata(CameraImage image, int orientationAngle) {
    return FirebaseVisionImageMetadata(
      size: Size(image.width.toDouble(),image.height.toDouble()), // FIXME Size should be picked base on rotation
      rawFormat: image.format.raw,
      planeData: image.planes.map((currentPlane) => FirebaseVisionImagePlaneMetadata(
          bytesPerRow: currentPlane.bytesPerRow,
          height: currentPlane.height,
          width: currentPlane.width
      )).toList(),
      rotation: _pickImageRotation(orientationAngle),
    );
  }

  ImageRotation _pickImageRotation(int orientationAngle) {
    switch(orientationAngle) {
      case 0: return ImageRotation.rotation0;
      case 90: return ImageRotation.rotation90;
      case 180: return ImageRotation.rotation180;
      case 270: return ImageRotation.rotation270;
      default: throw Exception("CameraToTextRecognizerBridge: Rotation must be 0, 90, 180, or 270.");
    }
  }
}