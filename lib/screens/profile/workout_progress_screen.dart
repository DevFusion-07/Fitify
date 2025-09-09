import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/common_widgets.dart';

class WorkoutProgressScreen extends StatefulWidget {
  const WorkoutProgressScreen({super.key});

  @override
  State<WorkoutProgressScreen> createState() => _WorkoutProgressScreenState();
}

class _WorkoutProgressScreenState extends State<WorkoutProgressScreen> {
  String _selectedTimeRange = 'Week';

  final List<Map<String, dynamic>> _workoutData = [
    {
      'date': DateTime.now().subtract(const Duration(days: 6)),
      'workouts': 1,
      'duration': 45,
      'calories': 320,
      'type': 'Fullbody',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'workouts': 0,
      'duration': 0,
      'calories': 0,
      'type': 'Rest',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'workouts': 1,
      'duration': 30,
      'calories': 280,
      'type': 'Cardio',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'workouts': 1,
      'duration': 35,
      'calories': 290,
      'type': 'Lowerbody',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'workouts': 0,
      'duration': 0,
      'calories': 0,
      'type': 'Rest',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'workouts': 1,
      'duration': 20,
      'calories': 150,
      'type': 'Ab',
    },
    {
      'date': DateTime.now(),
      'workouts': 1,
      'duration': 40,
      'calories': 310,
      'type': 'Upperbody',
    },
  ];

  final List<Map<String, dynamic>> _strengthProgress = [
    {
      'exercise': 'Bench Press',
      'current': 135,
      'previous': 125,
      'unit': 'lbs',
      'improvement': 8.0,
    },
    {
      'exercise': 'Squat',
      'current': 185,
      'previous': 175,
      'unit': 'lbs',
      'improvement': 5.7,
    },
    {
      'exercise': 'Deadlift',
      'current': 225,
      'previous': 210,
      'unit': 'lbs',
      'improvement': 7.1,
    },
    {
      'exercise': 'Overhead Press',
      'current': 95,
      'previous': 90,
      'unit': 'lbs',
      'improvement': 5.6,
    },
  ];

  List<String> get _timeRanges => ['Week', 'Month', 'Year'];

  Map<String, dynamic> get _weeklyStats {
    final weekData = _workoutData.where((data) {
      final now = DateTime.now();
      return now.difference(data['date'] as DateTime).inDays <= 7;
    }).toList();

    int totalWorkouts = weekData.fold(
      0,
      (sum, data) => sum + (data['workouts'] as int),
    );
    int totalDuration = weekData.fold(
      0,
      (sum, data) => sum + (data['duration'] as int),
    );
    int totalCalories = weekData.fold(
      0,
      (sum, data) => sum + (data['calories'] as int),
    );
    int activeDays = weekData.where((data) => data['workouts'] > 0).length;

    return {
      'totalWorkouts': totalWorkouts,
      'totalDuration': totalDuration,
      'totalCalories': totalCalories,
      'activeDays': activeDays,
    };
  }

  @override
  Widget build(BuildContext context) {
    final stats = _weeklyStats;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Workout Progress',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Time Range Filter
            Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                children: _timeRanges.map((range) {
                  final isSelected = _selectedTimeRange == range;
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedTimeRange = range;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected
                              ? const Color(0xFF6B73FF)
                              : Colors.white,
                          foregroundColor: isSelected
                              ? Colors.white
                              : Colors.grey.shade600,
                          elevation: isSelected ? 2 : 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: isSelected
                                  ? const Color(0xFF6B73FF)
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                        child: Text(
                          range,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Weekly Stats Overview
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B73FF), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    'This Week\'s Progress',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        '${stats['totalWorkouts']}',
                        'Workouts',
                        Icons.fitness_center,
                      ),
                      _buildStatItem(
                        '${stats['totalDuration']}m',
                        'Duration',
                        Icons.access_time,
                      ),
                      _buildStatItem(
                        '${stats['totalCalories']}',
                        'Calories',
                        Icons.local_fire_department,
                      ),
                      _buildStatItem(
                        '${stats['activeDays']}',
                        'Active Days',
                        Icons.calendar_today,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Workout Calendar
            CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Workout Calendar',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildWorkoutCalendar(),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Strength Progress
            CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Strength Progress',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._strengthProgress.map(
                    (exercise) => _buildStrengthProgressItem(exercise),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Recent Workouts
            CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Workouts',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._workoutData
                      .where((data) => data['workouts'] > 0)
                      .take(5)
                      .map((workout) => _buildRecentWorkoutItem(workout)),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildWorkoutCalendar() {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
        ),
        itemCount: 7,
        itemBuilder: (context, index) {
          final data = _workoutData[index];
          final date = data['date'] as DateTime;
          final hasWorkout = data['workouts'] > 0;

          return Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: hasWorkout
                  ? const Color(0xFF6B73FF)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getDayName(date.weekday),
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: hasWorkout ? Colors.white : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${date.day}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: hasWorkout ? Colors.white : Colors.black87,
                  ),
                ),
                if (hasWorkout)
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return days[weekday - 1];
  }

  Widget _buildStrengthProgressItem(Map<String, dynamic> exercise) {
    final improvement = exercise['improvement'] as double;
    final isPositive = improvement > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise['exercise'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${exercise['current']} ${exercise['unit']} (was ${exercise['previous']} ${exercise['unit']})',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isPositive ? Colors.green.shade100 : Colors.red.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  size: 16,
                  color: isPositive ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  '${improvement.toStringAsFixed(1)}%',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentWorkoutItem(Map<String, dynamic> workout) {
    final date = workout['date'] as DateTime;
    final type = workout['type'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF6B73FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.fitness_center,
              color: Color(0xFF6B73FF),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$type Workout',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '${workout['duration']} min • ${workout['calories']} cal',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatDate(date),
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else {
      return '${difference}d ago';
    }
  }
}
