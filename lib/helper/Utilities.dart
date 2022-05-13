import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as IMG;
import 'package:snaptoo/collections/data_models/CollectionItem.dart';
import 'package:snaptoo/collections/data_models/ObjectCollectionItem.dart';
import 'package:tuple/tuple.dart';

class Utilities {
  Future<Uint8List> resizeImage(Tuple2<Uint8List, int> bytesAndHeight) async {
    IMG.Image? img = IMG.decodeImage(bytesAndHeight.item1); // with compute, it doesn't block UI !
    IMG.Image resized = IMG.copyResize(img!, height: bytesAndHeight.item2);
    return IMG.encodeJpg(resized) as Uint8List;
  }

  static Tuple3<String, int, double> findBestMatch(List<Tuple3<String, int, double>> labels) {
    final best = labels.reduce((a, b) => a.item3 > b.item3 ? a : b);
    print('\n\nBEST MATCH : $best\n\n\n');
    return best;
  }

  // This is simply a "smart" implementation of a regular switch-case that is directly usable as is
  // in the Scaffold code area.
  static TValue? customCase<TOptionType, TValue>(
      TOptionType selectedOption, Map<TOptionType, TValue> branches) {
    return branches[selectedOption];
  }

  static List<DropdownMenuItem<String>> getMenuItems() {
    return const [
      DropdownMenuItem<String>(value: "Objects", child: Text("Objets")),
      DropdownMenuItem<String>(value: "Food", child: Text("Nourriture")),
    ];
  }

  static Center simpleLoadingMessage(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          const SizedBox(height: 40),
          const CircularProgressIndicator(color: Colors.lightBlueAccent),
          const SizedBox(height: 120),
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
}
