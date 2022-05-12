import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snaptoo/collections/data_models/ObjectCollectionItem.dart';
import 'package:snaptoo/helper/Utilities.dart';
import 'package:snaptoo/validation/bloc/image_picker_bloc.dart';
import 'package:tuple/tuple.dart';
import '../../collections/ObjectBox.dart';
import '../../collections/data_models/CollectionItem.dart';
import '../../main.dart';

class ValidationView extends StatelessWidget {
  const ValidationView({
    Key? key,
    required this.category,
    required this.pickedFile,
  }) : super(key: key);

  final String category;
  final XFile pickedFile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagePickerBloc(objectBox: context.read<ObjectBox>())
        ..add(PickImagePicker(pickedFile)), // loading
      child: _ValidationView(
        category: category,
      ),
    );
  }
}

class _ValidationView extends StatelessWidget {
  const _ValidationView({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        // all is re-built whenever the state changes
        builder: (context, state) {
          if (state is ImagePickerPicked) {
            Tuple3<String, int, double> bestMatch = findBestMatch(state.listLabel);
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Image(image: MemoryImage(state.bytesResized), height: 300, width: 300),
                    const SizedBox(height: 50),
                    Text('Catégorie : ' + category),
                    const SizedBox(height: 10),
                    Text('Objet : ' + bestMatch.item1),
                    const SizedBox(height: 10),
                    Text('Note : ' + (bestMatch.item3 * 100).toStringAsFixed(2) + "%"),
                    const SizedBox(height: 50),
                    Wrap(
                      spacing: 50,
                      children: [
                        _floatingActionButtonDelete(context, bestMatch),
                        _floatingActionButtonAdd(context, bestMatch, state.bytesResized),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else if (state is ImagePickerPicking) {
            print("SALUUUT ????");
            return Utilities.simpleLoadingMessage(
                "Beep-bop, please wait.");
          } else {
            return Utilities.simpleMessageCentered("Something went wrong. Please reload the app.");
          }
        },
      ),
    );
  }

  Widget _floatingActionButtonDelete(BuildContext context, Tuple3<String, int, double> bestMatch) {
    return Container(
        height: 50.0,
        width: 50.0,
        child: FloatingActionButton(
            heroTag: "btn_delete",
            child: const Icon(
              Icons.delete,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }));
  }

  Widget _floatingActionButtonAdd(
      BuildContext context, Tuple3<String, int, double> bestMatch, Uint8List bytes) {
    return Container(
        height: 50.0,
        width: 50.0,
        child: FloatingActionButton(
          heroTag: "btn_add",
          child: const Icon(
            Icons.done,
            size: 30,
          ),
          onPressed: () async {
            String itemName = bestMatch.item1;
            double itemScore = bestMatch.item3;

            String appDocPath = (await getApplicationDocumentsDirectory()).path;
            File image = await File('$appDocPath/${category}_$itemName.png').writeAsBytes(bytes);

            print(image.path);

            // À changer à un moment donné
            //--------------------------------------------------------------
            final objectBox = context.read<ObjectBox>();

            objectBox.addCollectionItem(
              CollectionItem(
                labelName: itemName,
                category: category,
                score: itemScore,
                imagePath: '$appDocPath/${category}_$itemName.png',
              ),
            );

            objectBox.getCollectionItems().forEach((element) {
              print(element);
              print("\n");
            });
            //--------------------------------------------------------------

            Navigator.pop(context);
          },
        ));
  }

  Tuple3<String, int, double> findBestMatch(List<Tuple3<String, int, double>> labels) {
    final best = labels.reduce((a, b) => a.item3 > b.item3 ? a : b);
    print('\n\nBEST MATCH : $best\n\n\n');
    return best;
  }
}
