// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_navbar_painter.dart';
// ignore: unused_import
import 'package:vector_math/vector_math.dart' as math;
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/constants/my_image.dart';

class HomeNavbar extends StatefulWidget {
  const HomeNavbar(
      {super.key,
      required int currentPage,
      required this.onPageChange,
      required AnimationController controller,
      required navItemAninmation,
      required navItemcolorAnimation})
      : _currentPage = currentPage,
        _controller = controller,
        _navItemAninmation = navItemAninmation,
        _navItemcolorAnimation = navItemcolorAnimation;
  final int _currentPage;
  final Function(int i, Function f) onPageChange;
  final AnimationController _controller;
  final Animation<double> _navItemAninmation;
  final Animation _navItemcolorAnimation;
  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  double _navItemWidth = 0.0, _destinationStartPoint = 0.0;
  double _currentStartPoint = 0.0, _currentEndPoint = 0.0;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() {
    // declaring initial Start & End point
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navItemWidth = context.screenWidth / 3;
      _currentStartPoint = _navItemWidth * .3;
      _currentEndPoint = _navItemWidth * .7;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget._controller,
      builder: (context, _) {
        return SizedBox(
          height: kBottomNavigationBarHeight,
          child: Column(
            children: [
              // nav bar items
              Row(
                children: [
                  _getNavBarItem(index: 0, img: MyImage.homeIcon),
                  _getNavBarItem(index: 1, img: MyImage.scheduleIcon),
                  _getNavBarItem(index: 2, img: MyImage.profileIcon),
                ],
              ),
              const SizedBox(height: 10),
              // animated bar
              SizedBox(
                width: context.screenWidth,
                child: CustomPaint(
                  painter: HomeNavbarPainter(
                    controllerValue: widget._navItemAninmation.value,
                    currentStartPoint: _currentStartPoint,
                    currentEndPoint: _currentEndPoint,
                    destinationPoint: _destinationStartPoint,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getNavBarItem({
    required int index,
    required String img,
  }) =>
      SizedBox(
        width: _navItemWidth,
        child: GestureDetector(
          onTap: () => _onNavItemTap(index),
          child: Center(
            child: Image.asset(
              img,
              color: index == widget._currentPage
                  ? widget._navItemcolorAnimation.value
                  : Colors.grey,
            ),
          ),
        ),
      );

  void _onNavItemTap(int index) {
    if (index == widget._currentPage) return;
    // updating destination point
    _getDestinationStartPoint(index);
    // starting the animation & it will call this funtion after animation in completed
    widget.onPageChange(index, () {
      _currentStartPoint += _destinationStartPoint;
      _currentEndPoint += _destinationStartPoint;
      // print("-=----------------");
      // print(
      //     "After animation, start: $_currentStartPoint, end: $_currentEndPoint");
      // print("-=----------------");
    });
  }

  void _getDestinationStartPoint(int newIndex) {
    if (widget._currentPage < newIndex) {
      _destinationStartPoint = (newIndex - widget._currentPage) * _navItemWidth;
    } else {
      _destinationStartPoint =
          -((widget._currentPage - newIndex) * _navItemWidth);
    }
    // print(
    //     "Destination: $_destinationStartPoint : from $_currentStartPoint to $_currentEndPoint");
  }
}
