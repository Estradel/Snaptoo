import 'dart:io';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:tuple/tuple.dart';

class ImageLabeler {
  // Returns all the labels along with the index and confidence for given image.
  static Future<List<Tuple3<String, int, double>>> getImageLabels(File file) async {
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
}
