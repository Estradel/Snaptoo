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
          title: const Text('Image'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(icon: const Icon(Icons.home), onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainView())); }),
            const SizedBox(width: 30),
            IconButton(icon: const Icon(Icons.collections), onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => CollectionView())); }),
            const SizedBox(width: 30),
            const Icon(Icons.account_box)
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
             Text(imagePath),
              const SizedBox(height: 40),
              const Text("Catégorie : ...."),
              const SizedBox(height: 20),
              const Text("Objet : ...."),
              const SizedBox(height: 20),
              const Text("Note : ....")
            ],
          ),

        )
    );
  }

}


