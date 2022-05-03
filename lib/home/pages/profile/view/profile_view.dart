import 'package:flutter/cupertino.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ProfileView();
  }
}

class _ProfileView extends StatelessWidget {
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
