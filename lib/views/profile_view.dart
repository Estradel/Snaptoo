import 'package:flutter/cupertino.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State createState() => _CollectionViewState();
}

class _CollectionViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "This is a profile ! :)",
              style: TextStyle(fontSize: 32),
            ),
          ],
        ),
      ],
    );
  }
}
