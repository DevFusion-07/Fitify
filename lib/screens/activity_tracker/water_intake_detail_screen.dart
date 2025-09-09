import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/activity_provider.dart';

class WaterIntakeDetailScreen extends StatelessWidget {
  const WaterIntakeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Water Intake',
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
                'Today',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${activity.currentWaterIntakeL.toStringAsFixed(1)}L',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '/ ${activity.targetWaterIntakeL.toStringAsFixed(1)}L',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Updates',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final item = activity.waterUpdates[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.timeRange,
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        Text(
                          '${item.amountMl} ml',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(height: 16),
                  itemCount: activity.waterUpdates.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
