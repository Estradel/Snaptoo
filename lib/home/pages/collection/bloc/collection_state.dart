part of 'collection_bloc.dart';

abstract class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object> get props => [];
}

class CollectionChoosing extends CollectionState {} // default initial state

class CollectionLoading extends CollectionState {}

class CollectionLoaded extends CollectionState {
  const CollectionLoaded({required this.collectionItems, required this.category});

  final List<CollectionItem> collectionItems;
  final String category;


  @override
  List<Object> get props => [collectionItems, category];
}