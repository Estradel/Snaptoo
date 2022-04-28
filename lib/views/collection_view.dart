import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_projet/views/image_view.dart';


import 'main_view.dart';


List Animaux = [
  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_960_720.jpg",
];

List Fleur = [
  "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/07/11/15/43/pretty-woman-1509956_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/02/13/12/26/aurora-1197753_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",

];

List Nourriture = [
  "https://cdn.pixabay.com/photo/2013/11/28/10/03/autumn-219972_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/17/19/08/away-3024773_960_720.jpg",
];

class CollectionView extends StatefulWidget {
  @override
  State createState() => new _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {

  String dropdownValue = "Animaux";
  List litems = Animaux;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Collection'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(icon: Icon(Icons.home), onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainView())); }),
            SizedBox(width: 30),
            IconButton(icon: Icon(Icons.collections), onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => CollectionView())); }),
            SizedBox(width: 30),
            Icon(Icons.account_box)
          ],
        ),
        body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text('Collection',
                    style: TextStyle(
                        fontSize: 48),),
                  SizedBox(height: 20),
                  MyDropBoxWidget(),
                  SizedBox(height: 30),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Padding(
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                          onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImageView(imagePath: index.toString(),))); },
                            child: ClipRRect(
                                child: Image.network(litems[index],height: 150,width: 150,),
                            ),
                          )
                      );
                    },
                    itemCount: litems.length,
                    physics: ClampingScrollPhysics(),
                  )
                ],
              ),
          
        )
    );
  }

  @override
  Widget MyDropBoxWidget() {
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
          if(dropdownValue == "Animaux")
            litems = Animaux;
          else if(dropdownValue == "Fleurs")
            litems = Fleur;
          else
            litems = Nourriture;
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


