import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/constants/my_constant.dart';
import 'package:ui_challenge_01/pages/dashboard_screen.dart';
import 'package:ui_challenge_01/pages/profile_screen.dart';
import 'package:ui_challenge_01/pages/schedule_screen.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_moving_actor.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget Function(double)> _pageBuilders = [];
  final Flutter3DController _rhinoController = Flutter3DController();
  late PageController _pageController;
  double _controllerValue = 0, _percent = 0;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: .9);
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
      backgroundColor:Color(0xFFfcf7f3),
      body: SizedBox(
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
          child: Stack(
            children: [
              // animated Rhino actor
              Positioned.fill(
                bottom: context.screenHeight * .25,
                child: HomeMovingActor(controller: _rhinoController),
              ),
              // pages
              PageView.builder(
                controller: _pageController,
                clipBehavior: Clip.none,
                physics: const PageScrollPhysics(),
                itemCount: _pageBuilders.length,
                itemBuilder: (context, index) {
                  _percent = _controllerValue - index;
                  return _pageBuilders[index](_percent);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeNavbar(onPageChange: _onPageChange),
    );
  }

  void _onPageChange(int i) async {
    _pageController.animateToPage(i,
        duration: MyConstant.duration, curve: Curves.easeInOut);
    _rhinoController.setCameraOrbit(
      MyConstant.cameraOrbitList[i][0],
      MyConstant.cameraOrbitList[i][1],
      MyConstant.cameraOrbitList[i][2],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
