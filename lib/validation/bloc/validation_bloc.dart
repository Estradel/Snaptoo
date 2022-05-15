import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:tuple/tuple.dart';

import '../../collections/object_box.dart';
import '../../collections/data_models/collection_item.dart';
import '../../helper/image_labeler.dart';
import '../../helper/utils.dart';

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

  Future<void> _onSaveItem(SaveItem event, Emitter<ValidationState> emit) async {
    // Firstly the image file is saved on the phone storage
    Utils.saveFile(event.imagePath, event.bytesResized);
    // Secondly the collection item is added to the DB
    _objectBox.addCollectionItem(event.collectionItem);
  }

  Future<void> _onAnalyzeImage(AnalyzeImage event, Emitter<ValidationState> emit) async {
    // Emit the state that will make the interface wait for labelling + resizing
    emit(const ImageAnalyzing(message: "L'image est en cours d'analyse !", putCircle: false));
    // Just so the previously emitted state has the time to change the UI
    await Future.delayed(const Duration(milliseconds: 500));

    // Firstly get the labels of the image (with ML-Kit !)
    var listLabel = await ImageLabeler.getImageLabels(File(event.pickedFile.path));

    emit(const ImageAnalyzing(message: "Encore un tout petit peu !", putCircle: true));

    // Secondly resizes the image (as bytes !)
    var bytesResized = await Utils.testCompressBytes(
      bytes: await event.pickedFile.readAsBytes(),
      minHeight: 800,
      quality: 80,
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
