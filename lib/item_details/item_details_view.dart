import 'dart:io';

import 'package:flutter/material.dart';

import '../collections/data_models/collection_item.dart';
import '../helper/utils.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({Key? key, required this.collectionItem}) : super(key: key);

  final CollectionItem collectionItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            ...Utils.customCard(
              image: Image.file(File(collectionItem.imagePath!), height: 375),
              label: collectionItem.labelName,
              category: collectionItem.category,
              score: collectionItem.score,
            ),
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
