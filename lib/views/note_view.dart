import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_projet/Collections/DataModels/ObjectCollectionItem.dart';
import 'package:tuple/tuple.dart';
import '../Collections/ObjectBox.dart';
import 'collection_view.dart';
import 'main_view.dart';

class NoteView extends StatelessWidget {
  NoteView(
      {Key? key,
      required this.categorie,
      required this.imageProv,
      required this.imageBytes,
      required this.listLabel})
      : super(key: key);

  final String categorie;
  final ImageProvider imageProv;
  final File imageBytes;
  final List<Tuple3<String, int, double>> listLabel;

  late final Tuple3<String, int, double> bestmatch;

  @override
  Widget build(BuildContext context) {
    bestmatch = BestMatch(listLabel);

    return Scaffold(
        appBar: AppBar(
          title: Text('Accueil'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MainView()));
                }),
            SizedBox(width: 30),
            IconButton(
                icon: Icon(Icons.collections),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CollectionView()));
                }),
            SizedBox(width: 30),
            Icon(Icons.account_box)
          ],
        ),
        body: Center(
            child: Column(
          children: [
            SizedBox(height: 50),
            Image(image: imageProv, height: 300, width: 300),
            SizedBox(height: 50),
            Text('Catégorie : ' + categorie),
            SizedBox(height: 10),
            Text('Objet : ' + bestmatch.item1),
            SizedBox(height: 10),
            Text('Note : ' + (bestmatch.item3 * 100).toStringAsFixed(2) + "%"),
            SizedBox(height: 50),
            Wrap(
              spacing: 50,
              children: [
                _floatingActionButtonDelete(context),
                _floatingActionButtonAdd(context),
              ],
            )
          ],
        )));
  }

  Widget _floatingActionButtonDelete(BuildContext context) {
    return Container(
        height: 50.0,
        width: 50.0,
        child: FloatingActionButton(
            heroTag: "btn_delete",
            child: Icon(
              Icons.delete,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MainView()));
            }));
  }

  Widget _floatingActionButtonAdd(BuildContext context) {
    return Container(
        height: 50.0,
        width: 50.0,
        child: FloatingActionButton(
          heroTag: "btn_add",
          child: Icon(
            Icons.done,
            size: 30,
          ),
          onPressed: () async {
            //SavePicture();
            String itemName = bestmatch.item1;
            double itemScore = bestmatch.item3;

            Directory appDocDir = await getApplicationDocumentsDirectory();
            String appDocPath = appDocDir.path;
            final File newImage =
                await imageBytes.copy('$appDocPath/$itemName.png');

            print(imageBytes.path);
            print(newImage.path);

            final objectBox = await ObjectBox.create();
            final objects = objectBox.Object();

            objects.put(ObjectCollectionItem(labelName: itemName, score: itemScore, imagePath: '$appDocPath/$itemName.png'));
            objectBox.Close();

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MainView()));
          },
        ));
  }

  Tuple3<String, int, double> BestMatch(List<Tuple3<String, int, double>> labels) {
    final best = labels.reduce((a, b) => a.item3 > b.item3 ? a : b);
    print('\n\nBEST MATCH : $best\n\n\n');
    return best;
  }

  void SavePicture() async {}
}
