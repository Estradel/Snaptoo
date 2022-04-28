part of 'slice_bloc.dart';

abstract class SliceState extends Equatable {
  const SliceState();

  @override
  List<Object> get props => [];
}

class SliceLoading extends SliceState {} // default initial state

class SliceLoaded extends SliceState { // when list of slices is updated
  final List<Slice> slices;

  const SliceLoaded({required this.slices});

  @override
  List<Object> get props => [slices];
}