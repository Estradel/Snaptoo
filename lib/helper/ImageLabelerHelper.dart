import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart' as MLKit;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:tuple/tuple.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageLabelerHelper {
  static final ImageLabelerHelper _singleton = ImageLabelerHelper._internal();

  factory ImageLabelerHelper() {
    return _singleton;
  }

  ImageLabelerHelper._internal();

  // Attributes
  Map<String, ImageLabeler> imageLabelers = <String, ImageLabeler>{};

  Future<void> initImageLabelers() async {
    final objectModel =
        await _getModel("assets/ml/lite-model_objects_V1_1.tflite");
    final objectOptions = LocalLabelerOptions(modelPath: objectModel);
    final objectLabeler = ImageLabeler(options: objectOptions);
    imageLabelers["General"] = objectLabeler;

    final foodModel =
        await _getModel("assets/ml/lite-model_food_V1_1.tflite");
    final foodOptions = LocalLabelerOptions(modelPath: foodModel);
    final foodLabeler = ImageLabeler(options: foodOptions);
    imageLabelers["Food"] = foodLabeler;

    final europeModel = await _getModel(
        "assets/ml/lite-model_landmarks_europe_V1_1.tflite");
    final europeOptions = LocalLabelerOptions(modelPath: europeModel);
    final europeLabeler = ImageLabeler(options: europeOptions);
    imageLabelers["LandmarkEurope"] = europeLabeler;

    final mushroomModel =
        await _getModel("assets/ml/lite-model_mushrooms_V1_1.tflite");
    final mushroomOptions = LocalLabelerOptions(modelPath: mushroomModel);
    final mushroomLabeler = ImageLabeler(options: mushroomOptions);
    imageLabelers["Mushrooms"] = mushroomLabeler;

    final birdModel = await _getModel("assets/ml/birds_V1_3.tflite");
    final birdOptions = LocalLabelerOptions(modelPath: birdModel);
    final birdLabeler = ImageLabeler(options: birdOptions);
    imageLabelers["Birds"] = birdLabeler;

    final insectModel = await _getModel("assets/ml/insects_V1_3.tflite");
    final insectOptions = LocalLabelerOptions(modelPath: insectModel);
    final insectLabeler = ImageLabeler(options: insectOptions);
    imageLabelers["Insects"] = insectLabeler;

    final wineModel = await _getModel("assets/ml/popular_wine_V1_1.tflite");
    final wineOptions = LocalLabelerOptions(modelPath: wineModel);
    final wineLabeler = ImageLabeler(options: wineOptions);
    imageLabelers["Wines"] = wineLabeler;
  }

  // Returns all the labels along with the index and confidence for given image.
  Future<List<Tuple2<String, double>>> getImageLabels(
      {required File file, required String category}) async {
    List<Tuple2<String, double>> listLabel = [];

    if (!imageLabelers.containsKey(category)) return listLabel;
    final imageLabeler = imageLabelers[category];

    // Create an InputImage
    final inputImage = InputImage.fromFile(file);
    // Call the corresponding method
    final List<ImageLabel> labels = [];
    // If the general category was picked, we first use ALSO the default Google Model
    if (category == 'General') {
      final defaultImageLabel = GoogleMlKit.vision.imageLabeler();
      labels.addAll(await defaultImageLabel.processImage(inputImage));
      defaultImageLabel.close();
    }

    // Label the image with the custom model
    labels.addAll(await imageLabeler!.processImage(inputImage));
    // Extract the interesting informations from the labels
    for (ImageLabel label in labels) {
      listLabel.add(Tuple2(label.label, label.confidence));
    }

    return listLabel;
  }

  Future<String> _getModel(String assetPath) async {
    if (Platform.isAndroid) {
      return 'flutter_assets/$assetPath';
    }
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }
}
