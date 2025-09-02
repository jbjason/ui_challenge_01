import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/my_constant.dart';

class DashboardTopText extends StatelessWidget {
  const DashboardTopText({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Daily Goal",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontFamily: MyConstant.font3),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "87",
                style: TextStyle(
                  fontSize: 90,
                  fontFamily: MyConstant.font3,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              TextSpan(
                text: "%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
