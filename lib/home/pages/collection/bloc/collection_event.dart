part of 'collection_bloc.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class LoadingCollection extends CollectionEvent {}

class SetCategory extends CollectionEvent {
  const SetCategory({required this.category});

  final String category;

  @override
  List<Object> get props => [category];
}

class LoadCollection extends CollectionEvent {
  const LoadCollection();

  @override
  List<Object> get props => [];
}

// class AddPizza extends CollectionEvent {}
// class RemovePizza extends CollectionEvent {}
