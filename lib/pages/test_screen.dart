import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/constants/my_dimens.dart';
import 'package:ui_challenge_01/constants/my_image.dart';
import 'package:ui_challenge_01/pages/home.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_moving_actor.dart';

import 'package:vector_math/vector_math_64.dart' as math;

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  // late AnimationController _animationController;
  // late PageController _controller;
  // final _pages = [
  //   Image.asset("assets/images/male_dashboard.jpeg"),
  //   Image.asset("assets/images/male_dashboard.jpeg"),
  //   //  Image.network("https://picsum.photos/200/300"),
  //   Image.asset("assets/images/male_dashboard.jpeg"),
  //   Image.asset("assets/images/male_dashboard.jpeg"),
  //   //  Image.network("https://picsum.photos/200/300"),
  //   Image.asset("assets/images/male_dashboard.jpeg"),
  // ];
  // final int _currentPage = 0;
  // double _value = 1;
  double _rotateVal = 0, _rotateVal2 = 0;
  final Flutter3DController _controller = Flutter3DController();

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = PageController(viewportFraction: 0.8, initialPage: 1);
  //   _controller.addListener(_listener);
  //   _animationController = AnimationController(
  //       vsync: this, duration: const Duration(milliseconds: 600));
  // }

  // void _listener() => setState(() => _value = _controller.page!);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: context.screenHeight,
          width: context.screenWidth,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Center(
              //   child: Container(
              //     height: 250,
              //     width: 250,
              //     color: Colors.amber,
              //     child: Transform(
              //       transform: Matrix4.identity()
              //      //   ..rotateX(math.radians(_rotateVal2))
              //         ..rotateZ(math.radians(_rotateVal))
              //         ..rotateY(math.radians(_rotateVal)),
              //       child: HomeMovingActor(cameraOrbit: ""),
              //     ),
              //   ),
              // ),
              // Container(
              //   color: Colors.grey,
              //   width: context.screenWidth * .6,
              //   height: context.screenHeight * .4,
              //   child: Stack(
              //     children: [
              //       Positioned.fill(
              //         child: PageView.builder(
              //           controller: _controller,
              //           clipBehavior: Clip.none,
              //           physics: const PageScrollPhysics(),
              //           onPageChanged: (value) =>
              //               setState(() => _currentPage = value),
              //           itemCount: _pages.length,
              //           itemBuilder: (context, index) {
              //             final percent = _value - index;
              //             // if (_value < 0) {
              //             logError(
              //                 "Negative: ${percent.toStringAsPrecision(3)}. &  rotateVal: ${math.radians(85) * percent.clamp(-1, 1)}");
              //             // }
              //             // logInfo(
              //             //     "percent : ${percent.toStringAsPrecision(3)}");
              //             return Transform(
              //               alignment: Alignment.centerRight,
              //               transform: Matrix4.identity()
              //                 ..setEntry(3, 2, 0.001)
              //                 ..rotateY(math.radians(90) * percent.clamp(-1, 1)),
              //               //transform: Matrix4.identity()..rotateZ( percent),
              //               child: _pages[index],
              //             );
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // )
          //  HomeMovingActor(controller: _controller),
              /// Actor animation test
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Home()),
                      );
                      // _rotateVal += 5;
                      // _rotateVal2 += 5;
                      //_controller.setCameraOrbit(90, 90, 80);
                      // MyDimens.logError("rotateVal: $_rotateVal");
                    },
                    child: Text("data plus"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _rotateVal -= 5;
                      _rotateVal2 -= 5;
                      _controller.setCameraOrbit(0, 90, 0);
                      MyDimens.logError("rotateVal: $_rotateVal");
                    },
                    child: Text("data minus"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _rotateVal -= 5;
                      _rotateVal2 -= 5;
                      _controller.setCameraOrbit(60, 90, 90);
                      MyDimens.logError("rotateVal: $_rotateVal");
                    },
                    child: Text("data 000"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   _controller.removeListener(_listener);
  //   _controller.dispose();
  //   super.dispose();
  // }
}

class RedOverlayWithHole extends StatelessWidget {
  const RedOverlayWithHole({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background (white with image/logo/drawing)
          Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: FlutterLogo(size: 400), // <-- your background content
          ),

          // 2. Foreground with red + hole
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: RedOverlayPainter(),
          ),
        ],
      ),
    );
  }
}

/// 1st approach
class RedOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Save the current canvas layer so blend modes work
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    final paint = Paint()..color = Colors.red;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 3), 
      80, 
      Paint()..blendMode = BlendMode.clear, // clear pixell
    );

    // Restore canvas
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
/// 2nd approach
class HoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..fillType = PathFillType.evenOdd // important for making a hole
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 3),
        radius: 80, 
      ));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}