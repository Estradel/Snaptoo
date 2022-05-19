import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../collections/object_box.dart';
import '../../helper/utils.dart';

part 'item_details_event.dart';

part 'item_details_state.dart';

class ItemDetailsBloc extends Bloc<ItemDetailsEvent, ItemDetailsState> {
  ItemDetailsBloc({required ObjectBox objectBox})
      : _objectBox = objectBox,
        super(ItemDetailsInitial()) {
    on<DeleteItem>(_onDeleteItem);
  }

  final ObjectBox _objectBox;

  Future<void> _onDeleteItem(DeleteItem event, Emitter<ItemDetailsState> emit) async {
    // Firstly the image file is removed from the phone storage
    Utils.deleteFile(File(event.imagePath));
    // Secondly the collection item is removed from the DB
    _objectBox.removeCollectionItem(event.itemId);
  }
}
