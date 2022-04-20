part of 'pizza_bloc.dart';

abstract class PizzaState extends Equatable {
  const PizzaState();

  @override
  List<Object> get props => [];
}

class PizzaLoading extends PizzaState {} // default initial state

class PizzaLoaded extends PizzaState { // when list of pizzas is updated
  final List<Pizza> pizzas;

  const PizzaLoaded({required this.pizzas});

  @override
  List<Object> get props => [pizzas];
}
