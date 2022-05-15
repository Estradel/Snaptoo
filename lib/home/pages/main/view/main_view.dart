import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaptoo/helper/utils.dart';
import 'package:snaptoo/validation/view/validation_view.dart';

late SharedPreferences prefs;

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
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
    prefs = context.read<SharedPreferences>();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              'Snaptoo',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            const MyDropBoxWidget(),
            const SizedBox(height: 80),
            _floatingActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _floatingActionButton() {
    return Container(
      height: 225.0,
      width: 225.0,
      child: FloatingActionButton(
        child: const Icon(
          Icons.photo_camera_rounded,
          size: 125,
        ),
        onPressed: _takePicture,
      ),
    );
  }

  void _takePicture() async {
    _getImage(ImageSource.camera);
  }

  void _getImage(ImageSource source) async {
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ValidationView(
            category: prefs.getString('Current_Category') ?? Utils.DEFAULT_CATEGORY,
            pickedFile: pickedFile,
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
  String dropdownValue = prefs.getString('Current_Category') ?? Utils.DEFAULT_CATEGORY;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple, fontSize: 20),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          prefs.setString('Current_Category', dropdownValue);
        });
      },
      items: Utils.getMenuItems(),
    );
  }
}
