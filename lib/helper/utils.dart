import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:tuple/tuple.dart';

class Utils {
  /*------------------------------------------------------------------*\
  |*							               Attributes 			                    *|
  \*------------------------------------------------------------------*/

  /*------------------------------*\
  |*		        Static		      	*|
  \*------------------------------*/

  // Define the category selected by default (and then it is saved in the shared preferences)
  static const String DEFAULT_CATEGORY = "General";

  // Must be changed whenever a new category of ML-Kit model is added
  static const Map<String, String> CATEGORIES = {
    "General": "Lieux, animaux, objets, ...",
    "Food": "Nourriture",
    "Mushrooms": "Champignons",
    "LandmarkEurope": "Monuments européens",
  };

  // Must be changed whenever a new category of ML-Kit model is added
  static const Map<String, String> MODEL_PER_CATEGORY = {
    "General": "assets/ml/lite-model_objects_V1_1.tflite",
    "Food": "assets/ml/lite-model_food_V1_1.tflite",
    "Mushrooms": "assets/ml/lite-model_mushrooms_V1_1.tflite",
    "LandmarkEurope": "assets/ml/lite-model_landmarks_europe_V1_1.tflite",
  };

  /*------------------------------------------------------------------*\
  |*							                Methods 			                     	*|
  \*------------------------------------------------------------------*/

  /*------------------------------*\
  |*		        Static		      	*|
  \*------------------------------*/

  // Just useful

  static Tuple2<String, double> findBestMatch(List<Tuple2<String, double>> labels) {
    final best = labels.reduce((a, b) => a.item2 > b.item2 ? a : b);
    return best;
  }

  static TValue? customCase<TOptionType, TValue>(
      TOptionType selectedOption, Map<TOptionType, TValue> branches) {
    return branches[selectedOption];
  }

  // Image related

  static Future<Uint8List> testCompressBytes({
    required Uint8List bytes,
    required int minHeight,
    required int quality,
  }) async {
    var result = await FlutterImageCompress.compressWithList(
      bytes,
      minHeight: minHeight,
      quality: quality,
    );
    return result;
  }

  // File related

  static Future<void> saveFile(String path, Uint8List bytesResized) async {
    await File(path).writeAsBytes(bytesResized);
  }

  static Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  // UI related

  static List<DropdownMenuItem<String>> getMenuItems() {
    return [
      for (var category in Utils.CATEGORIES.entries)
        DropdownMenuItem<String>(value: category.key, child: Text(category.value))
    ];
  }

  static Center simpleLoadingMessage({required String message, required bool putCircle}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 120),
          const Icon(
            Icons.smart_toy,
            color: Colors.blue,
            size: 150,
          ),
          const Text(
            "« beep beep boop »",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 85),
          Text(
            message,
            style: TextStyle(
              fontSize: 30,
              color: Colors.black.withOpacity(0.25),
            ),
            textAlign: TextAlign.center,
          ),
          if (putCircle) ...[
            const SizedBox(height: 20),
            const SizedBox(
              child: CircularProgressIndicator(),
              height: 25,
              width: 25,
            ),
          ],
        ],
      ),
    );
  }

  static Center simpleIconMessageBackButton({
    required String message,
    required IconData iconData,
    required bool hasBackButton,
    BuildContext? context,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 120),
          Icon(
            iconData,
            size: 160,
            color: Colors.black.withOpacity(0.25),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.25),
              ),
            ),
          ),
          const SizedBox(height: 65),
          if (hasBackButton)
            Container(
              height: 50.0,
              width: 50.0,
              child: FloatingActionButton(
                heroTag: "btn_delete",
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context!);
                },
              ),
            ),
        ],
      ),
    );
  }

  static List<Widget> customCard({
    required Image image,
    required String label,
    required String category,
    required double score,
  }) {
    return [
      image,
      const SizedBox(height: 15),
      Text(label,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      const SizedBox(height: 15),
      Text(
        'Catégorie : ${Utils.CATEGORIES[category]}',
        style: const TextStyle(fontSize: 18),
      ),
      const SizedBox(height: 5),
      Text(
        'Score : ${(score * 100).toStringAsFixed(2)}%',
        style: const TextStyle(fontSize: 18),
      ),
    ];
  }
}
