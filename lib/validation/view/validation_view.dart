import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snaptoo/collections/data_models/ObjectCollectionItem.dart';
import 'package:snaptoo/helper/Utilities.dart';
import 'package:snaptoo/validation/bloc/validation_bloc.dart';
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
      create: (context) => ValidationBloc(objectBox: context.read<ObjectBox>())
        ..add(AnalyzeImage(pickedFile, category)), // loading
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
      body: BlocBuilder<ValidationBloc, ValidationState>(
        // all is re-built whenever the state changes
        builder: (context, state) {
          if (state is ImageAnalyzed) {
            Tuple3<String, int, double> bestMatch = Utilities.findBestMatch(state.listLabel);
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Image(image: MemoryImage(state.bytesResized), height: 300),
                    const SizedBox(height: 20),
                    Text(bestMatch.item1,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 20),
                    Text('Catégorie : ' + category),
                    const SizedBox(height: 10),
                    Text('Score : ' + (bestMatch.item3 * 100).toStringAsFixed(2) + "%"),
                    const SizedBox(height: 25),
                    state.existsAlready
                        ? const Text(
                            'Vous possédez déjà cet objet.\nSouhaitez-vous l\'écraser ?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            "Souhaitez-vous conserver cet objet ?",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    const SizedBox(height: 25),
                    Wrap(
                      spacing: 50,
                      children: [
                        _floatingActionButtonDelete(
                          context,
                          bestMatch,
                          state.existsAlready,
                        ),
                        _floatingActionButtonAdd(
                          context,
                          bestMatch,
                          state.bytesResized,
                          state.existsAlready,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else if (state is ImageAnalyzing) {
            return Utilities.simpleLoadingMessage("Beep boop, please wait !");
          } else {
            return Utilities.simpleMessageCentered("Something went wrong. Please reload the app.");
          }
        },
      ),
    );
  }

  Widget _floatingActionButtonDelete(
      BuildContext context, Tuple3<String, int, double> bestMatch, bool existAlready) {
    var color = existAlready ? Colors.red : Colors.blue;
    return Container(
        height: 50.0,
        width: 50.0,
        child: FloatingActionButton(
            heroTag: "btn_delete",
            backgroundColor: color,
            child: const Icon(
              Icons.delete,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }));
  }

  Widget _floatingActionButtonAdd(BuildContext context, Tuple3<String, int, double> bestMatch,
      Uint8List bytes, bool existAlready) {
    var color = existAlready ? Colors.red : Colors.blue;
    return Container(
      height: 50.0,
      width: 50.0,
      child: FloatingActionButton(
        heroTag: "btn_add",
        backgroundColor: color,
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

          //--------------------------------------------------------------

          Navigator.pop(context);
        },
      ),
    );
  }
}
