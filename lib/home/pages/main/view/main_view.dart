import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snaptoo/helper/Utilities.dart';
import 'package:snaptoo/views/validation_view.dart';
import 'package:tuple/tuple.dart';

import '../../../../helper/ImageLabeler.dart';

String category = "Objects";

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

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
        ),
      ),
    );
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

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ValidationView(
            category: category,
            imageProv: _image,
            imageBytes: File(pickedFile.path),
            listLabel: listLabel,
          ),
        ),
      );
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
  String dropdownValue = 'Objects';

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
          category = dropdownValue;
        });
      },
      items: Utilities.getMenuItems(),
    );
  }
}
