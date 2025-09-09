import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/activity_provider.dart';
import '../../widgets/line_chart_widget.dart';

class HeartRateDetailScreen extends StatelessWidget {
  const HeartRateDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Heart Rate',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Consumer<ActivityProvider>(
        builder: (context, activity, _) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${activity.heartRate} BPM',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Trend',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              LineChartWidget(
                data: activity.heartRateHistory,
                height: 180,
                showGrid: true,
                showPoints: true,
                lineColor: const Color(0xFF6B73FF),
                fillColor: const Color(0xFF6B73FF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
