import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaptoo/item_details/item_details_view.dart';

import '../../../../collections/object_box.dart';
import '../../../../helper/utils.dart';
import '../bloc/collection_bloc.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionBloc(
        objectBox: context.read<ObjectBox>(),
        prefs: context.read<SharedPreferences>(),
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
              const SizedBox(height: 2),
              BlocBuilder<CollectionBloc, CollectionState>(
                  // all is re-built whenever the state changes
                  builder: (context, state) {
                if (state is CollectionLoading) {
                  return const Padding(
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: CircularProgressIndicator(color: Colors.deepPurpleAccent));
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
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(0, 180, 0, 0),
                      child: CircularProgressIndicator(color: Colors.lightBlueAccent),
                    );
                  } else if (state is CollectionLoaded) {
                    if (state.filesAndItems.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 70),
                          Icon(
                            Icons.image_search,
                            size: 160,
                            color: Colors.black.withOpacity(0.25),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Cette collection est vide !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.filesAndItems.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () async {
                                  final value = await Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsView(
                                        collectionItem: state.filesAndItems[index].item2),
                                  ));
                                  context.read<CollectionBloc>().add(const LoadCollection());
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
                        ),
                      );
                    }
                  } else {
                    return Utils.simpleIconMessageBackButton(
                      message: "Il y a eu un problème.\nVeuillez redémarrer l'application.",
                      iconData: Icons.bug_report,
                      hasBackButton: false,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customDropBoxWidget(BuildContext context, CollectionLoaded state) {
    return DropdownButton<String>(
      value: state.category,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple, fontSize: 20),
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
