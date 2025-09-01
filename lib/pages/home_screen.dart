// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_bottom_list.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_circle_painter.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_moving_actor.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:ui_challenge_01/widgets/home_widgets/home_top_text.dart';

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
          Positioned.fill(
            top: context.screenHeight * .2,
            bottom: context.screenHeight,
            left: 0,
            right: 0,
            child: HomeMovingActor(cameraOrbit: "90deg 90deg"),
          ),
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
              child: HomeTopText(),
            ),
          ),
          Positioned(
            height: context.screenHeight * .2,
            width: context.screenWidth * .9,
            bottom: 5,
            child: HomeBottomList(),
          ),
          Positioned(
            bottom: context.screenHeight * .2,
            right: 0,
            width: 280,
            height: 250,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, .0001)
                ..rotateX(math.radians(240))
                ..rotateZ(math.radians(270 * percent.clamp(-1, 1))),
              child: CustomPaint(
                painter: HomeCirclePainter(percent: percent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
