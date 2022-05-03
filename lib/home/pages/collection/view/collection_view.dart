import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaptoo/main.dart';
import 'package:snaptoo/views/image_view.dart';

import '../../../../collections/ObjectBox.dart';
import '../../../../collections/data_models/ObjectCollectionItem.dart';

late List Objects;

// List Animaux = [
//   "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_960_720.jpg",
// ];
//
// List Fleur = [
//   "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2016/07/11/15/43/pretty-woman-1509956_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2016/02/13/12/26/aurora-1197753_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
// ];
//
// List Nourriture = [
//   "https://cdn.pixabay.com/photo/2013/11/28/10/03/autumn-219972_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2017/12/17/19/08/away-3024773_960_720.jpg",
// ];

class CollectionView extends StatefulWidget {
  const CollectionView({Key? key}) : super(key: key);

  @override
  State createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  String dropdownValue = "Objects";
  late List lItems = Objects;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initCollections();
  }

  void initCollections() async {
    final objectsDB = context.read<ObjectBox>().GetBox<ObjectCollectionItem>();
    Objects = objectsDB.getAll().map((e) => e.imagePath).toList();
    print(Objects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                          ),
                        ));
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
          if (dropdownValue == "Objects") {
            lItems = Objects;
          }
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
