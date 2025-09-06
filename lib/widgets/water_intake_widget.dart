import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive_utils.dart';

class WaterIntakeWidget extends StatelessWidget {
  final double currentIntake;
  final double targetIntake;
  final List<WaterIntakeUpdate> updates;

  const WaterIntakeWidget({
    super.key,
    required this.currentIntake,
    required this.targetIntake,
    required this.updates,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentIntake / targetIntake).clamp(0.0, 1.0);
    final cardHeight = ResponsiveUtils.getCardHeight(context, 120);
    final fontSize = ResponsiveUtils.getResponsiveFontSize(context, 12);
    final padding = ResponsiveUtils.getResponsivePadding(
      context,
      const EdgeInsets.all(10),
    );

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
              Icon(Icons.water_drop, color: const Color(0xFF6B73FF), size: 24),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  "Water Intake",
                  style: GoogleFonts.poppins(
                    fontSize: ResponsiveUtils.getResponsiveFontSize(
                      context,
                      14,
                    ),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                // Vertical bar chart
                SizedBox(
                  width: ResponsiveUtils.getResponsiveSize(context, 24),
                  child: Stack(
                    children: [
                      // Background bar
                      Container(
                        width: ResponsiveUtils.getResponsiveSize(context, 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      // Progress bar
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: ResponsiveUtils.getResponsiveSize(context, 4),
                          height:
                              (cardHeight - padding.vertical - 40) * progress,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6B73FF), Color(0xFF8B5CF6)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: ResponsiveUtils.getResponsiveSize(context, 8)),
                // Updates list
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${currentIntake.toStringAsFixed(1)}L",
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context,
                            12,
                          ),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6B73FF),
                        ),
                      ),
                      SizedBox(
                        height: ResponsiveUtils.getResponsiveSize(context, 2),
                      ),
                      Text(
                        "Updates",
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context,
                            8,
                          ),
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: ResponsiveUtils.getResponsiveSize(context, 2),
                      ),
                      ...updates
                          .take(1)
                          .map(
                            (update) => Text(
                              "${update.timeRange} ${update.amount}ml",
                              style: GoogleFonts.poppins(
                                fontSize: ResponsiveUtils.getResponsiveFontSize(
                                  context,
                                  7,
                                ),
                                color: Colors.grey.shade500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                    ],
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

class WaterIntakeUpdate {
  final String timeRange;
  final int amount;

  WaterIntakeUpdate({required this.timeRange, required this.amount});
}
