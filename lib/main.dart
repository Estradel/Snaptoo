import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:snaptoo/home/view/home_view.dart';

import 'collections/ObjectBox.dart';

late ObjectBox objectBox;
late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  objectBox = await ObjectBox.create();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeView.route: (context) => const HomeView(),
      },
      initialRoute: HomeView.route,
    );
  }
}