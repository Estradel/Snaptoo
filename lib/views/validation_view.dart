import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snaptoo/collections/data_models/ObjectCollectionItem.dart';
import 'package:tuple/tuple.dart';
import '../collections/ObjectBox.dart';
import '../collections/data_models/CollectionItem.dart';
import '../main.dart';

class ValidationView extends StatelessWidget {
  ValidationView(
      {Key? key,
      required this.category,
      required this.imageProv,
      required this.imageBytes,
      required this.listLabel})
      : super(key: key);

  final String category;
  final ImageProvider imageProv;
  final File imageBytes;
  final List<Tuple3<String, int, double>> listLabel;

  @override
  Widget build(BuildContext context) {
    return _ValidationView(
      category: category,
      imageProv: imageProv,
      imageBytes: imageBytes,
      listLabel: listLabel,
    );
  }
}

class _ValidationView extends StatelessWidget {
  _ValidationView(
      {Key? key,
      required this.category,
      required this.imageProv,
      required this.imageBytes,
      required this.listLabel})
      : super(key: key);

  final String category;
  final ImageProvider imageProv;
  final File imageBytes;
  final List<Tuple3<String, int, double>> listLabel;

  late final Tuple3<String, int, double> bestMatch;

  @override
  Widget build(BuildContext context) {
    bestMatch = findBestMatch(listLabel);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image(image: imageProv, height: 300, width: 300),
            const SizedBox(height: 50),
            Text('Catégorie : ' + category),
            const SizedBox(height: 10),
            Text('Objet : ' + bestMatch.item1),
            const SizedBox(height: 10),
            Text('Note : ' + (bestMatch.item3 * 100).toStringAsFixed(2) + "%"),
            const SizedBox(height: 50),
            Wrap(
              spacing: 50,
              children: [
                _floatingActionButtonDelete(context),
                _floatingActionButtonAdd(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _floatingActionButtonDelete(BuildContext context) {
    return Container(
        height: 50.0,
        width: 50.0,
        child: FloatingActionButton(
            heroTag: "btn_delete",
            child: const Icon(
              Icons.delete,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }));
  }

  Widget _floatingActionButtonAdd(BuildContext context) {
    return Container(
        height: 50.0,
        width: 50.0,
        child: FloatingActionButton(
          heroTag: "btn_add",
          child: const Icon(
            Icons.done,
            size: 30,
          ),
          onPressed: () async {
            //SavePicture();
            String itemName = bestMatch.item1;
            double itemScore = bestMatch.item3;

            Directory appDocDir = await getApplicationDocumentsDirectory();
            String appDocPath = appDocDir.path;
            final File newImage = await imageBytes.copy('$appDocPath/${category}_$itemName.png');

            print(imageBytes.path);
            print(newImage.path);

            // À changer à un moment donné
            //--------------------------------------------------------------
            final objectBox = context.read<ObjectBox>();

            objectBox.addCollectionItem(
              CollectionItem(
                labelName: itemName,
                category: category,
                score: itemScore,
                imagePath: '$appDocPath/${category}_$itemName.png',
              ),
            );

            objectBox.getCollectionItems().forEach((element) {
              print(element);
              print("\n");
            });
            //--------------------------------------------------------------

            Navigator.pop(context);
          },
        ));
  }

  Tuple3<String, int, double> findBestMatch(List<Tuple3<String, int, double>> labels) {
    final best = labels.reduce((a, b) => a.item3 > b.item3 ? a : b);
    print('\n\nBEST MATCH : $best\n\n\n');
    return best;
  }

  void SavePicture() async {}
}
