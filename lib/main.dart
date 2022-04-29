import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:snaptoo/home/view/home_view.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

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