import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectbox/internal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaptoo/views/image_view.dart';

import '../../../../collections/ObjectBox.dart';
import '../../../../objectbox.g.dart';
import '../../collection/bloc/collection_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>{

  String? pseudo = "d";
  String? imageprofile = "assets/img/profile/default.png";
  double score = 0.0;
  bool? modify = false;
  IconData? iconbutton = Icons.edit;

  List Badge = [
  "assets/img/profile/Badge_Pierre.png",
    "assets/img/profile/Badge_Eau.png",
    "assets/img/profile/Badge_Elec.png",
    "assets/img/profile/Badge_Plante.png",
    "assets/img/profile/Badge_Poison.png",
    "assets/img/profile/Badge_Psy.png",
    "assets/img/profile/Badge_Feu.png",
    "assets/img/profile/Badge_Sol.png"
  ];

  var pseudocontroller = TextEditingController();

  File? _image;
  ImagePicker? _imagePicker;
  var pickedFile;

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();

    ReadSharedPrefs();

    LoadScore();

    int nbBadge = CalculateBadge();

    for(int i = 7; i > nbBadge; i--)
    {
      Badge.removeAt(i);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 100),
                Text(
                  'Profile',
                  style: TextStyle(fontSize: 48),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () async{
                    if(modify == true){
                        pickedFile = await _imagePicker?.pickImage(source: ImageSource.gallery,);
                        _image = File(pickedFile!.path);
                        final random = Random().nextInt(1000);
                        Directory appDocDir = await getApplicationDocumentsDirectory();
                        String appDocPath = appDocDir.path;
                        final File newImage = await _image!.copy('$appDocPath/$random.png');
                        _image = newImage;
                        await WriteSharedPrefs();
                        setState(() {});
                      }
                  },
                  child: ClipRRect(
                    child: Image.file(
                      File(imageprofile!),
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 250,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Pseudo",
                    ),
                    keyboardType: TextInputType.text,
                    enabled: modify,
                    controller: pseudocontroller,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 250,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Score",
                    ),
                    keyboardType: TextInputType.text,
                    enabled: false,
                    initialValue: score.toString(),
                  ),
                ),
                SizedBox(height: 20),
                Text("Badges :"),
                SizedBox(height: 10),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: Badge.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Image.asset(Badge[index], height: 40, width: 40);
                        },
                        physics: const ClampingScrollPhysics(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
          child: Icon(iconbutton),
          onPressed: () {
              modify = !modify!;
              if(modify == true) {
                iconbutton = Icons.done;
              }
              else {
                iconbutton = Icons.edit;
                WriteSharedPrefs();
              }
              setState(() {});
          },
        ));
  }

  ReadSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    pseudo = prefs.getString('Pseudo') ?? "Sans pseudo";
    imageprofile = prefs.getString('ImageProfile') ?? "assets/img/profile/default.png";

    if(imageprofile == "assets/img/profile/default.png"){
      final byteData = await rootBundle.load('assets/img/profile/default.png');

      final file = File('${(await getTemporaryDirectory()).path}/default.png');
      await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      imageprofile = file.path.toString();
    }

    pseudocontroller.text = pseudo!;

    setState(() {});

  }

  WriteSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('Pseudo', pseudocontroller.text);
    prefs.setString('ImageProfile', _image!.path.toString());

    imageprofile = _image!.path;

  }

  void LoadScore()
  {
    ObjectBox _objectBox = context.read<ObjectBox>();
    var list = _objectBox.getCollectionItems().where((item) => (item.category == "Objects")).toList();

    for(int i = 0;i < list.length; i++)
    {
      score += list.elementAt(i).score * 100;
    }

    list = _objectBox.getCollectionItems().where((item) => (item.category == "Food")).toList();

    for(int i = 0;i < list.length; i++)
    {
      score += list.elementAt(i).score * 100;
    }

    score = double.parse(score.toStringAsFixed(2));


    //_objectBox.Close();
  }

  int CalculateBadge()
  {
    int cpt = -1;

    if(score > 100)
      cpt++;
    if(score > 200)
      cpt++;
    if(score > 500)
      cpt++;
    if(score > 1000)
      cpt++;
    if(score > 5000)
      cpt++;
    if(score > 10000)
      cpt++;
    if(score > 50000)
      cpt++;
    if(score > 100000)
      cpt++;

    return cpt;
  }

}



