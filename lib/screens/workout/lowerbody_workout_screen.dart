import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'exercise_detail_screen.dart';
import '../workout_schedule/workout_schedule_screen.dart';

class LowerBodyWorkoutScreen extends StatefulWidget {
  const LowerBodyWorkoutScreen({super.key});

  @override
  State<LowerBodyWorkoutScreen> createState() => _LowerBodyWorkoutScreenState();
}

class _LowerBodyWorkoutScreenState extends State<LowerBodyWorkoutScreen> {
  final ScrollController _scrollController = ScrollController();
  double _headerHeight = 200;
  final double _minHeaderHeight = 80;
  final double _maxHeaderHeight = 200;
  bool _isFavorite = false;
  final String _scheduledTime = "Today, 07:00 AM";
  String _selectedDifficulty = "Beginner";

  final List<ExerciseData> _exercises = [
    ExerciseData(
        "High Knees",
        "00:30",
        "assets/images/exercises/high_knees.png",
      )
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          9 // ~9 calories per 10 reps
      ..steps = [
        "Stand in place with feet hip-width apart.",
        "Lift your knees alternately towards your chest.",
        "Pump your arms as if you're running in place.",
        "Maintain a steady rhythm and engage your core.",
      ],
    ExerciseData("Squats", "00:45", "assets/images/exercises/squats.png")
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          7 // ~7 calories per 10 reps
      ..steps = [
        "Stand with feet shoulder-width apart.",
        "Lower your body as if sitting back into a chair.",
        "Keep your chest up and knees behind toes.",
        "Push through your heels to return to standing.",
      ],
    ExerciseData(
        "Hip Thrust",
        "00:40",
        "assets/images/exercises/hip_thrust.png",
      )
      ..difficulty = "Intermediate"
      ..caloriesPerSet =
          6 // ~6 calories per 10 reps
      ..steps = [
        "Lie on your back with knees bent and feet flat.",
        "Lift your hips towards the ceiling.",
        "Squeeze your glutes at the top of the movement.",
        "Lower back down with control.",
      ],
    ExerciseData(
        "Hamstring Stretch",
        "00:35",
        "assets/images/exercises/hamstring_stretch.png",
      )
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          2 // ~2 calories per 10 seconds
      ..steps = [
        "Sit on the floor with legs extended.",
        "Reach forward towards your toes.",
        "Hold the stretch for 15-30 seconds.",
        "Breathe deeply and relax into the stretch.",
      ],
    ExerciseData(
        "Child's Pose",
        "00:30",
        "assets/images/exercises/childs_pose.png",
      )
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          1 // ~1 calorie per 10 seconds
      ..steps = [
        "Kneel on the floor with knees wide apart.",
        "Sit back on your heels and fold forward.",
        "Extend your arms in front of you.",
        "Relax and breathe deeply.",
      ],
    ExerciseData(
        "Drink Water",
        "00:20",
        "assets/images/exercises/dring_water.png",
      )
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          0 // No calories burned
      ..steps = [
        "Take a break to hydrate.",
        "Drink 8-12 ounces of water.",
        "Rest and prepare for next exercise.",
        "Stay hydrated throughout your workout.",
      ],
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _headerHeight = (_maxHeaderHeight - _scrollController.offset * 0.6).clamp(
        _minHeaderHeight,
        _maxHeaderHeight,
      );
    });
  }

  bool get _isHeaderCollapsed => _headerHeight <= _minHeaderHeight + 50;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: [
          // Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _headerHeight,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              if (_isHeaderCollapsed)
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Lower Body Workout",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                          if (!_isHeaderCollapsed) ...[
                            SizedBox(height: _headerHeight * 0.02),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      padding: EdgeInsets.all(
                                        _headerHeight * 0.04,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 15,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: _headerHeight * 0.15,
                                            height: _headerHeight * 0.15,
                                            decoration: BoxDecoration(
                                              color: const Color(
                                                0xFF10B981,
                                              ).withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.directions_run,
                                              color: const Color(0xFF10B981),
                                              size: _headerHeight * 0.08,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Lower Body Workout",
                                                  style: GoogleFonts.poppins(
                                                    fontSize:
                                                        _headerHeight * 0.06,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  "Lower Body Focus | 9 Exercises | 28mins | 280 Calories Burn",
                                                  style: GoogleFonts.poppins(
                                                    fontSize:
                                                        _headerHeight * 0.035,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _isFavorite = !_isFavorite;
                                              });
                                            },
                                            icon: Icon(
                                              _isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: _isFavorite
                                                  ? Colors.red
                                                  : Colors.grey,
                                              size: _headerHeight * 0.05,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Scrollable content
          Positioned(
            top: _headerHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildScrollableContent(),
          ),
          // Start workout button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildStartWorkoutButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableContent() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.05,
        20,
        MediaQuery.of(context).size.width * 0.05,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWorkoutOptions(),
          const SizedBox(height: 30),
          _buildEquipmentSection(),
          const SizedBox(height: 30),
          _buildExercisesSection(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildWorkoutOptions() {
    return Column(
      children: [
        _buildOptionCard(
          icon: Icons.calendar_today,
          title: "Schedule Workout",
          value: _scheduledTime,
          onTap: () => _showScheduleDialog(),
        ),
        const SizedBox(height: 12),
        _buildOptionCard(
          icon: Icons.trending_up,
          title: "Difficulty",
          value: _selectedDifficulty,
          onTap: () => _showDifficultyDialog(),
        ),
      ],
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF10B981).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF10B981), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEquipmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Equipment",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.fitness_center,
                  color: Color(0xFF10B981),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "No Equipment Required",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "This workout can be done anywhere",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
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
    );
  }

  Widget _buildExercisesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Exercises",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ..._exercises.map((exercise) => _buildExerciseTile(exercise)),
      ],
    );
  }

  Widget _buildExerciseTile(ExerciseData exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: exercise.imagePath.endsWith('.svg')
                ? SvgPicture.asset(
                    exercise.imagePath,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF10B981),
                      BlendMode.srcIn,
                    ),
                  )
                : Image.asset(
                    exercise.imagePath,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.fitness_center,
                          color: Color(0xFF10B981),
                          size: 24,
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  exercise.repetitions > 0
                      ? '${exercise.repetitions} reps | ${exercise.caloriesPerSet} cal'
                      : exercise.duration,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              // Merge metadata from master list if inline item lacks it
              final ExerciseData meta = _exercises.firstWhere(
                (e) => e.name.toLowerCase() == exercise.name.toLowerCase(),
                orElse: () => ExerciseData(
                  exercise.name,
                  exercise.duration,
                  exercise.imagePath,
                ),
              );

              final String difficulty = (exercise.difficulty.isNotEmpty)
                  ? exercise.difficulty
                  : (meta.difficulty.isNotEmpty ? meta.difficulty : 'Beginner');
              final int caloriesPerSet = (exercise.caloriesPerSet > 0)
                  ? exercise.caloriesPerSet
                  : (meta.caloriesPerSet > 0 ? meta.caloriesPerSet : 1);
              final List<String> steps = exercise.steps.isNotEmpty
                  ? exercise.steps
                  : (meta.steps.isNotEmpty ? meta.steps : <String>[]);

              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseDetailScreen(
                    name: exercise.name,
                    imagePath: exercise.imagePath.isNotEmpty
                        ? exercise.imagePath
                        : meta.imagePath,
                    difficulty: difficulty,
                    caloriesPerSet: caloriesPerSet,
                    steps: steps,
                    themeColor: const Color(0xFF10B981),
                  ),
                ),
              );

              if (result != null && result is Map<String, dynamic>) {
                setState(() {
                  exercise.repetitions = result['reps'] as int;
                  exercise.caloriesPerSet = result['calories'] as int;
                });
              }
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showScheduleDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const WorkoutScheduleScreen()),
    );
  }

  void _showDifficultyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Difficulty',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Beginner'),
                onTap: () {
                  setState(() {
                    _selectedDifficulty = "Beginner";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Intermediate'),
                onTap: () {
                  setState(() {
                    _selectedDifficulty = "Intermediate";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Advanced'),
                onTap: () {
                  setState(() {
                    _selectedDifficulty = "Advanced";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStartWorkoutButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Starting Lower Body Workout!'),
                    backgroundColor: Color(0xFF10B981),
                  ),
                );
              },
              child: Center(
                child: Text(
                  "Start Workout",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExerciseData {
  final String name;
  final String duration;
  final String imagePath;
  int repetitions = 0;
  int caloriesPerSet = 0;
  List<String> steps = [];
  String difficulty = "Beginner";

  ExerciseData(this.name, this.duration, this.imagePath);
}
