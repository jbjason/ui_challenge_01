import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/my_constant.dart';

class ProfileBottomList extends StatelessWidget {
  const ProfileBottomList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          3,
          (i) => Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MyConstant.dailyGoals[i].color,
            ),
            child: Row(
              children: [
                // image
                Image.asset(MyConstant.dailyGoals[i].image,
                    color: Colors.white),
                const SizedBox(width: 20),
                // title
                Expanded(
                  child: Text(
                    MyConstant.dailyGoals[i].title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                // count v
                Text(
                  MyConstant.dailyGoals[i].value,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
