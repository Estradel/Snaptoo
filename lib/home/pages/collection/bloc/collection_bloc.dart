import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:objectbox/src/native/box.dart';
import 'package:snaptoo/collections/data_models/CollectionItem.dart';
import 'package:snaptoo/collections/data_models/ObjectCollectionItem.dart';
import 'package:snaptoo/helper/Utilities.dart';

import '../../../../collections/ObjectBox.dart';
import '../../../../objectbox.g.dart';

part 'collection_event.dart';

part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc({required ObjectBox objectBox})
      : _objectBox = objectBox,
        super(CollectionChoosing()) {
    on<LoadCollection>(_onLoadCollection);
  }

  final ObjectBox _objectBox;

  void _onLoadCollection(LoadCollection event, Emitter<CollectionState> emit) {

    emit(CollectionLoading());

    var list = _objectBox
        .getCollectionItems()
        .where((item) => (item.category == event.category))
        .toList();

    emit(CollectionLoaded(
        collectionItems: list,
        category: event.category));
  }
}
