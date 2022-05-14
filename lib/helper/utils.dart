import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:tuple/tuple.dart';

class Utils {
  /*------------------------------------------------------------------*\
  |*							               Attributes 			                    *|
  \*------------------------------------------------------------------*/

  /*------------------------------*\
  |*		        Static		      	*|
  \*------------------------------*/

  // Define the category selected by default (and then it's saved in the shared preferences)
  static const String DEFAULT_CATEGORY = "Objects";

  // Must be changed whenever a new category of ML-Kit model is added
  static const Map<String, String> CATEGORIES = {
    "Objects": "Objets",
    "Food": "Nourriture",
  };

  /*------------------------------------------------------------------*\
  |*							                Methods 			                     	*|
  \*------------------------------------------------------------------*/

  // Is not static because it is used in the 'compute' function, which allows to perform
  // this CPU intensive task in its own isolate without blocking the UI.
  Future<Uint8List> resizeImage(Tuple2<Uint8List, int> bytesAndHeight) async {
    img.Image? image = img.decodeImage(bytesAndHeight.item1); // with compute, it doesn't block UI !
    img.Image resized = img.copyResize(image!, height: bytesAndHeight.item2);
    return img.encodeJpg(resized) as Uint8List;
  }

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

  static Center simpleLoadingMessage(String text, bool putCircle) {
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
            text,
            style: const TextStyle(fontSize: 30),
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

  static Center simpleMessageCentered(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 32),
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
