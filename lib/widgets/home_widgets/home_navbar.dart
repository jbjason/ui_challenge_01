// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:vector_math/vector_math.dart' as math;
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/constants/my_image.dart';

class HomeNavbar extends StatefulWidget {
  const HomeNavbar({super.key, required this.onPageChange});
  final Function onPageChange;
  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _navItemAninmation;
  late Animation _colorAnimationp;
  int _currentPage = 0;
  double _navItemWidth = 0.0,
      _destinationStartPoint = 0.0,
      _currentStartPoint = 0.0,
      _currentEndPoint = 0.0;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() {
    // initializing animation
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _navItemAninmation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _colorAnimationp =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(_controller);
    // declaring initial Start & End point
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navItemWidth = context.screenWidth / 3;
      _currentStartPoint = 0.0;
      _currentEndPoint = _navItemWidth;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return SizedBox(
            height: kBottomNavigationBarHeight,
            child: Column(
              children: [
                // nav bar items
                Row(
                  children: [
                    _getNavBarItem(index: 0, img: MyImage.homeIcon),
                    _getNavBarItem(index: 1, img: MyImage.homeIcon),
                    _getNavBarItem(index: 2, img: MyImage.homeIcon),
                  ],
                ),
                // animated bar
                SizedBox(
                  width: context.screenWidth,
                  child: CustomPaint(
                    painter: HomeNavbarPainter(
                      controllerValue: _navItemAninmation.value,
                      currentStartPoint: _currentStartPoint,
                      currentEndPoint: _currentEndPoint,
                      destinationPoint: _destinationStartPoint,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _getNavBarItem({required int index, required String img}) {
    final color = index == _currentPage ? _colorAnimationp.value : null;
    return GestureDetector(
      onTap: () async {
        if (index == _currentPage) return;

        //  widget.onPageChange(_currentPage);
        // updating destination point
        _getDestinationStartPoint(index);
        _currentPage = index;
        setState(() {});
        Future.delayed(Duration()).then((_) {
          // animation part

          _controller.stop();
          _controller.forward(from: 0.0).whenComplete(() {
            _currentStartPoint += _destinationStartPoint;
            _currentEndPoint += _destinationStartPoint;
            print("-=----------------");
            print(
                "After animation, start: $_currentStartPoint, end: $_currentEndPoint");
            print("-=----------------");
            _controller.stop();
          });
        });
      },
      child: SizedBox(
        width: _navItemWidth,
        child: Center(
          child: Image.asset(img, color: color, height: 30),
        ),
      ),
    );
  }

  void _getDestinationStartPoint(int newIndex) {
    if (_currentPage < newIndex) {
      _destinationStartPoint = (newIndex - _currentPage) * _navItemWidth;
    } else {
      _destinationStartPoint = -((_currentPage - newIndex) * _navItemWidth);
    }
    print(
        "Destination: $_destinationStartPoint : from $_currentStartPoint to $_currentEndPoint");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HomeNavbarPainter extends CustomPainter {
  final double controllerValue;
  final double currentStartPoint;
  final double currentEndPoint;
  final double destinationPoint;
  final double strokeWidth;
  const HomeNavbarPainter({
    required this.controllerValue,
    required this.currentStartPoint,
    required this.destinationPoint,
    required this.currentEndPoint,
    this.strokeWidth = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    print(
        "destination: ${destinationPoint.toStringAsFixed(2)}, from ${(currentStartPoint + (destinationPoint * controllerValue)).toStringAsFixed(2)} to ${(currentEndPoint + (destinationPoint * controllerValue)).toStringAsFixed(2)}");
    final h = size.height;
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(currentStartPoint + (destinationPoint * controllerValue), h / 2),
      Offset(currentEndPoint + (destinationPoint * controllerValue), h / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
