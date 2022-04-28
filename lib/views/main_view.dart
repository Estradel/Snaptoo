
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_projet/views/collection_view.dart';
import 'package:test_projet/views/note_view.dart';

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
        title: Text('Accueil'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: Icon(Icons.home), onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainView())); }),
          SizedBox(width: 30),
          IconButton(icon: Icon(Icons.collections), onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => CollectionView())); }),
          SizedBox(width: 30),
          Icon(Icons.account_box)
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            Text('SnappToo',
            style: TextStyle(
              fontSize: 48),),
            SizedBox(height: 100),
            MyDropBoxWidget(),
            SizedBox(height: 100),
            _floatingActionButton(),
          ],
        )
      )
      );
  }

  Widget _floatingActionButton() {

    return Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          child: Icon(
            Icons.photo_camera_rounded,
            size: 40,
          ),
          onPressed: _takePicture,
        ));
  }


  void _getImage(ImageSource source) async{
    final pickedFile = await _imagePicker?.pickImage(source: source);
    //final pickedFile = await _controller?.takePicture();
    if (pickedFile != null) {
      final path = pickedFile.path;
      final bytes = await File(path).readAsBytes();
      _image = MemoryImage(bytes);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteView(categorie: categorie, imageProv: _image,imageBytes: File(pickedFile.path))));
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  void _takePicture() async{

    _getImage(ImageSource.camera);
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
      items: <String>['Animaux', 'Fleurs', 'Nourriture']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

