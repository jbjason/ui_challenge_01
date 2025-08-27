import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/pages/home_screen.dart';
import 'package:ui_challenge_01/pages/profile_screen.dart';
import 'package:ui_challenge_01/pages/schedule_screen.dart';
import 'package:ui_challenge_01/widgets/home_widgets/home_navbar.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late PageController _pageController;
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
    _pageController = PageController(initialPage: _currentPage);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    // drawer animation initialization
    _drawerAnimation = CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 1, curve: Curves.easeInOutCubic));
    // navbar animation initialization
    _navItemAninmation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _navItemcolorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(_controller);
    // adding pages
    _pages.add(
        HomeScreen(controller: _pageController, currentPage: 0));
    _pages.add(
        ScheduleScreen(controller: _pageController, currentPage: 1));
    _pages.add(
        ProfileScreen(controller: _pageController, currentPage: 2));
  }

  double val = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      body: PageView.builder(
        controller: _pageController,
        clipBehavior: Clip.none,
        physics: const PageScrollPhysics(),
        onPageChanged: (value) => setState(() => _currentPage = value),
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return _pages[index];
          // return AnimatedBuilder(
          //   animation: _pageController,
          //   builder: (context, _) {
          //     double pageVal = _pageController.page ?? 0;
          //     val = (index - pageVal).clamp(0, 1);
          //     return Padding(
          //       padding:
          //           const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           SizedBox(
          //             width: context.screenWidth,
          //             child: Transform.translate(
          //               offset: Offset(-(context.screenWidth) * val, 0),
          //               child: Transform(
          //                 alignment: Alignment.centerRight,
          //                 transform: Matrix4.identity()
          //                   ..setEntry(3, 2, .001)
          //                   ..rotateY(-pi / 2 * val),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       "Daily Goal",
          //                       style: TextStyle(fontWeight: FontWeight.bold),
          //                     ),
          //                     const SizedBox(height: 10),
          //                     RichText(
          //                       text: TextSpan(
          //                         children: [
          //                           TextSpan(
          //                             text: "87",
          //                             style: TextStyle(
          //                               fontSize: 80,
          //                               fontWeight: FontWeight.bold,
          //                               color: Colors.blue,
          //                             ),
          //                           ),
          //                           TextSpan(
          //                             text: "%",
          //                             style: TextStyle(
          //                               fontWeight: FontWeight.bold,
          //                               color: Colors.blueAccent,
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                     Container(
          //                         color:
          //                             const Color.fromARGB(255, 35, 138, 185))
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Center(child: Text(index.toString())),
          //           Opacity(
          //             opacity: 1 - val,
          //             child: SizedBox(
          //               height: context.screenHeight * .3,
          //               child: SingleChildScrollView(
          //                 child: Column(
          //                   children: List.generate(
          //                     3,
          //                     (i) => Container(
          //                       margin: EdgeInsets.symmetric(vertical: 7),
          //                       padding: EdgeInsets.symmetric(
          //                           horizontal: 10, vertical: 7),
          //                       decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(12),
          //                         color: Colors.white,
          //                         boxShadow: [
          //                           BoxShadow(
          //                             blurRadius: 15,
          //                             offset: Offset(5, 5),
          //                             color: Colors.grey.shade300,
          //                           ),
          //                         ],
          //                       ),
          //                       child: Row(
          //                         children: [
          //                           SizedBox(
          //                             width: 100,
          //                             height: 120,
          //                             child: Image.network(
          //                                 "https://picsum.photos/200/300"),
          //                           ),
          //                           const SizedBox(width: 20),
          //                           Expanded(
          //                             child: Column(
          //                               children: [
          //                                 Text(
          //                                     "A Simple way to start your day with a good breakfast"),
          //                                 const SizedBox(height: 10),
          //                                 Text(
          //                                   "Dr Testoren",
          //                                   style:
          //                                       TextStyle(color: Colors.grey),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                           const SizedBox(width: 10),
          //                           Icon(Icons.lightbulb_outline,
          //                               color: Colors.red),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // );
        },
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
        funtion();
        _controller.stop();
      });
    });
    _previousPage = _currentPage;
    setState(() => _currentPage = i);
  }

  @override
  void dispose() {
    _pageController.dispose();
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
