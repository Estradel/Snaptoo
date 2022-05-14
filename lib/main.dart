import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'collections/object_box.dart';
import 'my_app.dart';

// Will be made available throughout the entire app
late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Cameras
  cameras = await availableCameras();
  /// ObjectBox
  final objectBox = await ObjectBox.create();
  /// SharePreferences
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(objectBox: objectBox, prefs : prefs));
}
