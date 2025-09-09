import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _achievements = [
    {
      'title': 'First Workout',
      'description': 'Complete your first workout',
      'icon': Icons.fitness_center,
      'color': const Color(0xFF6B73FF),
      'isUnlocked': true,
      'unlockedDate': '2024-01-15',
      'category': 'Workout',
    },
    {
      'title': 'Week Warrior',
      'description': 'Complete 7 workouts in a week',
      'icon': Icons.calendar_today,
      'color': const Color(0xFF8B5CF6),
      'isUnlocked': true,
      'unlockedDate': '2024-01-22',
      'category': 'Workout',
    },
    {
      'title': 'Meal Master',
      'description': 'Log meals for 30 consecutive days',
      'icon': Icons.restaurant,
      'color': const Color(0xFF10B981),
      'isUnlocked': true,
      'unlockedDate': '2024-02-01',
      'category': 'Nutrition',
    },
    {
      'title': 'Sleep Champion',
      'description': 'Maintain 8+ hours sleep for 2 weeks',
      'icon': Icons.bedtime,
      'color': const Color(0xFFF59E0B),
      'isUnlocked': false,
      'unlockedDate': null,
      'category': 'Sleep',
    },
    {
      'title': 'Hydration Hero',
      'description': 'Drink 8 glasses of water daily for a month',
      'icon': Icons.water_drop,
      'color': const Color(0xFF3B82F6),
      'isUnlocked': false,
      'unlockedDate': null,
      'category': 'Health',
    },
    {
      'title': 'Consistency King',
      'description': 'Use the app for 100 days',
      'icon': Icons.trending_up,
      'color': const Color(0xFFEF4444),
      'isUnlocked': false,
      'unlockedDate': null,
      'category': 'General',
    },
    {
      'title': 'Strength Builder',
      'description': 'Increase your bench press by 20%',
      'icon': Icons.sports_gymnastics,
      'color': const Color(0xFF8B5CF6),
      'isUnlocked': true,
      'unlockedDate': '2024-01-30',
      'category': 'Workout',
    },
    {
      'title': 'Cardio Crusher',
      'description': 'Run 50 miles in a month',
      'icon': Icons.directions_run,
      'color': const Color(0xFF10B981),
      'isUnlocked': false,
      'unlockedDate': null,
      'category': 'Workout',
    },
  ];

  List<String> get _categories => [
    'All',
    'Workout',
    'Nutrition',
    'Sleep',
    'Health',
    'General',
  ];

  List<Map<String, dynamic>> get _filteredAchievements {
    if (_selectedFilter == 'All') {
      return _achievements;
    }
    return _achievements
        .where((achievement) => achievement['category'] == _selectedFilter)
        .toList();
  }

  int get _unlockedCount =>
      _achievements.where((achievement) => achievement['isUnlocked']).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Achievements',
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
          // Progress Overview
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
                  'Achievement Progress',
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
                    Column(
                      children: [
                        Text(
                          '$_unlockedCount',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Unlocked',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${_achievements.length - _unlockedCount}',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          'Locked',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${(_unlockedCount / _achievements.length * 100).round()}%',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Complete',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: _unlockedCount / _achievements.length,
                  backgroundColor: Colors.white30,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 8,
                ),
              ],
            ),
          ),

          // Filter Chips
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedFilter == category;

                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(
                      category,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = category;
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

          // Achievements List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredAchievements.length,
              itemBuilder: (context, index) {
                final achievement = _filteredAchievements[index];
                return _buildAchievementCard(achievement);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
    final isUnlocked = achievement['isUnlocked'] as bool;
    final color = achievement['color'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked ? color.withOpacity(0.3) : Colors.grey.shade200,
          width: isUnlocked ? 2 : 1,
        ),
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
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isUnlocked ? color.withOpacity(0.1) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              achievement['icon'] as IconData,
              color: isUnlocked ? color : Colors.grey.shade400,
              size: 30,
            ),
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        achievement['title'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isUnlocked
                              ? Colors.black87
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                    if (isUnlocked)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'UNLOCKED',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  achievement['description'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: isUnlocked
                        ? Colors.grey.shade600
                        : Colors.grey.shade400,
                  ),
                ),
                if (isUnlocked && achievement['unlockedDate'] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Unlocked on ${achievement['unlockedDate']}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
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
