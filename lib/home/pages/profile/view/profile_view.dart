import 'package:flutter/cupertino.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                'Profile',
                style: TextStyle(fontSize: 48),
              ),
              SizedBox(height: 20),
              Image.network(
                  "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg",
                  height: 200,
                  width: 200),
              SizedBox(height: 20),
              Text("Pseudo : ...."),
              SizedBox(height: 20),
              Text("Score : ...."),
              SizedBox(height: 20),
              Text("Badges")
            ],
          ),
        )
      ],
    );
  }
}
