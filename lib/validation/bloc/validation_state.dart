part of 'validation_bloc.dart';

abstract class ValidationState extends Equatable {
  const ValidationState();

  @override
  List<Object> get props => [];
}

class ValidationInitial extends ValidationState {} // default initial state

class ImageAnalyzing extends ValidationState {
  @override
  List<Object> get props => [];
}

class ImageAnalyzed extends ValidationState {
  const ImageAnalyzed({
    required this.bytesResized,
    required this.listLabel,
    required this.existsAlready
  });

  final Uint8List bytesResized;
  final List<Tuple2<String, double>> listLabel;
  final bool existsAlready;

  @override
  List<Object> get props => [bytesResized, listLabel];
}