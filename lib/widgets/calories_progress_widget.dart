import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'circular_progress_indicator.dart';
import '../utils/responsive_utils.dart';

class CaloriesProgressWidget extends StatelessWidget {
  final int currentCalories;
  final int targetCalories;
  final int remainingCalories;

  const CaloriesProgressWidget({
    super.key,
    required this.currentCalories,
    required this.targetCalories,
    required this.remainingCalories,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentCalories / targetCalories).clamp(0.0, 1.0);
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
              Icon(Icons.local_fire_department, color: const Color(0xFF6B73FF), size: 24),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  "Calories",
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
                        "$currentCalories kCal",
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6B73FF),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveSize(context, 2)),
                      Text(
                        "Progress",
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
                // Circular progress
                CustomCircularProgressIndicator(
                  progress: progress,
                  size: ResponsiveUtils.getResponsiveSize(context, 50),
                  strokeWidth: ResponsiveUtils.getResponsiveSize(context, 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "$remainingCalories",
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 8),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6B73FF),
                        ),
                      ),
                      Text(
                        "kCal left",
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 6),
                          color: Colors.grey.shade600,
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
