import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/my_constant.dart';
import 'package:ui_challenge_01/widgets/dashboard_widgets/dashboard_top_text.dart';

class DashboardTopTextCount extends StatelessWidget {
  const DashboardTopTextCount({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // top text
       DashboardTopText(),
        const SizedBox(height: 20),
        // daily goal text list
        ...List.generate(
          MyConstant.dailyGoals.length,
          (i) => _getItem(
            img: MyConstant.dailyGoals[i].image,
            title: MyConstant.dailyGoals[i].title,
            value: MyConstant.dailyGoals[i].value,
          ),
        ),
      ],
    );
  }

  Padding _getItem(
      {required String img, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Image.asset(img),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
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
      ),
    );
  }
}
