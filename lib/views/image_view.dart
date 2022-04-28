import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'collection_view.dart';
import 'main_view.dart';


class ImageView extends StatelessWidget {
  ImageView(
      {Key? key,
        required this.imagePath})
      : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Image'),
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
              SizedBox(height: 40),
             Text(imagePath),
              SizedBox(height: 40),
              Text("Catégorie : ...."),
              SizedBox(height: 20),
              Text("Objet : ...."),
              SizedBox(height: 20),
              Text("Note : ....")
            ],
          ),

        )
    );
  }

}


