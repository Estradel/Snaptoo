import 'package:flutter/cupertino.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State createState() => _CollectionViewState();
}

class _CollectionViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return const Text("This is profile");
  }
}
