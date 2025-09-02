// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_moving_actor.dart';
import 'package:ui_challenge_01/widgets/profile_widgets/profile_bottom_list.dart';
import 'package:ui_challenge_01/widgets/profile_widgets/profile_top_text.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
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
          Column(
            children: [
              Container(
                height: context.screenHeight * .5,
                width: context.screenWidth,
                color: const Color.fromARGB(255, 233, 230, 229),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    ),
                    // Positioned.fill(
                    //   child: HomeMovingActor(cameraOrbit: "60deg 90deg 90deg"),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text("Daily Goals"),
              const SizedBox(height: 20),
              Expanded(child: ProfileBottomList()),
            ],
          ),
          Positioned(
            top: 30,
            left: 0,
            width: width * .5,
            child: Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..translate((width * .45) * percent, 0)
                ..rotateY(math.radians(90 * percent.clamp(-1, 1))),
              child: ProfileTopText(),
            ),
          ),
        ],
      ),
    );
  }
}
