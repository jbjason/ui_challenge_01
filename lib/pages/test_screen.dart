import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/constants/my_dimens.dart';
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
  late AnimationController _animationController;
  late PageController _controller;
  final _pages = [
    Image.asset("assets/images/male_dashboard.jpeg"),
    Image.asset("assets/images/male_dashboard.jpeg"),
    //  Image.network("https://picsum.photos/200/300"),
    Image.asset("assets/images/male_dashboard.jpeg"),
    Image.asset("assets/images/male_dashboard.jpeg"),
    //  Image.network("https://picsum.photos/200/300"),
    Image.asset("assets/images/male_dashboard.jpeg"),
  ];
  final int _currentPage = 0;
  double _value = 1;
  double _rotateVal = 0, _rotateVal2 = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.8, initialPage: 1);
    _controller.addListener(_listener);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
  }

  void _listener() => setState(() => _value = _controller.page!);

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
              Center(
                child: Container(
                  height: 250,
                  width: 250,
                  color: Colors.amber,
                  child: Transform(
                    transform: Matrix4.identity()
                   //   ..rotateX(math.radians(_rotateVal2))
                      ..rotateZ(math.radians(_rotateVal))
                      ..rotateY(math.radians(_rotateVal)),
                    child: HomeMovingActor(cameraOrbit: ""),
                  ),
                ),
              ),
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
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _rotateVal += 5;
                      _rotateVal += 5;
                      setState(() {});
                      MyDimens.logError("rotateVal: $_rotateVal");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (_) => Home()),
                      // );
                    },
                    child: Text("data plus"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _rotateVal -= 5;
                      _rotateVal -= 5;
                      setState(() {});
                      MyDimens.logError("rotateVal: $_rotateVal");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (_) => Home()),
                      // );
                    },
                    child: Text("data minus"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }
}
