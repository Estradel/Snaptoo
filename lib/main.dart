import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_projet/views/main_view.dart';
import 'package:tuple/tuple.dart';

List<CameraDescription> cameras = [];

// Returns an image asset in the form of a File object.
Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');
  final file = await File('${(await getTemporaryDirectory()).path}/$path')
      .create(recursive: true);

  if (await Permission.storage.request().isGranted) {
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }

  return file;
}

// Returns all the labels along with the index and confidence for given image.
Future<List<Tuple3<String, int, double>>> getImageLabels(File file) async {
  List<Tuple3<String, int, double>> listLabel = [];

  // Create an InputImage
  final inputImage = InputImage.fromFile(file);
  // Create an instance of detector
  final imageLabeler = GoogleMlKit.vision.imageLabeler();
  // Call the corresponding method
  final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
  // Extract data from response
  // Extract labels
  for (ImageLabel label in labels) {
    listLabel.add(Tuple3(label.label, label.index, label.confidence));
  }
  // Release resources
  imageLabeler.close();

  return listLabel;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainView();
  }
}
