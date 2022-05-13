part of 'validation_bloc.dart';

abstract class ValidationEvent extends Equatable {
  const ValidationEvent();

  @override
  List<Object> get props => [];
}

class InitValidation extends ValidationEvent {} // default initial state

class AnalyzeImage extends ValidationEvent {
  const AnalyzeImage(this.pickedFile, this.category);

  final XFile pickedFile;
  final String category;

  @override
  List<Object> get props => [pickedFile, category];
}
