import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'collections/ObjectBox.dart';
import 'my_app.dart';

// Will be made available throughout the entire app
late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Cameras
  cameras = await availableCameras();
  /// ObjectBox
  final objectBox = await ObjectBox.create();

  runApp(MyApp(objectBox: objectBox));
}
