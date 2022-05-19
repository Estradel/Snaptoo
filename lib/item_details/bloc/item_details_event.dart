part of 'item_details_bloc.dart';

abstract class ItemDetailsEvent extends Equatable {
  const ItemDetailsEvent();

  @override
  List<Object> get props => [];
}

class DeleteItem extends ItemDetailsEvent {
  const DeleteItem({required this.itemId, required this.imagePath});

  final int itemId;
  final String imagePath;

  @override
  List<Object> get props => [itemId];
}
