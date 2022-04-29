import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(imagePath),
              const SizedBox(height: 40),
              const Text("Catégorie : ...."),
              const SizedBox(height: 20),
              const Text("Objet : ...."),
              const SizedBox(height: 20),
              const Text("Note : ....")
            ],
          ),
        ));
  }
}
