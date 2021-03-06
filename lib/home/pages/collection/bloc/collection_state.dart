part of 'collection_bloc.dart';

abstract class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object> get props => [];
}

class CollectionLoading extends CollectionState {} // default initial state

class CollectionLoaded extends CollectionState {
  const CollectionLoaded({
    required this.filesAndItems,
    required this.category,
  });

  final List<Tuple2<File, CollectionItem>> filesAndItems;
  final String category;

  @override
  List<Object> get props => [filesAndItems, category];
}
