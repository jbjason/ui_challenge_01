import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/pages/home_screen.dart';
import 'package:ui_challenge_01/pages/profile_screen.dart';
import 'package:ui_challenge_01/pages/schedule_screen.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_moving_actor.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final List<Widget Function(double)> _pageBuilders = [];
  late PageController _pageController;
  late AnimationController _controller;
  late Animation<double> _navItemAninmation;
  late Animation _navItemcolorAnimation;
  double _controllerValue = 0, _percent = 0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _navItemAninmation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _navItemcolorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(_controller);

    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: .9);
    _pageBuilders.add(
        (percent) => HomeScreen(controller: _pageController, percent: percent));
    _pageBuilders.add((percent) =>
        ScheduleScreen(controller: _pageController, percent: percent));
    _pageBuilders.add((percent) =>
        ProfileScreen(controller: _pageController, percent: percent));
    _pageController.addListener(_listener);
  }

  void _listener() => setState(() => _controllerValue = _pageController.page!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 230, 229),
      body: SafeArea(
        child: SizedBox(
          width: context.screenWidth,
          height: context.screenHeight,
          child: PageView.builder(
            controller: _pageController,
            clipBehavior: Clip.none,
            physics: const PageScrollPhysics(),
            onPageChanged: (value) => setState(() => _currentPage = value),
            itemCount: _pageBuilders.length,
            itemBuilder: (context, index) {
              _percent = _controllerValue - index;
              return _pageBuilders[index](_percent);
            },
          ),
        ),
      ),
      bottomNavigationBar: HomeNavbar(
        currentPage: _currentPage,
        onPageChange: _onPageChange,
        controller: _controller,
        navItemAninmation: _navItemAninmation,
        navItemcolorAnimation: _navItemcolorAnimation,
      ),
    );
  }

  void _onPageChange(int i, Function funtion) async {
    Future.delayed(Duration()).then((_) {
      _controller.stop();
      _controller.forward(from: 0.0).whenComplete(() {
        _controller.stop();
        funtion();
      });
    });
    setState(() => _currentPage = i);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
