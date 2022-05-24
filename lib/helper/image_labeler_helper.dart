import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:snaptoo/helper/utils.dart';
import 'package:tuple/tuple.dart';
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
    for (var entry in Utils.MODEL_PER_CATEGORY.entries) {
      final model = await _getModel(entry.value);
      final options = LocalLabelerOptions(modelPath: model);
      final labeler = ImageLabeler(options: options);
      imageLabelers[entry.key] = labeler;
    }
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
      await file.writeAsBytes(
          byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }
}
