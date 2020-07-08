import 'package:camera/camera.dart';

extension CameraImageSizeHelper on CameraImage {
  double calculateAspectRatio(int sensorOrientation) {
    switch(sensorOrientation) {
      case 0: return width.toDouble() / height.toDouble();
      case 90: return height.toDouble() / width.toDouble();
      case 180: return width.toDouble() / height.toDouble();
      case 270: return height.toDouble() / width.toDouble();
      default: throw Exception("CameraToTextRecognizerBridge: Rotation must be 0, 90, 180, or 270.");
    }
  }
}