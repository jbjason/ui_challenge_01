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
    required this.destinationPoint,
    required this.currentEndPoint,
    this.strokeWidth = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // print(
    //     "destination: ${destinationPoint.toStringAsFixed(2)}, from ${(currentStartPoint + (destinationPoint * controllerValue)).toStringAsFixed(2)} to ${(currentEndPoint + (destinationPoint * controllerValue)).toStringAsFixed(2)}");
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
