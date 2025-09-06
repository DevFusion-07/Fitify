import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final String name;
  final String imagePath;
  final String difficulty; // e.g., Easy / Medium / Hard
  final int caloriesPerSet; // approximate
  final List<String> steps;
  final Color themeColor; // header/button accent

  const ExerciseDetailScreen({
    super.key,
    required this.name,
    required this.imagePath,
    required this.difficulty,
    required this.caloriesPerSet,
    required this.steps,
    required this.themeColor,
  });

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  int _customReps = 30;
  final int _minReps = 10;
  final int _maxReps = 50;

  int get _caloriesBurn {
    // Realistic calorie burn calculation based on exercise type and repetitions
    if (widget.caloriesPerSet <= 0) return 0;

    // Base calories per repetition varies by exercise type
    double baseCaloriesPerRep;

    switch (widget.name.toLowerCase()) {
      case 'warm up':
        baseCaloriesPerRep = 0.2; // ~2 calories per minute for warm up
        break;
      case 'jumping jacks':
        baseCaloriesPerRep = 0.8; // High intensity cardio
        break;
      case 'skipping':
        baseCaloriesPerRep = 0.7; // Moderate cardio
        break;
      case 'push-ups':
        baseCaloriesPerRep = 0.6; // Upper body strength
        break;
      case 'incline push-ups':
        baseCaloriesPerRep = 0.4; // Easier push-up variation
        break;
      case 'squats':
        baseCaloriesPerRep = 0.7; // Lower body strength
        break;
      case 'arm raises':
        baseCaloriesPerRep = 0.3; // Light upper body
        break;
      case 'plank':
        baseCaloriesPerRep = 0.3; // Isometric hold (per second equivalent)
        break;
      case 'high knees':
        baseCaloriesPerRep = 0.9; // High intensity cardio
        break;
      case 'burpees':
        baseCaloriesPerRep = 1.2; // Full body high intensity
        break;
      case 'mountain climbers':
        baseCaloriesPerRep = 0.8; // High intensity cardio
        break;
      case 'lunges':
        baseCaloriesPerRep = 0.6; // Lower body strength
        break;
      case 'bicep curls':
        baseCaloriesPerRep = 0.4; // Isolation exercise
        break;
      case 'tricep dips':
        baseCaloriesPerRep = 0.5; // Upper body strength
        break;
      case 'crunches':
        baseCaloriesPerRep = 0.3; // Core isolation
        break;
      case 'cobra stretch':
        baseCaloriesPerRep = 0.1; // Light stretching
        break;
      case 'child\'s pose':
        baseCaloriesPerRep = 0.1; // Rest/stretch pose
        break;
      case 'drink water':
        return 0; // No calories burned
      default:
        baseCaloriesPerRep = 0.5; // Default for other exercises
    }

    // Calculate total calories burned
    double totalCalories = _customReps * baseCaloriesPerRep;

    // Add some variation based on difficulty
    if (widget.difficulty.toLowerCase() == 'advanced') {
      totalCalories *= 1.2; // 20% more for advanced
    } else if (widget.difficulty.toLowerCase() == 'intermediate') {
      totalCalories *= 1.1; // 10% more for intermediate
    }

    return totalCalories.round();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.black87),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz, color: Colors.black87),
                  ),
                ],
              ),
            ),
            // Illustration
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: widget.themeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: widget.imagePath.endsWith('.svg')
                          ? Center(
                              child: SvgPicture.asset(
                                widget.imagePath,
                                width: 48,
                                height: 48,
                                colorFilter: ColorFilter.mode(
                                  widget.themeColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            )
                          : Image.asset(
                              widget.imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Center(
                                child: Icon(
                                  Icons.fitness_center,
                                  color: widget.themeColor,
                                  size: 48,
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.play_arrow,
                          color: widget.themeColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Title + meta
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.difficulty} | ${widget.caloriesPerSet} Calories/Set',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Description (short placeholder)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'A brief description about ${widget.name}. Focus on form and breathing for best results.',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // How to do it (steps)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'How To Do It',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${widget.steps.length} Steps',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.steps.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final stepNo = (index + 1).toString().padLeft(2, '0');
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: widget.themeColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          stepNo,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: widget.themeColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.steps[index],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // Custom repetitions with vertical picker
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                'Custom Repetitions',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 140,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  // Vertical repetitions picker
                  Expanded(
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.builder(
                        itemCount: _maxReps - _minReps + 1,
                        itemBuilder: (context, index) {
                          final reps = _minReps + index;
                          final isSelected = reps == _customReps;

                          // Temporarily set _customReps to calculate calories for this option
                          final originalReps = _customReps;
                          _customReps = reps;
                          final calories = _caloriesBurn;
                          _customReps = originalReps;

                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(() => _customReps = reps);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? widget.themeColor.withOpacity(0.1)
                                    : Colors.transparent,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    size: 16,
                                    color: isSelected
                                        ? widget.themeColor
                                        : Colors.grey.shade400,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '$calories Calories Burn',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: isSelected
                                          ? Colors.black87
                                          : Colors.grey.shade500,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '$reps',
                                    style: GoogleFonts.poppins(
                                      fontSize: isSelected ? 16 : 14,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? Colors.black87
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(width: 4),
                                    Text(
                                      'times',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            // Save button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.themeColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.pop(context, {
                    'reps': _customReps,
                    'calories': _caloriesBurn,
                  }),
                  child: Text(
                    'Save',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
