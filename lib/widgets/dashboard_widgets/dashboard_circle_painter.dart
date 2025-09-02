// ignore_for_file: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:flutter/material.dart';

class DashboardCirclePainter extends CustomPainter {
  final double percent;
  const DashboardCirclePainter({super.repaint, required this.percent});
  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height, w = size.width;
    final center = Offset(w / 2, h / 2);
    final rect = Rect.fromCenter(center: center, width: w, height: h);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15 * (1 - percent)
      ..shader = _getColorShade(Colors.lightBlue).createShader(rect);
    final paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15 * (1 - percent)
      ..shader = _getColorShade(Colors.deepPurple).createShader(rect);
    final paint3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15 * (1 - percent)
      ..shader = _getColorShade(Colors.deepOrange).createShader(rect);
    canvas.drawOval(
        Rect.fromCenter(center: center, width: w + 20, height: h + 20), paint);
    canvas.drawOval(
        Rect.fromCenter(center: center, width: w - 20, height: h - 20), paint2);
    canvas.drawOval(
        Rect.fromCenter(center: center, width: w - 60, height: h - 60), paint3);
  }

  SweepGradient _getColorShade(Color color) {
    return SweepGradient(
      tileMode: TileMode.repeated,
      startAngle: math.radians(0),
      endAngle: math.radians(360),
      colors: [
        color.withOpacity(.7),
        Colors.transparent,
        Colors.transparent,
        color.withOpacity(.7),
        color,
        color,
        color.withOpacity(.7),
      ],
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
