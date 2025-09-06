import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../utils/responsive_utils.dart';

class SleepPatternWidget extends StatelessWidget {
  final String sleepDuration;
  final List<double> sleepPattern;

  const SleepPatternWidget({
    super.key,
    required this.sleepDuration,
    required this.sleepPattern,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = ResponsiveUtils.getCardHeight(context, 120);
    final padding = ResponsiveUtils.getResponsivePadding(context, const EdgeInsets.all(12));
    
    return Container(
      height: cardHeight,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bedtime, color: const Color(0xFF6B73FF), size: 24),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  "Sleep",
                  style: GoogleFonts.poppins(
                    fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sleepDuration,
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6B73FF),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveSize(context, 4)),
                      Text(
                        "Sleep pattern",
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 10),
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: ResponsiveUtils.getResponsiveSize(context, 12)),
                // Sleep pattern graph
                SizedBox(
                  width: ResponsiveUtils.getResponsiveSize(context, 60),
                  height: ResponsiveUtils.getResponsiveSize(context, 30),
                  child: CustomPaint(
                    painter: SleepPatternPainter(sleepPattern: sleepPattern),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SleepPatternPainter extends CustomPainter {
  final List<double> sleepPattern;

  SleepPatternPainter({required this.sleepPattern});

  @override
  void paint(Canvas canvas, Size size) {
    if (sleepPattern.isEmpty) return;

    final paint = Paint()
      ..color = const Color(0xFF6B73FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    final points = <Offset>[];

    for (int i = 0; i < sleepPattern.length; i++) {
      final x = (i / (sleepPattern.length - 1)) * size.width;
      final y = size.height / 2 + math.sin(sleepPattern[i] * math.pi * 2) * (size.height / 4);
      points.add(Offset(x, y));
    }

    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      final prevPoint = points[i - 1];
      final currentPoint = points[i];
      
      // Create smooth curve
      final controlPoint1 = Offset(
        prevPoint.dx + (currentPoint.dx - prevPoint.dx) / 3,
        prevPoint.dy,
      );
      final controlPoint2 = Offset(
        currentPoint.dx - (currentPoint.dx - prevPoint.dx) / 3,
        currentPoint.dy,
      );
      
      path.cubicTo(
        controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        currentPoint.dx, currentPoint.dy,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
