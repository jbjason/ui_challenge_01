import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_daily_goal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(
      {super.key,
      required this.controller,
      required this.drawerAnimation,
      required this.currentPage,
      required this.previousPage});
  final AnimationController controller;
  final Animation<double> drawerAnimation;
  final int currentPage;
  final int previousPage;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppBar(title: Text("Home Screen")),
          const SizedBox(height: 20),
          SizedBox(
            height: context.screenHeight * .3,
            width: context.screenWidth,
            child: HomeDailyGoal(
              controller: controller,
              drawerAnimation: drawerAnimation,
              currentPage: currentPage,
              previousPage: previousPage,
            ),
          ),
        ],
      ),
    );
  }
}
