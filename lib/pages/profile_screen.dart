import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_daily_goal.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.controller,
    required this.currentPage,
  });
  final PageController controller;
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          children: [
            AppBar(title: Text("Home Screen")),
            const SizedBox(height: 20),
            SizedBox(
              width: context.screenWidth,
              child: HomeDailyGoal(
                controller: controller,
                currentPage: currentPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
