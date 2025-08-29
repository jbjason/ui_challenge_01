import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/pages/home.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_daily_goal.dart';
import 'dart:math';
import 'package:vector_math/vector_math_64.dart' as math;

class TestScreen2 extends StatefulWidget {
  const TestScreen2({super.key});
  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2>
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
  final _colors = [
    Colors.red,
    Colors.amber,
    Colors.black,
    Colors.indigo,
    Colors.deepPurple
  ];
  int _currentPage = 0;
  double _value = 1;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => Home()),
                  // );
                  _controller.animateToPage(_currentPage + 1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                child: Text("data"),
              ),
            ),
            Container(
              color: Colors.grey,
              width: context.screenWidth,
              height: context.screenHeight * .7,
              child: PageView.builder(
                controller: _controller,
               // clipBehavior: Clip.none,
                physics: const PageScrollPhysics(),
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final percent = _value - index;
                  logInfo(
                      "percent : ${percent.toStringAsPrecision(3)}  ${_controller.position.userScrollDirection}");
                  return Opacity(
                    opacity: 1 - percent.clamp(0, 1),
                    child: Stack(
                    //  clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          width: context.screenWidth * .4,
                          height: context.screenHeight * .3,
                          child: Transform.translate(
                            offset: Offset((context.screenWidth*.4) * percent, 0),
                          child: Transform(
                            alignment: Alignment.centerRight,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(math.radians(90 * percent)),
                            // transform: Matrix4.identity()..rotateZ( percent),
                            child: _pages[index],
                          ),

                            ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0.5,
                          height: 100,
                          bottom: 5,
                          child: Opacity(
                            opacity: 1 - percent.abs().clamp(0, 1),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              color: _colors[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
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
