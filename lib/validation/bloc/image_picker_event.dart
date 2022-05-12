part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

class InitImagePicker extends ImagePickerEvent {} // default initial state

class PickImagePicker extends ImagePickerEvent {
  const PickImagePicker(this.pickedFile);

  final XFile pickedFile;

  @override
  List<Object> get props => [pickedFile];
}
