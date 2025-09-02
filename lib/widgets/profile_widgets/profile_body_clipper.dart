import 'package:flutter/material.dart';

class ProfileBodyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width, h = size.height;
    final path = Path()
      ..fillType = PathFillType.evenOdd; // important for making a hole
    path.addRect(Rect.fromLTWH(0, 0, w, h)); // full red rect
    path.addOval(Rect.fromCircle(
      center: Offset(w * .5, h * .3), // circle position
      radius: size.width * .4, // circle radius
    ));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
