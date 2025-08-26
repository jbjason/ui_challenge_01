import 'package:flutter/material.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentPage = 0;
  final _pages = [
    TestScreen(title: "Home Screen"),
    TestScreen(title: "Report Screen"),
    TestScreen(title: "Schedule Screen"),
  ];

  // navbar animation
  late Animation<double> _navItemAninmation;
  late Animation _navItemcolorAnimation;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() {
    // initializing animation
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    // // navbar animation initialization
    _navItemAninmation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _navItemcolorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _pages[_currentPage]),
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

  void _onPageChange(int i, Function funtion) {
    setState(() => _currentPage = i);
    Future.delayed(Duration()).then((_) {
      _controller.stop();
      _controller.forward(from: 0.0).whenComplete(() {
        funtion();
        _controller.stop();
      });
    });
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
