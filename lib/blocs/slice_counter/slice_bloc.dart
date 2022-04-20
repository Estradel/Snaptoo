import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/slice.dart';

part 'slice_event.dart';
part 'slice_state.dart';

class SliceBloc extends Bloc<SliceEvent, SliceState> {
  // VERY IMPORTANT : Here the state 'SliceLoading' is chosen as the initialState
  SliceBloc() : super(SliceLoading()) {
    on<LoadSliceCounter>(_onLoadSliceCounter);
    on<AddSlice>(_onAddSlice);
    on<RemoveSlice>(_onRemoveSlice);
  }

  void _onLoadSliceCounter(LoadSliceCounter event, Emitter<SliceState> emit) {
    Future<void>.delayed(const Duration(seconds: 1)); // ?
    emit(const SliceLoaded(slices: <Slice>[])); // initialization of a new empty list of slices
  }

  void _onAddSlice(AddSlice event, Emitter<SliceState> emit) {
    if (state is SliceLoaded) {
      final state = this.state as SliceLoaded;
      emit(SliceLoaded(slices: List.from(state.slices)..add(event.slice)));
    }
  }

  void _onRemoveSlice(RemoveSlice event, Emitter<SliceState> emit) {
    if (state is SliceLoaded) {
      final state = this.state as SliceLoaded;
      emit(SliceLoaded(slices: List.from(state.slices)..remove(event.slice)));
    }
  }
}