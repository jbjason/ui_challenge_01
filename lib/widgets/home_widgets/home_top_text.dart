import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/my_contant.dart';
import 'package:ui_challenge_01/constants/my_image.dart';

class HomeTopText extends StatelessWidget {
  const HomeTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Daily Goal",
          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: MyConstant.font3),
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
        const SizedBox(height: 20),
        _getDailyGoalItem,
      ],
    );
  }

  Widget get _getDailyGoalItem {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        _getItem(img: MyImage.caloriesIcon, title: "calories", count: "1840"),
        _getItem(img: MyImage.stepsIcon, title: "steps", count: "3248"),
        _getItem(img: MyImage.hoursIcon, title: "hours", count: "6.5"),
      ],
    );
  }

  Row _getItem(
      {required String img, required String title, required String count}) {
    return Row(
      children: [
        Image.asset(img),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 22,
                fontFamily: MyConstant.font3,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
