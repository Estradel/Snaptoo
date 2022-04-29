import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_projet/views/collection_view.dart';
import 'package:test_projet/views/note_view.dart';
import 'package:tuple/tuple.dart';

import '../Helper/ImageLabeler.dart';

String categorie = "";

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late ImageProvider _image;
  ImagePicker? _imagePicker;

  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Accueil'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainView()));
                }),
            const SizedBox(width: 30),
            IconButton(
                icon: const Icon(Icons.collections),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => CollectionView()));
                }),
            const SizedBox(width: 30),
            const Icon(Icons.account_box),
            const SizedBox(width: 30),
          ],
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              'Snaptoo',
              style: TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 100),
            const MyDropBoxWidget(),
            const SizedBox(height: 100),
            _floatingActionButton(),
          ],
        )));
  }

  Widget _floatingActionButton() {
    return Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          child: const Icon(
            Icons.photo_camera_rounded,
            size: 40,
          ),
          onPressed: _takePicture,
        ));
  }

  void _takePicture() async {
    _getImage(ImageSource.camera);
  }

  void _getImage(ImageSource source) async {
    final pickedFile = await _imagePicker?.pickImage(source: source);
    //final pickedFile = await _controller?.takePicture();
    if (pickedFile != null) {
      final path = pickedFile.path;
      final bytes = await File(path).readAsBytes();
      _image = MemoryImage(bytes);

      List<Tuple3<String, int, double>> listLabel =
          await ImageLabeler.getImageLabels(File(pickedFile.path));

      // JUSTE UN PETIT PRINT POUR TESTER
      print('\n\nLES LABELS DETECTES POUR L\'IMAGE CHOISIE : $listLabel\n\n\n');

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NoteView(
                categorie: categorie,
                imageProv: _image,
                imageBytes: File(pickedFile.path),
                listLabel: listLabel,
              )));
    } else {
      print('No image selected.');
    }
    setState(() {});
  }
}

class MyDropBoxWidget extends StatefulWidget {
  const MyDropBoxWidget({Key? key}) : super(key: key);

  @override
  State<MyDropBoxWidget> createState() => _MyDropBoxWidgetState();
}

class _MyDropBoxWidgetState extends State<MyDropBoxWidget> {
  String dropdownValue = 'Animaux';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          categorie = dropdownValue;
        });
      },
      items:
          <String>['Animaux', 'Fleurs', 'Nourriture'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
