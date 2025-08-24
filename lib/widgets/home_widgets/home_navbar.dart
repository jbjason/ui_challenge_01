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
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));

    _navItemAninmation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _colorAnimationp =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    _navItemWidth = context.screenWidth / 3;
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          _currentStartPoint = _navItemWidth * _currentPage;
          _currentEndPoint = _currentStartPoint + _navItemWidth;
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
                      currentEndPoint: _currentStartPoint,
                      currentStartPoint: _currentEndPoint,
                      destinationPoint: _destinationStartPoint,
                      width: context.screenWidth,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _getNavBarItem({required int index, required String img}) {
    final isSelected = index == _currentPage;
    final color = isSelected ? _colorAnimationp.value : null;
    return GestureDetector(
      onTap: () async {
        if (index == _currentPage) return;
        _currentPage = index;
        // updating destination point
        _getDestinationStartPoint(index);
        setState(() {});
        // animation part
        _controller.stop();
        _controller.forward(from: 0.0);
        // calling to update current page
        widget.onPageChange(index);
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
    setState(() {});
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
  final double width;
  const HomeNavbarPainter({
    required this.controllerValue,
    required this.currentStartPoint,
    required this.destinationPoint,
    required this.currentEndPoint,
    this.strokeWidth = 5.0,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    print(
        "destinationVaL: $destinationPoint   :::::::  animationVal : $controllerValue");
    print(
        "start: ${currentStartPoint + (destinationPoint * controllerValue)} :::: ${currentEndPoint + (currentEndPoint * controllerValue)} ");
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
