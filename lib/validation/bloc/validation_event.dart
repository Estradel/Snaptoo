part of 'validation_bloc.dart';

abstract class ValidationEvent extends Equatable {
  const ValidationEvent();

  @override
  List<Object> get props => [];
}

class InitValidation extends ValidationEvent {} // default initial state

class SaveItem extends ValidationEvent {
  const SaveItem({
    required this.collectionItem,
    required this.imagePath,
    required this.bytesResized,
    required this.existsAlready,
  });

  final CollectionItem collectionItem;
  final String imagePath;
  final Uint8List bytesResized;
  final bool existsAlready;

  @override
  List<Object> get props => [collectionItem, imagePath, bytesResized, existsAlready];
}

class AnalyzeImage extends ValidationEvent {
  const AnalyzeImage(this.pickedFile, this.category);

  final XFile pickedFile;
  final String category;

  @override
  List<Object> get props => [pickedFile, category];
}
