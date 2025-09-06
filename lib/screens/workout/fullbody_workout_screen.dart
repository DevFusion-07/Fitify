import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'exercise_detail_screen.dart';
import '../workout_schedule/workout_schedule_screen.dart';
import '../../utils/equipment_icons.dart';

class FullbodyWorkoutScreen extends StatefulWidget {
  const FullbodyWorkoutScreen({super.key});

  @override
  State<FullbodyWorkoutScreen> createState() => _FullbodyWorkoutScreenState();
}

class _FullbodyWorkoutScreenState extends State<FullbodyWorkoutScreen> {
  bool _isFavorite = true;
  String _selectedDifficulty = "Beginner";
  final String _scheduledTime = "5/27, 09:00 AM";
  final ScrollController _scrollController = ScrollController();
  double _headerHeight = 280.0;
  double _minHeaderHeight = 120.0;
  double _maxHeaderHeight = 280.0;

  final List<ExerciseData> _exercises = [
    ExerciseData("Warm Up", "05:00", "assets/images/exercises/warmup.png")
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          2 // ~2 calories per minute for warm up
      ..steps = [
        "Start with light stretching and mobility exercises.",
        "Perform gentle arm circles and shoulder rolls.",
        "Do some light walking or marching in place.",
        "Gradually increase your heart rate and prepare your muscles.",
      ],
    ExerciseData(
        "Jumping Jacks",
        "00:30",
        "assets/images/exercises/jumping_jacks.png",
      )
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          8 // ~8 calories per 10 reps
      ..steps = [
        "Stand with your feet together and arms at your sides.",
        "Jump and spread your legs shoulder-width apart while raising your arms above your head.",
        "Jump back to the starting position with feet together and arms at your sides.",
        "Repeat the movement at a steady pace.",
      ],
    ExerciseData("Skipping", "00:30", "assets/images/exercises/skipping.png")
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          7 // ~7 calories per 10 reps
      ..steps = [
        "Stand with feet hip-width apart.",
        "Lift one knee and hop on the opposite foot.",
        "Alternate legs in a skipping motion.",
        "Keep your arms moving naturally as you skip.",
      ],
    ExerciseData("Push-ups", "00:45", "assets/images/exercises/pushup.png")
      ..difficulty = "Intermediate"
      ..caloriesPerSet =
          6 // ~6 calories per 10 reps
      ..steps = [
        "Start in a plank position with hands slightly wider than shoulders.",
        "Lower your body until your chest nearly touches the floor.",
        "Push your body back up to the starting position.",
        "Keep your core engaged throughout the movement.",
      ],
    ExerciseData(
        "Incline Push-Ups",
        "00:40",
        "assets/images/exercises/incline_pushup.png",
      )
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          4 // ~4 calories per 10 reps
      ..steps = [
        "Place your hands on an elevated surface like a chair or step.",
        "Keep your body in a straight line from head to heels.",
        "Lower your chest towards the surface.",
        "Push back up to the starting position.",
      ],
    ExerciseData("Squats", "00:40", "assets/images/exercises/squats.png")
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          7 // ~7 calories per 10 reps
      ..steps = [
        "Stand with feet shoulder-width apart.",
        "Lower your body as if sitting back into a chair.",
        "Keep your chest up and knees behind your toes.",
        "Push through your heels to return to standing.",
      ],
    ExerciseData(
        "Arm Raises",
        "00:35",
        "assets/images/exercises/bicep_curl.png",
      )
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          3 // ~3 calories per 10 reps
      ..steps = [
        "Stand with feet shoulder-width apart.",
        "Hold weights at your sides with palms facing forward.",
        "Raise your arms to shoulder level.",
        "Lower back down with control and repeat.",
      ],
    ExerciseData("Plank", "00:35", "assets/images/exercises/plank.png")
      ..difficulty = "Intermediate"
      ..caloriesPerSet =
          3 // ~3 calories per 10 seconds
      ..steps = [
        "Start in a push-up position with arms straight.",
        "Keep your body in a straight line from head to heels.",
        "Engage your core and hold the position.",
        "Breathe steadily and maintain form.",
      ],
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
    ExerciseData("Burpees", "00:50", "assets/icons/exercise_icons.svg")
      ..difficulty = "Advanced"
      ..caloriesPerSet =
          12 // ~12 calories per 10 reps
      ..steps = [
        "Start standing, then squat down and place hands on the floor.",
        "Jump feet back into a plank position.",
        "Perform a push-up, then jump feet back to squat position.",
        "Jump up with arms overhead and repeat.",
      ],
    ExerciseData(
        "Mountain Climbers",
        "00:40",
        "assets/icons/exercise_icons.svg",
      )
      ..difficulty = "Intermediate"
      ..caloriesPerSet =
          8 // ~8 calories per 10 reps
      ..steps = [
        "Start in a plank position with arms straight.",
        "Drive one knee towards your chest, then quickly switch legs.",
        "Keep your core engaged and maintain a steady pace.",
        "Continue alternating legs in a running motion.",
      ],
    ExerciseData("Lunges", "00:45", "assets/icons/exercise_icons.svg")
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          6 // ~6 calories per 10 reps
      ..steps = [
        "Stand with feet hip-width apart.",
        "Step forward with one leg and lower your body.",
        "Keep your front knee behind your toes.",
        "Push back to starting position and repeat with other leg.",
      ],
    ExerciseData(
        "Bicep Curls",
        "00:35",
        "assets/images/exercises/bicep_curl.png",
      )
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          4 // ~4 calories per 10 reps
      ..steps = [
        "Stand with feet shoulder-width apart.",
        "Hold weights at your sides with palms facing forward.",
        "Curl the weights towards your shoulders.",
        "Lower back down with control and repeat.",
      ],
    ExerciseData("Tricep Dips", "00:40", "assets/icons/exercise_icons.svg")
      ..difficulty = "Intermediate"
      ..caloriesPerSet =
          5 // ~5 calories per 10 reps
      ..steps = [
        "Sit on the edge of a chair with hands beside your hips.",
        "Slide off the chair and lower your body.",
        "Push back up using your triceps.",
        "Keep your elbows close to your body.",
      ],
    ExerciseData("Crunches", "00:30", "assets/images/exercises/crunches.png")
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          3 // ~3 calories per 10 reps
      ..steps = [
        "Lie on your back with knees bent and feet flat.",
        "Place hands behind your head or across your chest.",
        "Lift your shoulders off the ground using your abs.",
        "Lower back down with control and repeat.",
      ],
    ExerciseData(
        "Cobra Stretch",
        "00:30",
        "assets/images/exercises/cobra_stretch.png",
      )
      ..difficulty = "Beginner"
      ..caloriesPerSet =
          1 // ~1 calorie per 10 seconds
      ..steps = [
        "Lie on your stomach with hands under your shoulders.",
        "Press your hands into the floor and lift your chest.",
        "Keep your hips on the ground and look forward.",
        "Hold the stretch and breathe deeply.",
      ],
    ExerciseData(
        "Child's Pose",
        "00:20",
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
        "00:15",
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

  // Persisted exercise sets so changes survive rebuilds
  late final List<ExerciseData> _set1;
  late final List<ExerciseData> _set2;
  late final List<ExerciseData> _set3;

  ExerciseData _exerciseWithMeta({
    required String name,
    required String duration,
    required String imagePath,
  }) {
    // Find metadata from master list by normalized name, otherwise create basic
    String normalized = name.toLowerCase().trim();
    if (normalized == 'jumping jack') normalized = 'jumping jacks';

    final ExerciseData meta = _exercises.firstWhere(
      (e) => e.name.toLowerCase() == normalized,
      orElse: () => ExerciseData(name, duration, imagePath),
    );

    final ExerciseData item = ExerciseData(name, duration, imagePath)
      ..difficulty = meta.difficulty.isNotEmpty ? meta.difficulty : 'Beginner'
      ..caloriesPerSet = meta.caloriesPerSet
      ..steps = List<String>.from(meta.steps);
    return item;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Initialize sets once; they persist across rebuilds
    _set1 = [
      _exerciseWithMeta(
        name: 'Warm Up',
        duration: '05:00',
        imagePath: 'assets/images/exercises/warmup.png',
      ),
      _exerciseWithMeta(
        name: 'Jumping Jack',
        duration: '12x',
        imagePath: 'assets/images/exercises/jumping_jacks.png',
      ),
      _exerciseWithMeta(
        name: 'Skipping',
        duration: '15x',
        imagePath: 'assets/images/exercises/skipping.png',
      ),
      _exerciseWithMeta(
        name: 'Squats',
        duration: '20x',
        imagePath: 'assets/images/exercises/squats.png',
      ),
      _exerciseWithMeta(
        name: 'Arm Raises',
        duration: '00:53',
        imagePath: 'assets/images/exercises/bicep_curl.png',
      ),
      _exerciseWithMeta(
        name: 'Rest and Drink',
        duration: '02:00',
        imagePath: 'assets/images/exercises/dring_water.png',
      ),
    ];

    _set2 = [
      _exerciseWithMeta(
        name: 'Incline Push-Ups',
        duration: '12x',
        imagePath: 'assets/images/exercises/incline_pushup.png',
      ),
      _exerciseWithMeta(
        name: 'Push-Ups',
        duration: '15x',
        imagePath: 'assets/images/exercises/pushup.png',
      ),
      _exerciseWithMeta(
        name: 'Rest and Drink',
        duration: '02:00',
        imagePath: 'assets/images/exercises/dring_water.png',
      ),
    ];

    _set3 = [
      _exerciseWithMeta(
        name: 'Cobra Stretch',
        duration: '00:30',
        imagePath: 'assets/images/exercises/cobra_stretch.png',
      ),
      _exerciseWithMeta(
        name: "Child's Pose",
        duration: '01:00',
        imagePath: 'assets/images/exercises/childs_pose.png',
      ),
    ];
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels > 0) {
      setState(() {
        _headerHeight =
            (_maxHeaderHeight - _scrollController.position.pixels * 0.6).clamp(
              _minHeaderHeight,
              _maxHeaderHeight,
            );
      });
    } else {
      setState(() {
        _headerHeight = _maxHeaderHeight;
      });
    }
  }

  bool get _isHeaderCollapsed => _headerHeight <= _minHeaderHeight + 50;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Adjust header height based on screen size - ensure proper minimum for content
    _maxHeaderHeight = screenHeight * 0.3; // 30% of screen height (increased)
    _minHeaderHeight =
        screenHeight *
        0.15; // 15% of screen height (increased for better readability)

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F4FD), Color(0xFFF8FAFF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildScrollableContent()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildStartWorkoutButton(),
    );
  }

  Widget _buildHeader() {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _headerHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF6B73FF), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Stack(
          children: [
            // Header content with proper overflow handling
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(
                  screenWidth * 0.05,
                ), // Responsive padding
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
                        // Collapsed header title (only shown when collapsed)
                        if (_isHeaderCollapsed)
                          Expanded(
                            child: Center(
                              child: Text(
                                "Fullbody Workout",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        IconButton(
                          onPressed: () {
                            // TODO: Show more options
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    // Logo and card row (hidden when collapsed)
                    if (!_isHeaderCollapsed) ...[
                      SizedBox(
                        height: _headerHeight * 0.02,
                      ), // Increased spacing
                      Expanded(
                        child: Row(
                          children: [
                            // Workout summary card (expanded to full width when logo is hidden)
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: EdgeInsets.all(
                                  _headerHeight * 0.04,
                                ), // Increased padding for better readability
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 15,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // Logo inside the card (properly sized)
                                    if (!_isHeaderCollapsed) ...[
                                      Container(
                                        width:
                                            _headerHeight * 0.15, // Larger logo
                                        height:
                                            _headerHeight * 0.15, // Larger logo
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF6B73FF,
                                          ).withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.fitness_center,
                                          color: const Color(0xFF6B73FF),
                                          size:
                                              _headerHeight *
                                              0.08, // Larger icon
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ), // Increased spacing
                                    ],
                                    // Card content
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Fullbody Workout",
                                            style: GoogleFonts.poppins(
                                              fontSize:
                                                  _headerHeight *
                                                  0.06, // Larger font size for readability
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ), // Increased spacing
                                          Text(
                                            "11 Exercises | 32mins | 320 Calories Burn",
                                            style: GoogleFonts.poppins(
                                              fontSize:
                                                  _headerHeight *
                                                  0.045, // Larger font size for readability
                                              color: Colors.grey.shade600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
                                        size:
                                            _headerHeight *
                                            0.07, // Larger icon size
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
    );
  }

  Widget _buildScrollableContent() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.05, // Responsive left padding
        20, // Fixed top padding to prevent overlap
        MediaQuery.of(context).size.width * 0.05, // Responsive right padding
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
          const SizedBox(height: 100), // Space for bottom button
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
        color: const Color(0xFF6B73FF).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF6B73FF).withValues(alpha: 0.2),
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
                color: const Color(0xFF6B73FF).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF6B73FF), size: 20),
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
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildEquipmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "You'll Need",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              "6 items",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildEquipmentCard("Barbell", EquipmentIcons.getIconPath("Barbell")),
              const SizedBox(width: 12),
              _buildEquipmentCard(
                "Skipping Rope",
                EquipmentIcons.getIconPath("Skipping Rope"),
              ),
              const SizedBox(width: 12),
              _buildEquipmentCard(
                "Bottle 1 Litre",
                EquipmentIcons.getIconPath("Bottle 1 Litre"),
              ),
              const SizedBox(width: 12),
              _buildEquipmentCard(
                "Dumbbells",
                EquipmentIcons.getIconPath("Dumbbells"),
              ),
              const SizedBox(width: 12),
              _buildEquipmentCard(
                "Yoga Mat",
                EquipmentIcons.getIconPath("Yoga Mat"),
              ),
              const SizedBox(width: 12),
              _buildEquipmentCard("Timer", EquipmentIcons.getIconPath("Timer")),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEquipmentCard(String name, String iconPath) {
    return Container(
      width: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Color(0xFF6B73FF),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Exercises",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              "3 Sets",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildExerciseSet("Set 1", _set1),
        const SizedBox(height: 20),
        _buildExerciseSet("Set 2", _set2),
        const SizedBox(height: 20),
        _buildExerciseSet("Set 3", _set3),
      ],
    );
  }

  Widget _buildExerciseSet(String setTitle, List<ExerciseData> exercises) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          setTitle,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6B73FF),
          ),
        ),
        const SizedBox(height: 12),
        ...exercises.map((exercise) => _buildExerciseItem(exercise)),
      ],
    );
  }

  Widget _buildExerciseItem(ExerciseData exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
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
              color: const Color(0xFF6B73FF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: exercise.imagePath.endsWith('.svg')
                  ? SvgPicture.asset(
                      exercise.imagePath,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF6B73FF),
                        BlendMode.srcIn,
                      ),
                    )
                  : Image.asset(
                      exercise.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          SvgPicture.asset(
                            'assets/icons/fitness_center.svg',
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF6B73FF),
                              BlendMode.srcIn,
                            ),
                          ),
                    ),
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
                    color: const Color(0xFF6B73FF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              // Merge metadata from master list if this inline item lacks it
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
                    themeColor: const Color(0xFF6B73FF),
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
            color: Colors.black.withValues(alpha: 0.1),
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
              colors: [Color(0xFF6B73FF), Color(0xFF8B5CF6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6B73FF).withValues(alpha: 0.3),
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
                // TODO: Navigate to workout session
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Starting Fullbody Workout!'),
                    backgroundColor: const Color(0xFF6B73FF),
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
  String difficulty = "Easy";

  ExerciseData(this.name, this.duration, this.imagePath);
}
