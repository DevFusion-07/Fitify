import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/activity_provider.dart';
import '../../widgets/sleep_pattern_widget.dart';

class SleepDetailScreen extends StatelessWidget {
  const SleepDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sleep',
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
                'Last Night',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                activity.sleepDuration,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              SleepPatternWidget(
                sleepDuration: activity.sleepDuration,
                sleepPattern: activity.sleepPattern,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
