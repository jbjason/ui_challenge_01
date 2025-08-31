// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_bottom_list.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_circle_painter.dart';
import 'dart:developer' as developer;
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:ui_challenge_01/widgets/home_widgets/home_top_text.dart';

void logInfo(String msg) {
  developer.log('\x1B[34m$msg\x1B[0m'); // Blue
}

void logError(String msg) {
  developer.log('\x1B[31m$msg\x1B[0m'); // Red
}

class HomeDailyGoal extends StatelessWidget {
  const HomeDailyGoal(
      {super.key, required this.controller, required this.percent});
  final PageController controller;
  final double percent;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
