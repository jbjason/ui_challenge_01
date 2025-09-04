import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/my_constant.dart';

class ScheduleTopText extends StatelessWidget {
  const ScheduleTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "JOURNAL",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: MyConstant.font3),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.arrow_back_ios_new, size: 15),
            Text(
              "13",
              style: TextStyle(
                fontSize: 90,
                fontFamily: MyConstant.font3,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
        Text(
          "July 2020",
          style: TextStyle(
            fontFamily: MyConstant.font3,
          ),
        ),
      ],
    );
  }
}
