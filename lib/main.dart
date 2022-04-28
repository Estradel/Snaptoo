import 'package:flutter/material.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snaptoo/objectbox.g.dart';
import 'app.dart';

import 'package:tuple/tuple.dart';

import 'Collections/DataModels/FoodCollectionItem.dart';
import 'Collections/ObjectBox.dart';

// Returns an image asset in the form of a File object.
Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');
  final file = await File('${(await getTemporaryDirectory()).path}/$path')
      .create(recursive: true);

  if (await Permission.storage
      .request()
      .isGranted) {
    await file.writeAsBytes(byteData.buffer.asUint8List(
        byteData.offsetInBytes, byteData.lengthInBytes));
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

  runApp(const MyApp());

  // Create a File that will then be used to create an ML-Kit's InputImage.
  File file = await getImageFileFromAssets(
      'images/bus.jpg'); // FOR SOME TESTING, THERE 3 DIFFERENT IMAGES IN THE ASSETS

  // Retrieve the labels ML-Kit detects for a given image file.
  List<Tuple3<String, int, double>> listLabel = await getImageLabels(file);

  // JUSTE UN PETIT PRINT POUR TESTER
  print('\n\nLES LABELS DETECTES POUR L\'IMAGE CHOISIE : $listLabel\n\n\n');


  final objectBox = await ObjectBox.create();
  final foodBox = objectBox.Food();

  for (var element in listLabel) {
    foodBox.put(FoodCollectionItem(labelName: element.item1, score: element.item2, imagePath: "default path"));
  }

  List<FoodCollectionItem> foodItemList = foodBox.getAll();
  print('\n\nItems stockés dans la DB : \n\n');
  for (var element in foodItemList) {
    print('$element.toString() \n');
  }

  foodBox.removeAll();
  objectBox.Close();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Image from assets"),
        ),
        body: Image.asset(
            'assets/images/bus.jpg'), // FOR SOME TESTING, THERE 3 DIFFERENT IMAGES IN THE ASSETS
      ),
    );
  }
}