import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/performance_utils.dart';
import '../../utils/app_constants.dart';

class OptimizedExerciseDetailScreen extends StatefulWidget {
  final String name;
  final String imagePath;
  final String difficulty;
  final int caloriesPerSet;
  final List<String> steps;
  final Color themeColor;

  const OptimizedExerciseDetailScreen({
    super.key,
    required this.name,
    required this.imagePath,
    required this.difficulty,
    required this.caloriesPerSet,
    required this.steps,
    required this.themeColor,
  });

  @override
  State<OptimizedExerciseDetailScreen> createState() =>
      _OptimizedExerciseDetailScreenState();
}

class _OptimizedExerciseDetailScreenState
    extends State<OptimizedExerciseDetailScreen> {
  int _customReps = 30;
  final int _minReps = 10;
  final int _maxReps = 50;

  // Performance optimization: cache expensive calculations
  late final int _caloriesBurn = _calculateCaloriesBurn();

  int _calculateCaloriesBurn() {
    if (widget.caloriesPerSet <= 0) return 0;

    double baseCaloriesPerRep;
    final exerciseName = widget.name.toLowerCase();

    switch (exerciseName) {
      case 'warm up':
        baseCaloriesPerRep = 0.2;
        break;
      case 'jumping jacks':
        baseCaloriesPerRep = 0.8;
        break;
      case 'skipping':
        baseCaloriesPerRep = 0.7;
        break;
      case 'push-ups':
        baseCaloriesPerRep = 0.6;
        break;
      case 'incline push-ups':
        baseCaloriesPerRep = 0.4;
        break;
      case 'squats':
        baseCaloriesPerRep = 0.7;
        break;
      case 'arm raises':
        baseCaloriesPerRep = 0.3;
        break;
      case 'plank':
        baseCaloriesPerRep = 0.3;
        break;
      case 'high knees':
        baseCaloriesPerRep = 0.9;
        break;
      case 'burpees':
        baseCaloriesPerRep = 1.2;
        break;
      case 'mountain climbers':
        baseCaloriesPerRep = 0.8;
        break;
      case 'lunges':
        baseCaloriesPerRep = 0.6;
        break;
      case 'bicep curls':
        baseCaloriesPerRep = 0.4;
        break;
      case 'tricep dips':
        baseCaloriesPerRep = 0.5;
        break;
      case 'crunches':
        baseCaloriesPerRep = 0.3;
        break;
      case 'cobra stretch':
      case 'child\'s pose':
        return 0;
      default:
        baseCaloriesPerRep = 0.5;
    }

    return (_customReps * baseCaloriesPerRep).round();
  }

  @override
  Widget build(BuildContext context) {
    return PerformanceMonitor(
      name: 'ExerciseDetailScreen',
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: OptimizedListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildExerciseImage(),
                    const SizedBox(height: 24),
                    _buildExerciseInfo(),
                    const SizedBox(height: 24),
                    _buildRepsSlider(),
                    const SizedBox(height: 24),
                    _buildCaloriesInfo(),
                    const SizedBox(height: 24),
                    _buildStepsSection(),
                  ],
                ),
              ),
              _buildStartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return OptimizedAnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [widget.themeColor, widget.themeColor.withOpacity(0.8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24,
            ),
          ),
          Expanded(
            child: OptimizedText(
              widget.name,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Add to favorites
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseImage() {
    return OptimizedCard(
      borderRadius: 16,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: OptimizedImage(
          imagePath: widget.imagePath,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildExerciseInfo() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            'Difficulty',
            widget.difficulty,
            Icons.fitness_center,
            widget.themeColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            'Calories/Set',
            '${widget.caloriesPerSet} cal',
            Icons.local_fire_department,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return OptimizedCard(
      backgroundColor: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            OptimizedText(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            OptimizedText(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRepsSlider() {
    return OptimizedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OptimizedText(
            'Number of Reps',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              OptimizedText(
                '$_customReps',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: widget.themeColor,
                ),
              ),
              const SizedBox(width: 8),
              OptimizedText(
                'reps',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: widget.themeColor,
              thumbColor: widget.themeColor,
              overlayColor: widget.themeColor.withOpacity(0.2),
            ),
            child: Slider(
              value: _customReps.toDouble(),
              min: _minReps.toDouble(),
              max: _maxReps.toDouble(),
              divisions: _maxReps - _minReps,
              onChanged: (value) {
                setState(() {
                  _customReps = value.round();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaloriesInfo() {
    return OptimizedCard(
      backgroundColor: widget.themeColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.local_fire_department,
              color: widget.themeColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OptimizedText(
                    'Calories Burned',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  OptimizedText(
                    '$_caloriesBurn cal',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: widget.themeColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepsSection() {
    return OptimizedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OptimizedText(
            'How to Perform',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ...widget.steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: widget.themeColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: OptimizedText(
                        '${index + 1}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OptimizedText(
                      step,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: OptimizedButton(
        text: 'Start Exercise',
        backgroundColor: widget.themeColor,
        height: 50,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        onPressed: () {
          // TODO: Start exercise timer
          HapticFeedback.lightImpact();
        },
      ),
    );
  }
}
