import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/onboarding/onboarding_screen.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: data.backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Image.asset(
                  data.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildIllustration();
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  data.title,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  data.subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    // Placeholder illustrations based on the page content
    switch (data.title) {
      case "Track Your Goals":
        return _buildTrackGoalIllustration();
      case "Get Burn":
        return _buildGetBurnIllustration();
      case "Eat Well":
        return _buildEatWellIllustration();
      case "Improve Sleep Quality":
        return _buildSleepQualityIllustration();
      default:
        return const Icon(
          Icons.fitness_center,
          size: 120,
          color: Color(0xFF6B73FF),
        );
    }
  }

  Widget _buildTrackGoalIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFF6B73FF).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        ),
        const Icon(Icons.track_changes, size: 80, color: Color(0xFF6B73FF)),
      ],
    );
  }

  Widget _buildGetBurnIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFF6B73FF).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        ),
        const Icon(
          Icons.local_fire_department,
          size: 80,
          color: Color(0xFF6B73FF),
        ),
      ],
    );
  }

  Widget _buildEatWellIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFF6B73FF).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        ),
        const Icon(Icons.restaurant, size: 80, color: Color(0xFF6B73FF)),
      ],
    );
  }

  Widget _buildSleepQualityIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFF6B73FF).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        ),
        const Icon(Icons.bedtime, size: 80, color: Color(0xFF6B73FF)),
      ],
    );
  }
}
