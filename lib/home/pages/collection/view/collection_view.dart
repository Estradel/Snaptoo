import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snaptoo/views/image_view.dart';

import '../../../../collections/ObjectBox.dart';
import '../../../../collections/data_models/CollectionItem.dart';
import '../../../../collections/data_models/ObjectCollectionItem.dart';
import '../../../../helper/Utilities.dart';
import '../../../../objectbox.g.dart';
import '../bloc/collection_bloc.dart';

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

class CollectionView extends StatelessWidget {
  const CollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionBloc(objectBox: context.read<ObjectBox>()), // loading
      child: _CollectionView(),
    );
  }
}

class _CollectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Collection',
                  style: TextStyle(fontSize: 48),
                ),
                const SizedBox(height: 20),
                MyDropBoxWidget(context),
                const SizedBox(height: 30),
                BlocBuilder<CollectionBloc, CollectionState>(
                  // all is re-built whenever the state changes
                  builder: (context, state) {
                    if (state is CollectionLoading) {
                      return const CircularProgressIndicator(color: Colors.lightBlueAccent);
                    } else if (state is CollectionLoaded) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.collectionItems.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ImageView(collectionItem: state.collectionItems[index]),
                                ));
                              },
                              child: ClipRRect(
                                child: Image.file(
                                  File(state.collectionItems[index].imagePath!),
                                  height: 150,
                                  width: 150,
                                ), // ,
                              ),
                            ),
                          );
                        },
                        physics: const ClampingScrollPhysics(),
                      );
                    } else if (state is CollectionChoosing) {
                      return const Text("Pick a category !");
                    } else {
                      return const Text("Something went wrong!");
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  Widget MyDropBoxWidget(BuildContext context) {
    late String? dropDownValue;

    var state = context.watch<CollectionBloc>().state;

    if (state is CollectionLoading) {
      dropDownValue = "Objects";
    } else if (state is CollectionLoaded) {
      dropDownValue = state.category;
    } else {
      dropDownValue = null;
    }

    return DropdownButton<String>(
      hint: const Text("Categories"),
      value: dropDownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? category) {
        context.read<CollectionBloc>().add(LoadCollection(category!));
      },
      items: Utilities.getMenuItems(),
    );
  }
}
