import 'package:flutter/material.dart';
import 'dart:math' as math;

class LineChartWidget extends StatelessWidget {
  final List<double> data;
  final double height;
  final Color lineColor;
  final Color fillColor;
  final bool showGrid;
  final bool showPoints;
  final String? highlightLabel;
  final int? highlightIndex;

  const LineChartWidget({
    super.key,
    required this.data,
    this.height = 120,
    this.lineColor = const Color(0xFF6B73FF),
    this.fillColor = const Color(0xFF6B73FF),
    this.showGrid = true,
    this.showPoints = true,
    this.highlightLabel,
    this.highlightIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Y-axis labels
          if (showGrid) ...[
            SizedBox(
              width: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  final value = 100 - (index * 20);
                  return Text(
                    '$value%',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(width: 8),
          ],
          // Chart area
          Expanded(
            child: Stack(
              children: [
                CustomPaint(
                  painter: LineChartPainter(
                    data: data,
                    lineColor: lineColor,
                    fillColor: fillColor,
                    showGrid: showGrid,
                    showPoints: showPoints,
                    highlightIndex: highlightIndex,
                  ),
                  size: Size.infinite,
                ),
                if (highlightLabel != null && highlightIndex != null)
                  Positioned(
                    left: (highlightIndex! / (data.length - 1)) * (height - 32),
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: lineColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        highlightLabel!,
                        style: TextStyle(
                          color: lineColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
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

class LineChartPainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final Color fillColor;
  final bool showGrid;
  final bool showPoints;
  final int? highlightIndex;

  LineChartPainter({
    required this.data,
    required this.lineColor,
    required this.fillColor,
    required this.showGrid,
    required this.showPoints,
    this.highlightIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..color = fillColor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final pointPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    final highlightPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    // Calculate points
    final points = <Offset>[];
    final maxValue = data.reduce(math.max);
    final minValue = data.reduce(math.min);
    final range = maxValue - minValue;

    for (int i = 0; i < data.length; i++) {
      final x = (i / (data.length - 1)) * size.width;
      final y = size.height - ((data[i] - minValue) / range) * size.height;
      points.add(Offset(x, y));
    }

    // Draw grid
    if (showGrid) {
      final gridPaint = Paint()
        ..color = Colors.grey.withOpacity(0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5;

      // Horizontal grid lines
      for (int i = 0; i <= 5; i++) {
        final y = (i / 5) * size.height;
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      }

      // Vertical grid lines for data points
      for (int i = 0; i < data.length; i++) {
        final x = (i / (data.length - 1)) * size.width;
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
      }
    }

    // Draw filled area
    final path = Path();
    path.moveTo(points.first.dx, size.height);
    for (final point in points) {
      path.lineTo(point.dx, point.dy);
    }
    path.lineTo(points.last.dx, size.height);
    path.close();
    canvas.drawPath(path, fillPaint);

    // Draw line
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }

    // Draw points
    if (showPoints) {
      for (int i = 0; i < points.length; i++) {
        final point = points[i];
        if (i == highlightIndex) {
          canvas.drawCircle(point, 6, highlightPaint);
          canvas.drawCircle(point, 3, Paint()..color = Colors.white);
        } else {
          canvas.drawCircle(point, 3, pointPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
