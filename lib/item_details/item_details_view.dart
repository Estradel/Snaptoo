import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaptoo/home/pages/collection/bloc/collection_bloc.dart';
import 'package:snaptoo/item_details/bloc/item_details_bloc.dart';

import '../collections/data_models/collection_item.dart';
import '../collections/object_box.dart';
import '../helper/utils.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({Key? key, required this.collectionItem}) : super(key: key);

  final CollectionItem collectionItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemDetailsBloc>(
      create: (context) => ItemDetailsBloc(objectBox: context.read<ObjectBox>()),
      child: _DetailsView(collectionItem: collectionItem),
    ); // loading
  }
}

class _DetailsView extends StatelessWidget {
  const _DetailsView({required this.collectionItem});

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
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: "back",
                    child: const Icon(Icons.arrow_back_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FloatingActionButton(
                    heroTag: "delete",
                    child: const Icon(Icons.delete),
                    backgroundColor: Colors.red,
                    onPressed: () {
                      context.read<ItemDetailsBloc>().add(DeleteItem(
                            itemId: collectionItem.id,
                            imagePath: collectionItem.imagePath!,
                          ));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
