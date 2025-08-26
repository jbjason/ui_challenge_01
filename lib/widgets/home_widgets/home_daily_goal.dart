import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'dart:math';

class HomeDailyGoal extends StatelessWidget {
  const HomeDailyGoal(
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
    final width = context.screenWidth;
    return AnimatedBuilder(
      animation: drawerAnimation,
      builder: (_, __) {
        final val = drawerAnimation.value;
        return Container(
          constraints: BoxConstraints.expand(),
          child: previousPage < currentPage
              ? Transform.translate(
                  offset: Offset(-width * (1 - val), 0),
                  child: Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .001)
                      ..rotateY(pi / 2 * (1 - val)),
                    child: Container(
                      width: width,
                      color: const Color.fromARGB(255, 35, 138, 185),
                      child: Text("---------------------------"),
                    ),
                  ),
                )
              : Transform.translate(
                  offset: Offset(-width * (1 - val), 0),
                  child: Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .001)
                      ..rotateY(pi / 2 * (1 - val)),
                    child: _getTansformChild,
                  ),
                ),
        );

        // Stack(
        //   children: [
        //     Positioned.fill(
        //       child:
        //     ),
        //     Positioned.fill(
        //       child: Transform.translate(
        //         offset: Offset(width * val, 0),
        //         child: Transform(
        //           alignment: Alignment.centerLeft,
        //           transform: Matrix4.identity()
        //             ..setEntry(3, 2, .001)
        //             ..rotateY(-pi / 2 * val),
        //           child: Container(color: Colors.amber),
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       bottom: 50,
        //       left: 150,
        //       child: ElevatedButton(
        //         onPressed: () => val < 1
        //             ? controller.forward(from: 0.0)
        //             : controller.reverse(),
        //         child: const Text('Start Animation'),
        //       ),
        //     ),
        //   ],
        // ),
        // );
      },
    );
  }

  Widget get _getTansformChild => Column(
        children: [
          Text(
            "Daily Goal",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "87",
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                  text: "%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          Container(color: const Color.fromARGB(255, 35, 138, 185))
        ],
      );
}
