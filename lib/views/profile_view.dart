import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_view.dart';
import 'collection_view.dart';

class ProfileView extends StatefulWidget {
  @override
  State createState() => new _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

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
            IconButton(icon: Icon(Icons.account_box), onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileView())); })
          ],
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Text('Profile',
                style: TextStyle(
                    fontSize: 48),),
              SizedBox(height: 20),
              Image.network("https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg",height: 200, width: 200),
              SizedBox(height: 20),
              Text("Pseudo : ...."),
              SizedBox(height: 20),
              Text("Score : ...."),
              SizedBox(height: 20),
              Text("Badges")
              
            ],
          ),

        )
    );
  }

}