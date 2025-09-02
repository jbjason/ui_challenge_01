import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/my_image.dart';
import 'package:ui_challenge_01/models/daily_goal.dart';

abstract class MyConstant {
  static const String font1 = 'Casab';
  static const String font2 = 'Script';
  static const String font3 = 'Vinque';

  static const List<DailyGoal> dailyGoals = [
    DailyGoal(
      title: "Calories",
      value: "2000",
      image: MyImage.caloriesIcon,
      color: Colors.deepOrange,
    ),
    DailyGoal(
      title: "Steps",
      value: "3248",
      image: MyImage.stepsIcon,
      color: Colors.deepPurple,
    ),
    DailyGoal(
      title: "Hours",
      value: "8h",
      image: MyImage.hoursIcon,
      color: Colors.blue,
    ),
  ];
  static const List<List<double>> cameraOrbitList = [
    [90, 90, 0],
    [0, 90, 0],
    [60, 90, 90],
  ];
}
