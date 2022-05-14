import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

import '../../collections/ObjectBox.dart';
import '../../collections/data_models/CollectionItem.dart';
import '../../helper/ImageLabeler.dart';
import '../../helper/Utils.dart';

part 'validation_event.dart';

part 'validation_state.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  ValidationBloc({required ObjectBox objectBox})
      : _objectBox = objectBox,
        super(ValidationInitial()) {
    on<SaveItem>(_onSaveItem);
    on<AnalyzeImage>(_onAnalyzeImage);
  }

  final ObjectBox _objectBox;

  void _onSaveItem(SaveItem event, Emitter<ValidationState> emit) {
    _objectBox.addCollectionItem(event.collectionItem);
  }

  Future<void> _onAnalyzeImage(AnalyzeImage event, Emitter<ValidationState> emit) async {
    // Emit the state that will make the interface wait for resizing + labelling
    emit(const ImageAnalyzing(putCircle: false));
    // NECESSARY for previous State to have time to be emitted
    await Future.delayed(const Duration(milliseconds: 250));

    // Firstly get the labels of the image (with ML-Kit !)
    var listLabel = await ImageLabeler.getImageLabels(File(event.pickedFile.path));
    // Emit the state that will make the interface wait for resizing + labelling
    emit(const ImageAnalyzing(putCircle: true));

    // Secondly resizes the image (as bytes !)
    var bytesResized = await compute(
      Utils().resizeImage,
      Tuple2(await event.pickedFile.readAsBytes(), 800),
    );

    // Thirdly we check if a picture with same label+category already exists in DB
    var bestLabel = Utils.findBestMatch(listLabel);
    bool existsAlready = _objectBox.checkExistsAlready(bestLabel.item1, event.category);

    // Emit the state that display resized image + labels and image info now that they're ready
    emit(ImageAnalyzed(
      bytesResized: bytesResized,
      listLabel: listLabel,
      existsAlready: existsAlready,
    ));
  }
}
