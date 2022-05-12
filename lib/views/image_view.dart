import 'dart:io';

import 'package:flutter/material.dart';

import '../collections/data_models/CollectionItem.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key, required this.collectionItem}) : super(key: key);

  final CollectionItem collectionItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.file(
              File(collectionItem.imagePath!),
              height: 300,
            ),
            const SizedBox(height: 40),
            Text('Catégorie : ' + collectionItem.category),
            const SizedBox(height: 20),
            Text('Objet : ' + collectionItem.labelName),
            const SizedBox(height: 20),
            Text('Note : ' + (collectionItem.score * 100).toStringAsFixed(2) + "%")
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
