import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

    print("YOOO ???");

    // First resizes, then gets the labels
    var bytesResized =
        await Utilities.resizeImage(await event.pickedFile.readAsBytes(), height: 300);
    print("YOOO-KRRRRRRRR ???");


    var listLabel = await ImageLabeler.getImageLabels(File(event.pickedFile.path));

    print("YOOO-BDDDDDDDDDDDDD ???");


    // Emit the state that display resized image + labels and image info now that they're ready
    emit(ImagePickerPicked(bytesResized: bytesResized, listLabel: listLabel));
  }
}
