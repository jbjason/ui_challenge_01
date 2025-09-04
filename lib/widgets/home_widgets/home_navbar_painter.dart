import 'package:flutter/material.dart';


class HomeNavbarPainter extends CustomPainter {
  final double controllerValue;
  final double currentStartPoint;
  final double currentEndPoint;
  final double destinationPoint;
  final double strokeWidth;

  const HomeNavbarPainter({
    required this.controllerValue,
    required this.currentStartPoint,
    required this.currentEndPoint,
    required this.destinationPoint,
    this.strokeWidth = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(currentStartPoint + (destinationPoint * controllerValue), h / 2),
      Offset(currentEndPoint + (destinationPoint * controllerValue), h / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant HomeNavbarPainter oldDelegate) {
    return oldDelegate.controllerValue != controllerValue ||
        oldDelegate.currentStartPoint != currentStartPoint ||
        oldDelegate.currentEndPoint != currentEndPoint ||
        oldDelegate.destinationPoint != destinationPoint;
  }
}