import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'dart:math';
import 'dart:developer' as developer;

void logInfo(String msg) {
  developer.log('\x1B[34m$msg\x1B[0m'); // Blue
}

void logError(String msg) {
  developer.log('\x1B[31m$msg\x1B[0m'); // Red
}

class HomeDailyGoal extends StatelessWidget {
  const HomeDailyGoal(
      {super.key, required this.controller, required this.currentPage});
  final PageController controller;
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        double val = 0.0;
        double pageVal = controller.page ?? 0;
        val = (currentPage - pageVal).clamp(0, 1);
        logInfo("val :  $val");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width ,
              child: Transform.translate(
                offset: Offset(-width * val, 0),
                child: Transform(
                  alignment: Alignment.centerRight,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, .001)
                    ..rotateY(-pi / 2 * val),
                  child: _getTansformChild,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Opacity(
              opacity: 1 - val,
              child: SizedBox(
                height: context.screenHeight * .3,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      3,
                      (i) => Container(
                        margin: EdgeInsets.symmetric(vertical: 7),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              offset: Offset(5, 5),
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 120,
                              child: Image.network(
                                  "https://picsum.photos/200/300"),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                      "A Simple way to start your day with a good breakfast"),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Dr Testoren",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(Icons.lightbulb_outline, color: Colors.red),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
