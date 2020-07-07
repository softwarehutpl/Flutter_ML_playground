import 'package:camera/camera.dart';

extension CameraImageSizeHelper on CameraImage {
  double calculateAspectRatio() {
    return height.toDouble() / width.toDouble();
  }
}