import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_constants.dart';

class MealScheduleScreen extends StatefulWidget {
  const MealScheduleScreen({super.key});

  @override
  State<MealScheduleScreen> createState() => _MealScheduleScreenState();
}

class _MealScheduleScreenState extends State<MealScheduleScreen> {
  DateTime _selectedDate = DateTime.now();
  int _selectedDayIndex = 4; // Friday is selected by default

  final List<String> _days = ['Wed 12', 'Thu 13', 'Fri 14', 'Sat 15', 'Sun 16'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildDateNavigation(),
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMealSection(
                      'Breakfast',
                      '2 meals | 230 calories',
                      _getBreakfastMeals(),
                    ),
                    AppSpacing.gapXxl,
                    _buildMealSection(
                      'Lunch',
                      '2 meals | 500 calories',
                      _getLunchMeals(),
                    ),
                    AppSpacing.gapXxl,
                    _buildMealSection(
                      'Snacks',
                      '2 meals | 140 calories',
                      _getSnackMeals(),
                    ),
                    AppSpacing.gapXxl,
                    _buildMealSection(
                      'Dinner',
                      '2 meals | 120 calories',
                      _getDinnerMeals(),
                    ),
                    AppSpacing.gapXxl,
                    _buildNutritionSection(),
                    const SizedBox(height: 100), // Space for FAB
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black87,
                size: 18,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Meal Schedule',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.more_horiz,
              color: Colors.black87,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          // Month/Year navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = DateTime(
                      _selectedDate.year,
                      _selectedDate.month - 1,
                    );
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black87,
                    size: 16,
                  ),
                ),
              ),
              Text(
                'May 2021',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = DateTime(
                      _selectedDate.year,
                      _selectedDate.month + 1,
                    );
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black87,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Day cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _days.asMap().entries.map((entry) {
                int index = entry.key;
                String day = entry.value;
                bool isSelected = index == _selectedDayIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDayIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      right: index < _days.length - 1 ? 12 : 0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      day,
                      style: GoogleFonts.poppins(
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealSection(
    String title,
    String summary,
    List<Map<String, dynamic>> meals,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(height: 4),
        Text(
          summary,
          style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 14),
        ),
        const SizedBox(height: 16),
        ...meals.map((meal) => _buildMealItem(meal)),
      ],
    );
  }

  Widget _buildMealItem(Map<String, dynamic> meal) {
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
              color: meal['backgroundColor'],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                meal['imagePath'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    meal['icon'],
                    color: Colors.grey.shade400,
                    size: 24,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal['name'],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  meal['time'],
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400, size: 16),
        ],
      ),
    );
  }

  Widget _buildNutritionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today Meal Nutritions',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(height: 20),
        _buildNutritionItem(
          'Calories',
          Icons.local_fire_department,
          '200 kCal',
          0.75,
          Colors.red,
        ),
        const SizedBox(height: 16),
        _buildNutritionItem(
          'Proteins',
          Icons.restaurant,
          '300g',
          0.65,
          Colors.orange,
        ),
        const SizedBox(height: 16),
        _buildNutritionItem('Fats', Icons.eco, '150g', 0.55, Colors.yellow),
        const SizedBox(height: 16),
        _buildNutritionItem('Carbs', Icons.grain, '250g', 0.45, Colors.green),
      ],
    );
  }

  Widget _buildNutritionItem(
    String label,
    IconData icon,
    String value,
    double progress,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  // Sample meal data
  List<Map<String, dynamic>> _getBreakfastMeals() {
    return [
      {
        'name': 'Honey Pancake',
        'time': '07:00am',
        'imagePath': 'assets/images/meal/bluebarry_pancake.png',
        'backgroundColor': const Color(0xFFFFEDD5),
        'icon': Icons.restaurant,
      },
      {
        'name': 'Coffee',
        'time': '07:30am',
        'imagePath': 'assets/images/meal/low_fat_milk.png',
        'backgroundColor': const Color(0xFFFFF7ED),
        'icon': Icons.local_cafe,
      },
    ];
  }

  List<Map<String, dynamic>> _getLunchMeals() {
    return [
      {
        'name': 'Chicken Steak',
        'time': '01:00pm',
        'imagePath': 'assets/images/meal/salmon_nigiri.png',
        'backgroundColor': const Color(0xFFE3F2FD),
        'icon': Icons.restaurant,
      },
      {
        'name': 'Milk',
        'time': '01:20pm',
        'imagePath': 'assets/images/meal/low_fat_milk.png',
        'backgroundColor': const Color(0xFFFFF7ED),
        'icon': Icons.local_drink,
      },
    ];
  }

  List<Map<String, dynamic>> _getSnackMeals() {
    return [
      {
        'name': 'Orange',
        'time': '04:30pm',
        'imagePath': 'assets/images/meal/salad.png',
        'backgroundColor': const Color(0xFFFFE8D5),
        'icon': Icons.apple,
      },
      {
        'name': 'Apple Pie',
        'time': '04:40pm',
        'imagePath': 'assets/images/meal/pie.png',
        'backgroundColor': const Color(0xFFD5FFE8),
        'icon': Icons.cake,
      },
    ];
  }

  List<Map<String, dynamic>> _getDinnerMeals() {
    return [
      {
        'name': 'Salad',
        'time': '07:10pm',
        'imagePath': 'assets/images/meal/salad.png',
        'backgroundColor': const Color(0xFFD5FFE8),
        'icon': Icons.restaurant,
      },
      {
        'name': 'Oatmeal',
        'time': '08:10pm',
        'imagePath': 'assets/images/meal/bluebarry_pancake.png',
        'backgroundColor': const Color(0xFFFFEDD5),
        'icon': Icons.restaurant,
      },
    ];
  }
}
