import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/pizza.dart';

part 'pizza_event.dart';

part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  // VERY IMPORTANT : Here the state 'PizzaLoading' is chosen as the initialState
  PizzaBloc() : super(PizzaLoading()) {
    on<LoadPizzaCounter>(_onLoadPizzaCounter);
    on<AddPizza>(_onAddPizza);
    on<RemovePizza>(_onRemovePizza);
  }

  void _onLoadPizzaCounter(LoadPizzaCounter event, Emitter<PizzaState> emit) async {
    Future<void>.delayed(const Duration(seconds: 1)); // ?
    emit(const PizzaLoaded(pizzas: <Pizza>[])); // initialization of a new empty list of pizzas
  }

  void _onAddPizza(AddPizza event, Emitter<PizzaState> emit) {
    if (state is PizzaLoaded) {
      final state = this.state as PizzaLoaded;
      emit(
        PizzaLoaded(pizzas: List.from(state.pizzas)..add(event.pizza)),
      );
    }
  }

  void _onRemovePizza(RemovePizza event, Emitter<PizzaState> emit) {
    if (state is PizzaLoaded) {
      final state = this.state as PizzaLoaded;
      emit(
        PizzaLoaded(pizzas: List.from(state.pizzas)..remove(event.pizza)),
      );
    }
  }
}
