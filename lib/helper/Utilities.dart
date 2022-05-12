import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as IMG;
import 'package:snaptoo/collections/data_models/CollectionItem.dart';
import 'package:snaptoo/collections/data_models/ObjectCollectionItem.dart';

class Utilities {
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

  static Future<Uint8List> resizeImage(Uint8List data, {required int height}) async {
    IMG.Image? img = await compute(IMG.decodeImage, data); // with compute, it doesn't block UI !
    IMG.Image resized = IMG.copyResize(img!, height: height);
    return (await compute(IMG.encodeJpg, resized)) as Uint8List;
  }

  static Column simpleLoadingMessage(String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(color: Colors.lightBlueAccent),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 32),
            ),
          ],
        ),
      ],
    );
  }

  static Column simpleMessageCentered(String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 32),
            ),
          ],
        ),
      ],
    );
  }
}
