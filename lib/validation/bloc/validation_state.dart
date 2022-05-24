part of 'validation_bloc.dart';

abstract class ValidationState extends Equatable {
  const ValidationState();

  @override
  List<Object> get props => [];
}

class ValidationInitial extends ValidationState {} // default initial state

class ImageLabelSearching extends ValidationState {
  const ImageLabelSearching({required this.message, required this.putCircle});

  final String message;
  final bool putCircle;

  @override
  List<Object> get props => [message, putCircle];
}

class ImageLabelNone extends ValidationState {
  const ImageLabelNone();
}

class ImageLabelFound extends ValidationState {
  const ImageLabelFound(
      {required this.bytesResized, required this.listLabel, required this.existsAlready});

  final Uint8List bytesResized;
  final List<Tuple2<String, double>> listLabel;
  final bool existsAlready;

  @override
  List<Object> get props => [bytesResized, listLabel];
}
