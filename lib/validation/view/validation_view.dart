import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snaptoo/helper/utils.dart';
import 'package:snaptoo/validation/bloc/validation_bloc.dart';
import 'package:tuple/tuple.dart';
import '../../collections/object_box.dart';
import '../../collections/data_models/collection_item.dart';

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
            Tuple2<String, double> bestMatch = Utils.findBestMatch(state.listLabel);
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    ...Utils.customCard(
                      image: Image(image: MemoryImage(state.bytesResized), height: 300),
                      label: bestMatch.item1,
                      category: category,
                      score: bestMatch.item2,
                    ),
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
            return Utils.simpleLoadingMessage(state.message, state.putCircle);
          } else {
            return Utils.simpleMessageCentered(
                "Il y a eu un problème.\nVeuillez redémarrer l'application.");
          }
        },
      ),
    );
  }

  Widget _floatingActionButtonDelete(
      BuildContext context, Tuple2<String, double> bestMatch, bool existAlready) {
    var color = existAlready ? Colors.red : Colors.blue;
    return Container(
        height: 50.0,
        width: 50.0,
        child: FloatingActionButton(
            heroTag: "btn_delete",
            backgroundColor: color,
            child: const Icon(
              Icons.close,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }));
  }

  Widget _floatingActionButtonAdd(BuildContext context, Tuple2<String, double> bestMatch,
      Uint8List bytesResized, bool existsAlready) {
    var color = existsAlready ? Colors.red : Colors.blue;
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
          double itemScore = bestMatch.item2;

          String imagePath =
              '${(await getApplicationDocumentsDirectory()).path}/${category}_$itemName.png';

          context.read<ValidationBloc>().add(
                SaveItem(
                  collectionItem: CollectionItem(
                    labelName: itemName,
                    category: category,
                    score: itemScore,
                    imagePath: imagePath,
                  ),
                  imagePath: imagePath,
                  bytesResized: bytesResized,
                  existsAlready: existsAlready,
                ),
              );

          Navigator.pop(context);
        },
      ),
    );
  }
}
