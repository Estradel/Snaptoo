import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Pizza extends Equatable {
  final String id;
  final String name;
  final Image image;

  const Pizza({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, image];

  static List<Pizza> pizzaTypes = [
    Pizza(
      id: '0',
      name: 'Mushroom',
      image: Image.asset('assets/img/pizzas/pizza_mushroom.png'),
    ),
    Pizza(
      id: '1',
      name: 'Pepperoni',
      image: Image.asset('assets/img/pizzas/pizza_pepperoni.png'),
    ),
  ];
}
