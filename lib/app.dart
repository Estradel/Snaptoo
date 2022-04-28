import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/pizza_counter/pizza_bloc.dart';
import 'blocs/slice_counter/slice_bloc.dart';
import 'models/pizza.dart';
import 'models/slice.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PizzaBloc()..add(LoadPizzaCounter()), // here we directly prepare the pizza counter
        ),
        BlocProvider(
          create: (context) =>
              SliceBloc()..add(LoadSliceCounter()), // here we directly prepare the slice counter
        )
      ],
      child: const MaterialApp(
        title: 'Flutter BloC Pattern',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var random = Random();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Counter with BloC'),
        backgroundColor: Colors.orange[800],
      ),
      body: Center(
        // This whole part UNDER the BlocBuilder re-builds ENTIRELY when a new pizza state is emitted
        child: BlocBuilder<PizzaBloc, PizzaState>(builder: (pizzaContext, pizzaState) {
          // This whole part UNDER the BlocBuilder re-builds ENTIRELY when a new slice state is emitted
          return BlocBuilder<SliceBloc, SliceState>(builder: (sliceContext, sliceState) {
            if (pizzaState is PizzaLoading || sliceState is SliceLoading) {
              return const CircularProgressIndicator(color: Colors.orange);
            }
            if (pizzaState is PizzaLoaded && sliceState is SliceLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pizzas\n${pizzaState.pizzas.length}',
                          style: const TextStyle(fontSize: 45),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'Slices\n${sliceState.slices.length}',
                          style: const TextStyle(fontSize: 45),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 500,
                    width: 500,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        for (Pizza pizza in pizzaState.pizzas)
                          Positioned(
                            left: random.nextInt(400).toDouble(),
                            top: random.nextInt(400).toDouble(),
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: pizza.image,
                            ),
                          ),
                        for (Slice slice in sliceState.slices)
                          Positioned(
                            left: random.nextInt(400).toDouble(),
                            top: random.nextInt(400).toDouble(),
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: slice.image,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Something went wrong!');
            }
          });
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //  >>>>>>>>>>>>>>>>>>>>>>> Pizzas <<<<<<<<<<<<<<<<<<<<<<<<
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.local_pizza),
                  backgroundColor: Colors.amber.shade300,
                  onPressed: () {
                    context.read<PizzaBloc>().add(AddPizza(Pizza.pizzaTypes[0])); // mushroom
                  },
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  child: const Text("—"),
                  backgroundColor: Colors.amber.shade300,
                  onPressed: () {
                    context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzaTypes[0])); // mushroom
                  },
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  child: const Icon(Icons.local_pizza),
                  backgroundColor: Colors.red.shade500,
                  onPressed: () {
                    context.read<PizzaBloc>().add(AddPizza(Pizza.pizzaTypes[1])); // pepperoni
                  },
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  child: const Text("—"),
                  backgroundColor: Colors.red.shade500,
                  onPressed: () {
                    context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzaTypes[1])); // pepperoni
                  },
                ),
              ],
            ),
            //  >>>>>>>>>>>>>>>>>>>>>>> Slices <<<<<<<<<<<<<<<<<<<<<<<<
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.local_pizza_outlined),
                  backgroundColor: Colors.amber.shade300,
                  onPressed: () {
                    context.read<SliceBloc>().add(AddSlice(Slice.sliceTypes[0])); // mushroom
                  },
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  child: const Text("—"),
                  backgroundColor: Colors.amber.shade300,
                  onPressed: () {
                    context.read<SliceBloc>().add(RemoveSlice(Slice.sliceTypes[0])); // mushroom
                  },
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  child: const Icon(Icons.local_pizza_outlined),
                  backgroundColor: Colors.red.shade500,
                  onPressed: () {
                    context.read<SliceBloc>().add(AddSlice(Slice.sliceTypes[1])); // pepperoni
                  },
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  child: const Text("—"),
                  backgroundColor: Colors.red.shade500,
                  onPressed: () {
                    context.read<SliceBloc>().add(RemoveSlice(Slice.sliceTypes[1])); // pepperoni
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
