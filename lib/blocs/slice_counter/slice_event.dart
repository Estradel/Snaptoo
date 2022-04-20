part of 'slice_bloc.dart';

abstract class SliceEvent extends Equatable {
  const SliceEvent();

  @override
  List<Object> get props => [];
}

class LoadSliceCounter extends SliceEvent {}

class AddSlice extends SliceEvent {
  final Slice slice;

  const AddSlice(this.slice);

  @override
  List<Object> get props => [slice];
}

class RemoveSlice extends SliceEvent {
  final Slice slice;

  const RemoveSlice(this.slice);

  @override
  List<Object> get props => [slice];
}