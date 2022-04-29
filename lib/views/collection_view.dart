import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_projet/views/image_view.dart';

import '../Collections/ObjectBox.dart';
import 'main_view.dart';

late List Objects;

List Animaux = [
  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_960_720.jpg",
];

List Fleur = [
  "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/07/11/15/43/pretty-woman-1509956_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/02/13/12/26/aurora-1197753_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
];

List Nourriture = [
  "https://cdn.pixabay.com/photo/2013/11/28/10/03/autumn-219972_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/17/19/08/away-3024773_960_720.jpg",
];

class CollectionView extends StatefulWidget {
  @override
  State createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  String dropdownValue = "Animaux";
  List lItems = Animaux;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initCollections();
  }

  void initCollections() async {
    final objectBox = await ObjectBox.create();
    final objectsDB = objectBox.Object();
    Objects = objectsDB.getAll().map((e) => e.imagePath).toList();
    print(Objects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Collection'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MainView()));
                }),
            const SizedBox(width: 30),
            IconButton(
                icon: const Icon(Icons.collections),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CollectionView()));
                }),
            const SizedBox(width: 30),
            const Icon(Icons.account_box)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Collection',
                style: TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 20),
              MyDropBoxWidget(),
              const SizedBox(height: 30),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ImageView(
                                  imagePath: index.toString(),
                                )));
                      },
                      child: ClipRRect(
                          child: // REPLACEMENT TO DISPLAY LOCAL FILES
                          // Image.network(lItems[index],height: 150,width: 150,)
                              Image.file(
                        File(lItems[index]),
                        height: 150,
                        width: 150,
                      ) // ,
                          ),
                    ),
                  );
                },
                itemCount: lItems.length,
                physics: const ClampingScrollPhysics(),
              )
            ],
          ),
        ));
  }

  @override
  Widget MyDropBoxWidget() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          if (dropdownValue == "Objects")
            lItems = Objects;
          else if (dropdownValue == "Animaux")
            lItems = Animaux;
          else if (dropdownValue == "Fleurs")
            lItems = Fleur;
          else
            lItems = Nourriture;
        });
      },
      items: <String>['Objects', 'Animaux', 'Fleurs', 'Nourriture']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
