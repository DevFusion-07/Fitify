import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/common_widgets.dart';

class MealPlannersScreen extends StatefulWidget {
  const MealPlannersScreen({super.key});

  @override
  State<MealPlannersScreen> createState() => _MealPlannersScreenState();
}

class _MealPlannersScreenState extends State<MealPlannersScreen> {
  String _selectedMealType = 'All';
  String _selectedDiet = 'All';

  final List<Map<String, dynamic>> _mealPlans = [
    {
      'name': 'Weight Loss Plan',
      'description': 'Low calorie, high protein meals for weight loss',
      'calories': 1500,
      'duration': '4 weeks',
      'difficulty': 'Easy',
      'meals': ['Breakfast', 'Lunch', 'Dinner', 'Snacks'],
      'type': 'Weight Loss',
      'diet': 'Balanced',
      'image': 'assets/images/meal/weight_loss_plan.jpg',
    },
    {
      'name': 'Muscle Building Plan',
      'description': 'High protein meals to support muscle growth',
      'calories': 2500,
      'duration': '8 weeks',
      'difficulty': 'Medium',
      'meals': ['Breakfast', 'Lunch', 'Dinner', 'Pre-Workout', 'Post-Workout'],
      'type': 'Muscle Building',
      'diet': 'High Protein',
      'image': 'assets/images/meal/muscle_building_plan.jpg',
    },
    {
      'name': 'Keto Diet Plan',
      'description': 'Low carb, high fat ketogenic meal plan',
      'calories': 1800,
      'duration': '6 weeks',
      'difficulty': 'Hard',
      'meals': ['Breakfast', 'Lunch', 'Dinner'],
      'type': 'Weight Loss',
      'diet': 'Keto',
      'image': 'assets/images/meal/keto_plan.jpg',
    },
    {
      'name': 'Vegetarian Plan',
      'description': 'Plant-based meals for vegetarians',
      'calories': 2000,
      'duration': '4 weeks',
      'difficulty': 'Easy',
      'meals': ['Breakfast', 'Lunch', 'Dinner', 'Snacks'],
      'type': 'Maintenance',
      'diet': 'Vegetarian',
      'image': 'assets/images/meal/vegetarian_plan.jpg',
    },
    {
      'name': 'Mediterranean Plan',
      'description': 'Heart-healthy Mediterranean diet',
      'calories': 2200,
      'duration': '12 weeks',
      'difficulty': 'Easy',
      'meals': ['Breakfast', 'Lunch', 'Dinner', 'Snacks'],
      'type': 'Health',
      'diet': 'Mediterranean',
      'image': 'assets/images/meal/mediterranean_plan.jpg',
    },
    {
      'name': 'Intermittent Fasting',
      'description': '16:8 fasting with nutrient-dense meals',
      'calories': 1800,
      'duration': '8 weeks',
      'difficulty': 'Medium',
      'meals': ['Lunch', 'Dinner'],
      'type': 'Weight Loss',
      'diet': 'Intermittent Fasting',
      'image': 'assets/images/meal/intermittent_fasting.jpg',
    },
  ];

  final List<String> _mealTypes = [
    'All',
    'Weight Loss',
    'Muscle Building',
    'Maintenance',
    'Health',
  ];
  final List<String> _diets = [
    'All',
    'Balanced',
    'High Protein',
    'Keto',
    'Vegetarian',
    'Mediterranean',
    'Intermittent Fasting',
  ];

  List<Map<String, dynamic>> get _filteredPlans {
    List<Map<String, dynamic>> filtered = _mealPlans;

    if (_selectedMealType != 'All') {
      filtered = filtered
          .where((plan) => plan['type'] == _selectedMealType)
          .toList();
    }

    if (_selectedDiet != 'All') {
      filtered = filtered
          .where((plan) => plan['diet'] == _selectedDiet)
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Meal Planners',
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
          // Filters
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Meal Type Filter
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _mealTypes.length,
                    itemBuilder: (context, index) {
                      final type = _mealTypes[index];
                      final isSelected = _selectedMealType == type;

                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: FilterChip(
                          label: Text(
                            type,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade600,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedMealType = type;
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

                const SizedBox(height: 12),

                // Diet Filter
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _diets.length,
                    itemBuilder: (context, index) {
                      final diet = _diets[index];
                      final isSelected = _selectedDiet == diet;

                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: FilterChip(
                          label: Text(
                            diet,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade600,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedDiet = diet;
                            });
                          },
                          backgroundColor: Colors.white,
                          selectedColor: const Color(0xFF10B981),
                          checkmarkColor: Colors.white,
                          side: BorderSide(
                            color: isSelected
                                ? const Color(0xFF10B981)
                                : Colors.grey.shade300,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Meal Plans List
          Expanded(
            child: _filteredPlans.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant_menu,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No meal plans found',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your filters',
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
                    itemCount: _filteredPlans.length,
                    itemBuilder: (context, index) {
                      final plan = _filteredPlans[index];
                      return _buildMealPlanCard(plan);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealPlanCard(Map<String, dynamic> plan) {
    final difficulty = plan['difficulty'] as String;
    final difficultyColor = _getDifficultyColor(difficulty);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // Image
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6B73FF).withOpacity(0.8),
                  const Color(0xFF8B5CF6).withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.restaurant,
                    size: 64,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: difficultyColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      difficulty,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan['name'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  plan['description'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16),

                // Stats
                Row(
                  children: [
                    _buildStatChip(
                      Icons.local_fire_department,
                      '${plan['calories']} cal',
                      const Color(0xFFEF4444),
                    ),
                    const SizedBox(width: 8),
                    _buildStatChip(
                      Icons.schedule,
                      plan['duration'] as String,
                      const Color(0xFF6B73FF),
                    ),
                    const SizedBox(width: 8),
                    _buildStatChip(
                      Icons.restaurant,
                      '${(plan['meals'] as List).length} meals',
                      const Color(0xFF10B981),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Meals
                Text(
                  'Included Meals:',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (plan['meals'] as List).map((meal) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6B73FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF6B73FF).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        meal as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF6B73FF),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: CommonButton(
                    text: 'Start This Plan',
                    onPressed: () {
                      _showPlanDetails(plan);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showPlanDetails(Map<String, dynamic> plan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan['name'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      plan['description'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Plan Details
                    _buildDetailItem(
                      'Calories per day',
                      '${plan['calories']} cal',
                    ),
                    _buildDetailItem('Duration', plan['duration'] as String),
                    _buildDetailItem(
                      'Difficulty',
                      plan['difficulty'] as String,
                    ),
                    _buildDetailItem('Diet Type', plan['diet'] as String),

                    const SizedBox(height: 24),

                    // Meals List
                    Text(
                      'Included Meals',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...(plan['meals'] as List).map(
                      (meal) => _buildMealItem(meal as String),
                    ),

                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(color: Color(0xFF6B73FF)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Learn More',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF6B73FF),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CommonButton(
                            text: 'Start Plan',
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Started ${plan['name']} plan!',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B73FF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealItem(String meal) {
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
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF6B73FF),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            meal,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
