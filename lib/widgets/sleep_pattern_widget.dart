import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../utils/responsive_utils.dart';

class SleepPatternWidget extends StatelessWidget {
  final String sleepDuration;
  final List<double> sleepPattern;
  final double? height;

  const SleepPatternWidget({
    super.key,
    required this.sleepDuration,
    required this.sleepPattern,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = height ?? ResponsiveUtils.getCardHeight(context, 120);
    final padding = ResponsiveUtils.getResponsivePadding(
      context,
      const EdgeInsets.all(12),
    );

    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Background (no image)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF6B73FF).withOpacity(0.7),
                      const Color(0xFF8B5CF6).withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            // Content overlay
            Positioned.fill(
              child: Container(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bedtime, color: Colors.white, size: 24),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            "Sleep",
                            style: GoogleFonts.poppins(
                              fontSize: ResponsiveUtils.getResponsiveFontSize(
                                context,
                                16,
                              ),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          sleepDuration,
                          style: GoogleFonts.poppins(
                            fontSize: ResponsiveUtils.getResponsiveFontSize(
                              context,
                              14,
                            ),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Stack(
                        children: [
                          // Full-width graph
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/sleep/sleep_graph.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Removed overlay text; now in header row
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      final y =
          size.height / 2 +
          math.sin(sleepPattern[i] * math.pi * 2) * (size.height / 4);
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
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        currentPoint.dx,
        currentPoint.dy,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
