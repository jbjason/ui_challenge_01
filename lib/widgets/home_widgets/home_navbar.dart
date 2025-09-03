// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_navbar_painter.dart';
// ignore: unused_import
import 'package:vector_math/vector_math.dart' as math;
import 'package:ui_challenge_01/constants/media_query_extension.dart';

class HomeNavbar extends StatefulWidget {
  const HomeNavbar({super.key, required this.onPageChange});
  final Function(int i) onPageChange;
  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _navItemAninmation;
  late Animation _navItemcolorAnimation;
  int _currentIndex = 0;
  double _navItemWidth = 0.0, _destinationStartPoint = 0.0;
  double _currentStartPoint = 0.0, _currentEndPoint = 0.0;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
        lowerBound: 0.0,
        upperBound: 1.0);
    _navItemAninmation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _navItemcolorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(_controller);
    // declaring initial Start & End point
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navItemWidth = context.screenWidth / 3;
      _currentStartPoint = _navItemWidth * .3;
      _currentEndPoint = _navItemWidth * .7;
      setState(() {});
    });
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      height: kBottomNavigationBarHeight * 1.1,
      child: Column(
        children: [
          // nav bar items
          Row(
            children: [
              _getNavBarItem(index: 0, icon: Icons.tab_outlined),
              _getNavBarItem(index: 1, icon: Icons.rate_review_outlined),
              _getNavBarItem(index: 2, icon: Icons.blinds_closed_outlined),
            ],
          ),
          const SizedBox(height: 10),
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
  }

  Widget _getNavBarItem({
    required int index,
    required IconData icon,
  }) =>
      SizedBox(
        width: _navItemWidth,
        child: GestureDetector(
          onTap: () => _onNavItemTap(index),
          child: Center(
            child: Icon(
              icon,
              color: index == _currentIndex
                  ? _navItemcolorAnimation.value
                  : Colors.black,
            ),
          ),
        ),
      );

  void _onNavItemTap(int index) async {
    if (index == _currentIndex) return;
    // updating destination point
    //_getDestinationStartPoint(index);
    if (_currentIndex < index) {
      _destinationStartPoint = (index - _currentIndex) * _navItemWidth;
    } else {
      _destinationStartPoint = -((_currentIndex - index) * _navItemWidth);
    }
    _currentIndex = index;
    setState(() {});
    // starting the animation & it will call this funtion after animation in completed
    _controller.stop();
    await _controller.forward(from: 0.0);
    //.whenComplete(() {

    _currentStartPoint += _destinationStartPoint;
    _currentEndPoint += _destinationStartPoint;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
