import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/src/native/box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaptoo/collections/data_models/CollectionItem.dart';
import 'package:snaptoo/collections/data_models/ObjectCollectionItem.dart';
import 'package:snaptoo/helper/Utils.dart';
import 'package:tuple/tuple.dart';

import '../../../../collections/ObjectBox.dart';
import '../../../../objectbox.g.dart';
import '../../../../views/details_view.dart';

part 'collection_event.dart';

part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc({required ObjectBox objectBox, required SharedPreferences prefs})
      : _objectBox = objectBox,
        _prefs = prefs,
        super(CollectionLoading()) {
    on<LoadingCollection>(_onLoadingCollection);
    on<SetCategory>(_onSetCategory);
    on<LoadCollection>(_onLoadCollection);
  }

  final ObjectBox _objectBox;
  final SharedPreferences _prefs;

  void _onLoadingCollection(LoadingCollection event, Emitter<CollectionState> emit) {
    emit(CollectionLoading());
  }

  void _onSetCategory(SetCategory event, Emitter<CollectionState> emit) {
    _prefs.setString("Current_Category", event.category);
    add(const LoadCollection());
  }

  void _onLoadCollection(LoadCollection event, Emitter<CollectionState> emit) {
    // We emit the CollectionLoading state before getting the datas
    emit(CollectionLoading());

    final category = _prefs.getString("Current_Category") ?? Utils.DEFAULT_CATEGORY;

    // We retrieve all the datas in ObjectBox + files on the phone
    var filesAndItems = _objectBox
        .getCollectionItems() //
        .where((item) => (item.category == category)) //
        .map((item) => Tuple2(File(item.imagePath!), item)) //
        .toList();

    // We emit the CollectionLoaded once the datas have been retrieved
    emit(CollectionLoaded(
      filesAndItems: filesAndItems,
      category: category,
    ));
  }
}
