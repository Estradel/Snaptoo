import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

import '../../collections/ObjectBox.dart';
import '../../helper/ImageLabeler.dart';
import '../../helper/Utilities.dart';

part 'image_picker_event.dart';

part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc({required ObjectBox objectBox})
      : _objectBox = objectBox,
        super(ImagePickerInitial()) {
    on<PickImagePicker>(_onPickImagePicker);
  }

  final ObjectBox _objectBox;

  Future<void> _onPickImagePicker(PickImagePicker event, Emitter<ImagePickerState> emit) async {
    // Emit the state that will make the interface wait for resizing + labelling
    emit(ImagePickerPicking());
    // Firstly resizes the image (as bytes !)
    var bytesResized = await compute(
      Utilities().resizeImage,
      Tuple2(await event.pickedFile.readAsBytes(), 300),
    );
    // Secondly get the labels of the image (with ML-Kit !)
    var listLabel = await ImageLabeler.getImageLabels(File(event.pickedFile.path));
    // Emit the state that display resized image + labels and image info now that they're ready
    emit(ImagePickerPicked(bytesResized: bytesResized, listLabel: listLabel));
  }
}
