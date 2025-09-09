import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityHistoryScreen extends StatefulWidget {
  const ActivityHistoryScreen({super.key});

  @override
  State<ActivityHistoryScreen> createState() => _ActivityHistoryScreenState();
}

class _ActivityHistoryScreenState extends State<ActivityHistoryScreen> {
  String _selectedFilter = 'All';
  String _selectedTimeRange = 'Week';

  final List<Map<String, dynamic>> _activities = [
    {
      'type': 'Workout',
      'title': 'Fullbody Workout',
      'duration': '45 min',
      'calories': 320,
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'icon': Icons.fitness_center,
      'color': const Color(0xFF6B73FF),
    },
    {
      'type': 'Meal',
      'title': 'Breakfast - Oatmeal',
      'duration': '15 min',
      'calories': 250,
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'icon': Icons.restaurant,
      'color': const Color(0xFF10B981),
    },
    {
      'type': 'Sleep',
      'title': 'Sleep Session',
      'duration': '8h 30m',
      'calories': 0,
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'icon': Icons.bedtime,
      'color': const Color(0xFFF59E0B),
    },
    {
      'type': 'Workout',
      'title': 'Cardio Session',
      'duration': '30 min',
      'calories': 280,
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'icon': Icons.directions_run,
      'color': const Color(0xFF6B73FF),
    },
    {
      'type': 'Meal',
      'title': 'Lunch - Chicken Salad',
      'duration': '20 min',
      'calories': 180,
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'icon': Icons.restaurant,
      'color': const Color(0xFF10B981),
    },
    {
      'type': 'Workout',
      'title': 'Lowerbody Workout',
      'duration': '35 min',
      'calories': 290,
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'icon': Icons.fitness_center,
      'color': const Color(0xFF8B5CF6),
    },
    {
      'type': 'Meal',
      'title': 'Dinner - Salmon',
      'duration': '25 min',
      'calories': 220,
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'icon': Icons.restaurant,
      'color': const Color(0xFF10B981),
    },
    {
      'type': 'Sleep',
      'title': 'Sleep Session',
      'duration': '7h 45m',
      'calories': 0,
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'icon': Icons.bedtime,
      'color': const Color(0xFFF59E0B),
    },
    {
      'type': 'Workout',
      'title': 'Ab Workout',
      'duration': '20 min',
      'calories': 150,
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'icon': Icons.sports_gymnastics,
      'color': const Color(0xFFEF4444),
    },
    {
      'type': 'Meal',
      'title': 'Snack - Protein Shake',
      'duration': '5 min',
      'calories': 120,
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'icon': Icons.local_drink,
      'color': const Color(0xFF3B82F6),
    },
  ];

  List<String> get _filters => ['All', 'Workout', 'Meal', 'Sleep'];
  List<String> get _timeRanges => ['Week', 'Month', 'Year'];

  List<Map<String, dynamic>> get _filteredActivities {
    List<Map<String, dynamic>> filtered = _activities;

    // Filter by type
    if (_selectedFilter != 'All') {
      filtered = filtered
          .where((activity) => activity['type'] == _selectedFilter)
          .toList();
    }

    // Filter by time range
    final now = DateTime.now();
    switch (_selectedTimeRange) {
      case 'Week':
        filtered = filtered.where((activity) {
          final activityDate = activity['date'] as DateTime;
          return now.difference(activityDate).inDays <= 7;
        }).toList();
        break;
      case 'Month':
        filtered = filtered.where((activity) {
          final activityDate = activity['date'] as DateTime;
          return now.difference(activityDate).inDays <= 30;
        }).toList();
        break;
      case 'Year':
        filtered = filtered.where((activity) {
          final activityDate = activity['date'] as DateTime;
          return now.difference(activityDate).inDays <= 365;
        }).toList();
        break;
    }

    // Sort by date (newest first)
    filtered.sort(
      (a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime),
    );

    return filtered;
  }

  Map<String, int> get _activityStats {
    final filtered = _filteredActivities;
    int totalCalories = 0;
    int totalWorkouts = 0;
    int totalMeals = 0;
    int totalSleepHours = 0;

    for (final activity in filtered) {
      totalCalories += activity['calories'] as int;

      switch (activity['type']) {
        case 'Workout':
          totalWorkouts++;
          break;
        case 'Meal':
          totalMeals++;
          break;
        case 'Sleep':
          final duration = activity['duration'] as String;
          final hours = _parseSleepHours(duration);
          totalSleepHours += hours;
          break;
      }
    }

    return {
      'totalCalories': totalCalories,
      'totalWorkouts': totalWorkouts,
      'totalMeals': totalMeals,
      'totalSleepHours': totalSleepHours,
    };
  }

  int _parseSleepHours(String duration) {
    // Parse "8h 30m" format
    final parts = duration.split('h');
    if (parts.length > 1) {
      return int.tryParse(parts[0]) ?? 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final stats = _activityStats;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Activity History',
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
      body: Column(
        children: [
          // Stats Overview
          Container(
            margin: const EdgeInsets.all(20),
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
                  'Activity Summary',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      '${stats['totalCalories']}',
                      'Calories',
                      Icons.local_fire_department,
                    ),
                    _buildStatItem(
                      '${stats['totalWorkouts']}',
                      'Workouts',
                      Icons.fitness_center,
                    ),
                    _buildStatItem(
                      '${stats['totalMeals']}',
                      'Meals',
                      Icons.restaurant,
                    ),
                    _buildStatItem(
                      '${stats['totalSleepHours']}h',
                      'Sleep',
                      Icons.bedtime,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Time Range Filter
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
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

          const SizedBox(height: 16),

          // Type Filter
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;

                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(
                      filter,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFF6B73FF),
                    checkmarkColor: Colors.white,
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF6B73FF)
                          : Colors.grey.shade300,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Activities List
          Expanded(
            child: _filteredActivities.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No activities found',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start tracking your activities to see them here',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredActivities.length,
                    itemBuilder: (context, index) {
                      final activity = _filteredActivities[index];
                      return _buildActivityCard(activity);
                    },
                  ),
          ),
        ],
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
            fontSize: 18,
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

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    final color = activity['color'] as Color;
    final date = activity['date'] as DateTime;

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
          // Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(activity['icon'] as IconData, color: color, size: 24),
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      activity['duration'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    if (activity['calories'] > 0) ...[
                      const SizedBox(width: 16),
                      Icon(
                        Icons.local_fire_department,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${activity['calories']} cal',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatDate(date),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                _formatTime(date),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
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
    } else if (difference < 7) {
      return '${difference}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
