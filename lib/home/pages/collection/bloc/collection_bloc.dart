import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/src/native/box.dart';
import 'package:snaptoo/collections/data_models/CollectionItem.dart';
import 'package:snaptoo/collections/data_models/ObjectCollectionItem.dart';
import 'package:snaptoo/helper/Utils.dart';
import 'package:tuple/tuple.dart';

import '../../../../collections/ObjectBox.dart';
import '../../../../objectbox.g.dart';
import '../../../../views/image_view.dart';

part 'collection_event.dart';

part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc({required ObjectBox objectBox})
      : _objectBox = objectBox,
        super(CollectionLoading()) {
    on<LoadingCollection>(_onLoadingCollection);
    on<LoadCollection>(_onLoadCollection);
  }

  final ObjectBox _objectBox;

  void _onLoadingCollection(LoadingCollection event, Emitter<CollectionState> emit) {
    emit(CollectionLoading());
  }

  void _onLoadCollection(LoadCollection event, Emitter<CollectionState> emit) {
    // We emit the CollectionLoading state before getting the datas
    emit(CollectionLoading());

    // We retrieve all the datas in ObjectBox + files on the phone
    var filesAndItems = _objectBox
        .getCollectionItems() //
        .where((item) => (item.category == event.category)) //
        .map((item) => Tuple2(File(item.imagePath!), item)) //
        .toList();

    // We emit the CollectionLoaded once the datas have been retrieved
    emit(CollectionLoaded(
      filesAndItems: filesAndItems,
      category: event.category,
    ));
  }
}
