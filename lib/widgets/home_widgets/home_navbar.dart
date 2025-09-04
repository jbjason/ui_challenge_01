import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/my_constant.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_navbar_painter.dart';
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
  double _navItemWidth = 0.0;
  double _currentStartPoint = 0.0, _currentEndPoint = 0.0;
  double _destinationStartPoint = 0.0;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() {
    _controller = AnimationController(
      vsync: this,
      duration: MyConstant.duration,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _navItemAninmation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _navItemcolorAnimation =
        ColorTween(begin: Colors.black, end: Colors.red).animate(_controller);
    // setting initial start & end point
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navItemWidth = context.screenWidth / 3;
      _currentStartPoint = _navItemWidth * .3;
      _currentEndPoint = _navItemWidth * .7;
      _controller.value=1;
      setState(() {});
    });

    _controller.addListener(() => setState(() {}));
  }

  void _onNavItemTap(int index) async {
    if (index == _currentIndex) return;
    // Calculating next destination value
    final double movement;
    if (_currentIndex < index) {
      movement = (index - _currentIndex) * _navItemWidth;
    } else {
      movement = -((_currentIndex - index) * _navItemWidth);
    }
    _destinationStartPoint = movement;
    _currentIndex = index;
    widget.onPageChange(index);
    _controller.stop();
    await _controller.forward(from: 0.0);
    // Update current positions after animation completes
    setState(() {
      _currentStartPoint += movement;
      _currentEndPoint += movement;
      _destinationStartPoint = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      height: kBottomNavigationBarHeight * 1.1,
      child: Column(
        children: [
          // nav items
          Row(
            children: [
              _getNavBarItem(index: 0, icon: Icons.tab_outlined),
              _getNavBarItem(index: 1, icon: Icons.rate_review_outlined),
              _getNavBarItem(index: 2, icon: Icons.blinds_closed_outlined),
            ],
          ),
          const SizedBox(height: 10),
          // bottom red bar
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

  Widget _getNavBarItem({required int index, required IconData icon}) =>
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
