import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedBackground extends StatelessWidget {
  final AnimationController controller;

  const AnimatedBackground({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BackgroundPainter(controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw floating geometric shapes
    for (int i = 0; i < 6; i++) {
      final progress = (animationValue + i * 0.1) % 1.0;
      final x =
          size.width * (0.1 + i * 0.15) + math.sin(progress * 2 * math.pi) * 50;
      final y =
          size.height * (0.1 + i * 0.1) + math.cos(progress * 2 * math.pi) * 50;

      paint.color = Colors.blue.withOpacity(0.2);

      canvas.drawCircle(
        Offset(x, y),
        30 + math.sin(progress * 4 * math.pi) * 10,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
