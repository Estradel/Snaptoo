part of 'item_details_bloc.dart';

abstract class ItemDetailsState extends Equatable {
  const ItemDetailsState();

  @override
  List<Object> get props => [];
}

class ItemDetailsInitial extends ItemDetailsState {} // not even used
