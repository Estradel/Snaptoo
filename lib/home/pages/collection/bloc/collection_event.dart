part of 'collection_bloc.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class LoadCollection extends CollectionEvent {
  const LoadCollection(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}

// class AddPizza extends CollectionEvent {}
// class RemovePizza extends CollectionEvent {}
