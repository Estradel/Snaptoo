part of 'image_picker_bloc.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object> get props => [];
}

class ImagePickerInitial extends ImagePickerState {} // default initial state

class ImagePickerPicking extends ImagePickerState {
  @override
  List<Object> get props => [];
}

class ImagePickerPicked extends ImagePickerState {
  const ImagePickerPicked({
    required this.bytesResized,
    required this.listLabel,
  });

  final Uint8List bytesResized;
  final List<Tuple3<String, int, double>> listLabel;

  @override
  List<Object> get props => [bytesResized, listLabel];
}