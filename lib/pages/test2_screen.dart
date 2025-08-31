import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_bottom_list.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_daily_goal.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class Test2Screen extends StatefulWidget {
  const Test2Screen({super.key});
  @override
  State<Test2Screen> createState() => _Test2ScreenState();
}

class _Test2ScreenState extends State<Test2Screen>
     {
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
    _controller = PageController(viewportFraction: .9, initialPage: 1);
    _controller.addListener(_listener);
  }

  void _listener() => setState(() => _value = _controller.page!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(
              width: context.screenWidth,
              height: context.screenHeight * .7,
              child:  PageView.builder(
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
                    opacity: 1 - percent.abs().clamp(0, 1),
                    child: Stack(
                      //  clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          width: context.screenWidth * .5,
                          height: context.screenHeight * .3,
                          child: Transform(
                              alignment: Alignment.centerRight,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..translate(
                                    (context.screenWidth * .5) * percent, 0)
                                ..rotateY(
                                    math.radians(90 * percent.clamp(-1, 1))),
                              child:
                                  //_pages[index]
                                  _getTansformChild),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          height: context.screenHeight * .3,
                          bottom: 5,
                          child: HomeBottomList(),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          width: 280,
                          height: 250,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, .0001)
                              ..rotateX(math.radians(240))
                              ..rotateZ(
                                  math.radians(270 * percent.clamp(-1, 1))),
                            child: CustomPaint(
                              painter:
                                  HomeTrippleCircularPainter(percent: percent),
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

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }
}

class HomeTrippleCircularPainter extends CustomPainter {
  final double percent;
  const HomeTrippleCircularPainter({super.repaint, required this.percent});
  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height, w = size.width;
    final center = Offset(w / 2, h / 2);
    final rect = Rect.fromCenter(center: center, width: w, height: h);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15 * (1 - percent)
      ..shader = _getColorShade(Colors.lightBlue).createShader(rect);
    final paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15 * (1 - percent)
      ..shader = _getColorShade(Colors.deepPurple).createShader(rect);
    final paint3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15 * (1 - percent)
      ..shader = _getColorShade(Colors.deepOrange).createShader(rect);
    canvas.drawOval(
        Rect.fromCenter(center: center, width: w + 40, height: h + 40), paint);
    canvas.drawOval(
        Rect.fromCenter(center: center, width: w, height: h), paint2);
    canvas.drawOval(
        Rect.fromCenter(center: center, width: w - 40, height: h - 40), paint3);
  }

  SweepGradient _getColorShade(Color color) {
    return SweepGradient(
      tileMode: TileMode.repeated,
      startAngle: math.radians(0),
      endAngle: math.radians(360),
      colors: [
        color.withOpacity(.7),
        Colors.transparent,
        Colors.transparent,
        color.withOpacity(.7),
        color,
        color,
        color.withOpacity(.7),
      ],
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
