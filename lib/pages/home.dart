import 'package:flutter/material.dart';
import 'package:ui_challenge_01/pages/home_screen.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentPage = 0, _previousPage = 0;
  final _pages = <Widget>[];
  // drawer animation
  late Animation<double> _drawerAnimation;
  // navbar animation
  late Animation<double> _navItemAninmation;
  late Animation _navItemcolorAnimation;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    // // drawer animation initialization
    _drawerAnimation =
        CurvedAnimation(parent: _controller, curve: Interval(0.3, 1,curve:  Curves.easeIn,));
    // // navbar animation initialization
    _navItemAninmation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInQuad);
    _navItemcolorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(_controller);

    _pages.add(
      HomeScreen(
        controller: _controller,
        drawerAnimation: _drawerAnimation,
        currentPage: _currentPage,
        previousPage: _previousPage,
      ),
    );
    _pages.add(TestScreen(title: "Report Screen"));
    _pages.add(TestScreen(title: "Schedule Screen"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentPage, children: _pages),
      bottomNavigationBar: HomeNavbar(
        currentPage: _currentPage,
        onPageChange: _onPageChange,
        controller: _controller,
        navItemAninmation: _navItemAninmation,
        navItemcolorAnimation: _navItemcolorAnimation,
      ),
    );
  }

  void _onPageChange(int i, Function funtion) async{
    
    Future.delayed(Duration()).then((_) {
      _controller.stop();
      _controller.forward(from: 0.0).whenComplete(() {
        funtion();
        _controller.stop();
      });
    });
    _previousPage = _currentPage;
    setState(() => _currentPage = i);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}
