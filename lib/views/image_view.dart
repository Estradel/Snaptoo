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
            const SizedBox(height: 100),
            Image.file(
              File(collectionItem.imagePath!),
              height: 300,
            ),
            const SizedBox(height: 20),
            Text(collectionItem.labelName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            Text('Catégorie : ' + collectionItem.category),
            const SizedBox(height: 10),
            Text('Score : ' + (collectionItem.score * 100).toStringAsFixed(2) + "%")
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
