import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/my_constant.dart';

class ProfileTopText extends StatelessWidget {
  const ProfileTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        // highlight text & back button
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.arrow_back_ios_new, size: 15),
            Text(
              "Ron",
              style: TextStyle(
                fontSize: 90,
                fontFamily: MyConstant.font3,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
        // age text
        Text("29 years old"),
      ],
    );
  }
}
