import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as IMG;
import 'package:tuple/tuple.dart';

class Utils {
  /*------------------------------------------------------------------*\
  |*							               Attributes 			                    *|
  \*------------------------------------------------------------------*/

  /*------------------------------*\
  |*		        Static		      	*|
  \*------------------------------*/

  // Must be changed whenever a new category of ML-Kit model is added
  static Map<String, String> categories = {
    "Objects": "Objets",
    "Food": "Nourriture",
  };

  /*------------------------------------------------------------------*\
  |*							                Methods 			                     	*|
  \*------------------------------------------------------------------*/

  // Is not static because it is used in the 'compute' function, which allows to perform
  // this CPU intensive task in its own isolate without blocking the UI.
  Future<Uint8List> resizeImage(Tuple2<Uint8List, int> bytesAndHeight) async {
    IMG.Image? img = IMG.decodeImage(bytesAndHeight.item1); // with compute, it doesn't block UI !
    IMG.Image resized = IMG.copyResize(img!, height: bytesAndHeight.item2);
    return IMG.encodeJpg(resized) as Uint8List;
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

  // UI related

  static List<DropdownMenuItem<String>> getMenuItems() {
    return [
      for (var category in categories.entries)
        DropdownMenuItem<String>(value: category.key, child: Text(category.value))
    ];
  }

  static Center simpleLoadingMessage(String text, bool putCircle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 160),
          const Icon(
            Icons.smart_toy,
            color: Colors.blue,
            size: 150,
          ),
          const SizedBox(height: 40),
          Text(
            text,
            style: const TextStyle(fontSize: 32),
          ),
          if (putCircle) ...[
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Colors.lightBlueAccent),
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
        'Catégorie : ${Utils.categories[category]}',
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
