part of 'collection_bloc.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class LoadingCollection extends CollectionEvent {}

class LoadCollection extends CollectionEvent {
  const LoadCollection(this.category, this.context);

  final String category;
  final BuildContext context;

  @override
  List<Object> get props => [category, context];
}

// class AddPizza extends CollectionEvent {}
// class RemovePizza extends CollectionEvent {}
