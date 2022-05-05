import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'collections/ObjectBox.dart';
import 'home/view/home_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.objectBox}) : super(key: key);

  final ObjectBox objectBox;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.objectBox,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          HomeView.route: (context) => const HomeView(),
        },
        initialRoute: HomeView.route,
      ),
    );
  }
}