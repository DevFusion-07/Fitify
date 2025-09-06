import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomCircularProgressIndicator extends StatelessWidget {
  final double progress;
  final double size;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final Widget? child;

  const CustomCircularProgressIndicator({
    super.key,
    required this.progress,
    this.size = 80,
    this.color = const Color(0xFF6B73FF),
    this.backgroundColor = Colors.white,
    this.strokeWidth = 8,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Background circle
          CustomPaint(
            size: Size(size, size),
            painter: CirclePainter(
              progress: 1.0,
              color: backgroundColor.withOpacity(0.3),
              strokeWidth: strokeWidth,
            ),
          ),
          // Progress circle
          CustomPaint(
            size: Size(size, size),
            painter: CirclePainter(
              progress: progress,
              color: color,
              strokeWidth: strokeWidth,
            ),
          ),
          // Center child
          if (child != null)
            Center(child: child!),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  CirclePainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
