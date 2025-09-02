// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/widgets/dashboard_widgets/dashboard_bottom_list.dart';
import 'package:ui_challenge_01/widgets/dashboard_widgets/dashboard_circle_painter.dart';
import 'package:ui_challenge_01/widgets/dashboard_widgets/dashboard_top_text_count.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.controller,
    required this.percent,
  });
  final PageController controller;
  final double percent;
  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;
    return Opacity(
      opacity: 1 - percent.abs().clamp(0, 1),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Positioned.fill(
          //   right: -context.screenHeight * .1,
          //   child: HomeMovingActor(cameraOrbit: "90deg 90deg"),
          // ),
          Positioned(
            top: 30,
            left: 0,
            width: width * .5,
            // height: context.screenHeight * .3,
            child: Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..translate((width * .45) * percent, 0)
                ..rotateY(math.radians(90 * percent.clamp(-1, 1))),
              child: DashboardTopTextCount(),
            ),
          ),
          Positioned(
            height: context.screenHeight * .275,
            bottom: 5,
            width: context.screenWidth * .9,
            child: DashboardBottomList(),
          ),
          Positioned(
            bottom: context.screenHeight * .3,
            right: context.screenWidth*.1,
            width: 260,
            height: 240,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, .0001)
                ..rotateX(math.radians(240))
                ..rotateZ(math.radians(270 * percent.clamp(-1, 1))),
              child: CustomPaint(
                painter: DashboardCirclePainter(percent: percent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
