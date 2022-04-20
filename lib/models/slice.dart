import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Slice extends Equatable {
  final String id;
  final String name;
  final Image image;

  const Slice({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, image];

  static List<Slice> sliceTypes = [
    Slice(
      id: '0',
      name: 'Mushroom',
      image: Image.asset('assets/img/slices/slice_mushroom.png'),
    ),
    Slice(
      id: '1',
      name: 'Pepperoni',
      image: Image.asset('assets/img/slices/slice_pepperoni.png'),
    ),
  ];
}
