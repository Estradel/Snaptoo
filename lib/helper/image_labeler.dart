import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:snaptoo/helper/utils.dart';
import 'package:tuple/tuple.dart';

class MyImageLabeler {
  static Future<String> getModel(String assetPath) async {
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

  // Returns all the labels along with the index and confidence for given image.
  static Future<List<Tuple2<String, double>>> getImageLabels({
    required File file,
    required String category,
  }) async {
    // Create an InputImage
    final inputImage = InputImage.fromFile(file);
    // Prepare the list of labels that we will fill
    final List<ImageLabel> labels = [];
    // If the general category was picked, we first use ALSO the default Google Model
    if (category == 'General') {
      final defaultImageLabel = GoogleMlKit.vision.imageLabeler();
      labels.addAll(await defaultImageLabel.processImage(inputImage));
      defaultImageLabel.close();
    }
    // Create the custom model based on tflite file
    final modelPath = await MyImageLabeler.getModel(Utils.MODEL_PER_CATEGORY[category]!);
    final options = LocalLabelerOptions(modelPath: modelPath);
    final imageLabeler = ImageLabeler(options: options);
    // Label the image with the custom model
    labels.addAll(await imageLabeler.processImage(inputImage));
    // Extract the interesting informations from the labels
    List<Tuple2<String, double>> listLabel = [];
    for (ImageLabel label in labels) {
      listLabel.add(Tuple2(label.label, label.confidence));
    }
    // Release resources
    imageLabeler.close();

    return listLabel;
  }
}
