import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaptoo/views/image_view.dart';

import '../../../../collections/ObjectBox.dart';
import '../../../../collections/data_models/CollectionItem.dart';
import '../../../../collections/data_models/ObjectCollectionItem.dart';
import '../../../../helper/Utils.dart';
import '../../../../objectbox.g.dart';
import '../bloc/collection_bloc.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = context.read<SharedPreferences>();
    return BlocProvider(
      create: (context) => CollectionBloc(
        objectBox: context.read<ObjectBox>(),
        prefs: prefs,
      )..add(const LoadCollection()), // loading
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
                const SizedBox(height: 80),
                const Text('Collection', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 20),
                BlocBuilder<CollectionBloc, CollectionState>(
                    // all is re-built whenever the state changes
                    builder: (context, state) {
                  if (state is CollectionLoading) {
                    return const CircularProgressIndicator(color: Colors.deepPurpleAccent);
                  } else if (state is CollectionLoaded) {
                    return customDropBoxWidget(context, state);
                  } else {
                    return const Text("Something went wrong!");
                  }
                }),
                BlocBuilder<CollectionBloc, CollectionState>(
                  // all is re-built whenever the state changes
                  builder: (context, state) {
                    if (state is CollectionLoading) {
                      return const CircularProgressIndicator(color: Colors.lightBlueAccent);
                    } else if (state is CollectionLoaded) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.filesAndItems.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ImageView(collectionItem: state.filesAndItems[index].item2),
                                ));
                              },
                              child: ClipRRect(
                                child: Image.file(
                                  state.filesAndItems[index].item1,
                                  height: 225,
                                ),
                              ),
                            ),
                          );
                        },
                        physics: const ClampingScrollPhysics(),
                      );
                    } else {
                      return Utils.simpleMessageCentered(
                          "Something went wrong.\nPlease reload the app.");
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  Widget customDropBoxWidget(BuildContext context, CollectionLoaded state) {
    return DropdownButton<String>(
      value: state.category,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? category) {
        context.read<CollectionBloc>().add(SetCategory(category: category!));
      },
      items: Utils.getMenuItems(),
    );
  }
}
