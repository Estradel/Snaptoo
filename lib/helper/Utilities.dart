import 'package:flutter/material.dart';
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
    return [
      const DropdownMenuItem<String>(value: "Objects", child: Text("Objets")),
      const DropdownMenuItem<String>(value: "Food", child: Text("Nourriture")),
    ];
  }
}
