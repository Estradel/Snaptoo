import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'collections/object_box.dart';
import 'home/view/home_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.objectBox, required this.prefs}) : super(key: key);

  final ObjectBox objectBox;
  final SharedPreferences prefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.objectBox),
        RepositoryProvider.value(value: widget.prefs),
      ],
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
