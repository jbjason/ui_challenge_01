// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:vector_math/vector_math.dart' as math;
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/constants/my_image.dart';

class HomeNavbar extends StatelessWidget {
  const HomeNavbar(
      {super.key, required this.currentPage, required this.onPageChange});
  final int currentPage;
  final Function onPageChange;

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth / 3;
    return SizedBox(
      height: kBottomNavigationBarHeight ,
      child: Column(
        children: [
          Row(
            children: [
              _getNavBarItem(index: 0, img: MyImage.homeIcon, width: width),
              _getNavBarItem(index: 1, img: MyImage.homeIcon, width: width),
              _getNavBarItem(index: 2, img: MyImage.homeIcon, width: width),
            ],
          ),

          Align(
            alignment: Alignment.center ,
            child: SizedBox(
              width: width,
              child: CustomPaint(
                  painter: HomeNavbarPainter(color: Colors.red, width: width)
                     ,
                ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getNavBarItem(
      {required int index, required String img, required double width}) {
    final isSelected = index == currentPage;
    final color = isSelected ? Colors.red : null;
    return GestureDetector(
      onTap: () => onPageChange(index),
      child: SizedBox(
        width: width,
        child: Center(child: Image.asset(img, color: color, height: 30)),
      ),
    );
  }
}

class HomeNavbarPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double width;
  const HomeNavbarPainter({
    this.strokeWidth = 5.0,
    required this.color,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

     canvas.drawLine(Offset(w * .3, h/2 ), Offset(w * .7, h/2 ), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
