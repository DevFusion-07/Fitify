import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const WorkoutItemWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.iconColor = const Color(0xFF6B73FF),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [iconColor.withOpacity(0.1), iconColor.withOpacity(0.2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: iconColor,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}

// Predefined workout types with their icons and colors
class WorkoutType {
  static const Map<String, Map<String, dynamic>> types = {
    'fullbody': {
      'icon': Icons.fitness_center,
      'color': Color(0xFF6B73FF),
    },
    'lowerbody': {
      'icon': Icons.accessibility_new,
      'color': Color(0xFF8B5CF6),
    },
    'upperbody': {
      'icon': Icons.sports_gymnastics,
      'color': Color(0xFF10B981),
    },
    'ab': {
      'icon': Icons.sports_martial_arts,
      'color': Color(0xFFF59E0B),
    },
    'cardio': {
      'icon': Icons.directions_run,
      'color': Color(0xFFEF4444),
    },
    'yoga': {
      'icon': Icons.self_improvement,
      'color': Color(0xFF8B5CF6),
    },
  };
}
