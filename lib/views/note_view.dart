import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'collection_view.dart';
import 'main_view.dart';

class NoteView extends StatelessWidget {
  NoteView(
      {Key? key,
        required this.categorie,
        required this.imageProv,
        required this.imageBytes})
      : super(key: key);

  final String categorie;
  final ImageProvider imageProv;
  final File imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Accueil'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(icon: Icon(Icons.home), onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainView())); }),
            SizedBox(width: 30),
            IconButton(icon: Icon(Icons.collections), onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => CollectionView())); }),
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
                Text('Objet : ....'),
                SizedBox(height: 10),
                Text('Note : ....'),
                SizedBox(height: 50),
                Wrap(
                  spacing: 50,
                  children: [
                    _floatingActionButtonDelete(context),
                    _floatingActionButtonAdd(context),
                  ],
                )
              ],
            )
        )
    );
  }

  Widget _floatingActionButtonDelete(BuildContext context) {

    return Container(
        height: 50.0,
        width: 50.0,
        child: FloatingActionButton(heroTag: "btn_delete",
          child: Icon(
            Icons.delete,
            size: 30,
          ),
          onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainView()));
        }
        ));
  }

  Widget _floatingActionButtonAdd(BuildContext context) {

    return Container(
        height: 50.0,
        width: 50.0,
        child: FloatingActionButton(heroTag: "btn_add",
          child: Icon(
            Icons.done,
            size: 30,
          ),
          onPressed: () async {
              //SavePicture();

              Directory appDocDir = await getApplicationDocumentsDirectory();
              String appDocPath = appDocDir.path;
              final File newImage = await imageBytes.copy('$appDocPath/image1.png');

              print(imageBytes.path);
              print(newImage.path);

              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainView()));
          },
        ));
  }

  void SavePicture() async
  {



  }

}