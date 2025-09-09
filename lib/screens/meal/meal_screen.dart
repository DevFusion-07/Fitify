import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/line_chart_widget.dart';
import '../../widgets/common_widgets.dart';
import '../../utils/app_constants.dart';
import 'breakfast_screen.dart';
import 'lunch_screen.dart';
import 'dinner_screen.dart';
import 'meal_schedule_screen.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  String _mealFilter = AppData.mealFilters[0];
  String _period = AppData.periods[1]; // Weekly

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              AppSpacing.gapSm,
              _buildNutritionCard(),
              AppSpacing.gapLg,
              _buildDailyMealSchedule(),
              AppSpacing.gapLg,
              _buildTodayMeals(),
              AppSpacing.gapLg,
              _buildFindSomethingToEat(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'Meal Planner',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: AppRadius.imageRadius,
          ),
          child: const Icon(Icons.more_horiz, color: Colors.black87, size: 18),
        ),
      ],
    );
  }

  Widget _buildNutritionCard() {
    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Meal Nutritions',
            trailing: PillButton(
              label: _period,
              onTap: () => _showPeriodPicker(),
            ),
          ),
          AppSpacing.gapMd,
          SizedBox(
            height: AppDimensions.chartHeight,
            child: LineChartWidget(
              data: AppData.sampleChartData,
              height: AppDimensions.chartHeight,
              showGrid: true,
              showPoints: false,
              highlightIndex: 4,
              highlightLabel: 'Thu',
              lineColor: AppColors.primary,
              fillColor: AppColors.primary,
            ),
          ),
          AppSpacing.gapSm,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                StatWidget(
                  label: 'Calories',
                  value: AppData.stats['Calories']!['value'],
                  color: AppData.stats['Calories']!['color'],
                ),
                AppSpacing.gapMd,
                StatWidget(
                  label: 'Fibre',
                  value: AppData.stats['Fibre']!['value'],
                  color: AppData.stats['Fibre']!['color'],
                ),
                AppSpacing.gapMd,
                StatWidget(
                  label: 'Sugar',
                  value: AppData.stats['Sugar']!['value'],
                  color: AppData.stats['Sugar']!['color'],
                ),
                AppSpacing.gapMd,
                StatWidget(
                  label: 'Fats',
                  value: AppData.stats['Fats']!['value'],
                  color: AppData.stats['Fats']!['color'],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyMealSchedule() {
    return CommonCard(
      backgroundColor: AppColors.surface,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Daily Meal Schedule',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
          CommonButton(
            text: 'Check',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MealScheduleScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTodayMeals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Today Meals',
          trailing: PillButton(
            label: _mealFilter,
            onTap: _showMealFilterPicker,
            trailing: const Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
        AppSpacing.gapMd,
        ItemTile(
          title: 'Salmon Nigiri',
          subtitle: 'Today | 7am',
          imagePath: 'assets/images/meal/salmon_nigiri.png',
          imageBackgroundColor: const Color(0xFFFFEDD5),
          trailingIcon: Icons.notifications_none,
        ),
        AppSpacing.gapMd,
        ItemTile(
          title: 'Lowfat Milk',
          subtitle: 'Today | 8am',
          imagePath: 'assets/images/meal/low_fat_milk.png',
          imageBackgroundColor: const Color(0xFFFFF7ED),
          trailingIcon: Icons.notifications_off_outlined,
        ),
      ],
    );
  }

  Widget _buildFindSomethingToEat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Find Something to Eat',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        AppSpacing.gapXxxl,
        SizedBox(
          height: AppDimensions.containerHeight,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ImageCard(
                title: AppData.mealCards['Breakfast']!['title'],
                subtitle: AppData.mealCards['Breakfast']!['subtitle'],
                imagePath: AppData.mealCards['Breakfast']!['imagePath'],
                backgroundColor:
                    AppData.mealCards['Breakfast']!['backgroundColor'],
                buttonColor: AppData.mealCards['Breakfast']!['buttonColor'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BreakfastScreen(),
                    ),
                  );
                },
              ),
              SizedBox(width: AppDimensions.cardSpacing),
              ImageCard(
                title: AppData.mealCards['Lunch']!['title'],
                subtitle: AppData.mealCards['Lunch']!['subtitle'],
                imagePath: AppData.mealCards['Lunch']!['imagePath'],
                backgroundColor: AppData.mealCards['Lunch']!['backgroundColor'],
                buttonColor: AppData.mealCards['Lunch']!['buttonColor'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LunchScreen(),
                    ),
                  );
                },
              ),
              SizedBox(width: AppDimensions.cardSpacing),
              ImageCard(
                title: AppData.mealCards['Dinner']!['title'],
                subtitle: AppData.mealCards['Dinner']!['subtitle'],
                imagePath: AppData.mealCards['Dinner']!['imagePath'],
                backgroundColor:
                    AppData.mealCards['Dinner']!['backgroundColor'],
                buttonColor: AppData.mealCards['Dinner']!['buttonColor'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DinnerScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showMealFilterPicker() {
    CommonModalBottomSheet.show(
      context: context,
      title: 'Filter Meals',
      options: AppData.mealFilters,
      selectedOption: _mealFilter,
      onOptionSelected: (option) {
        setState(() => _mealFilter = option);
      },
    );
  }

  void _showPeriodPicker() {
    CommonModalBottomSheet.show(
      context: context,
      title: 'Select Period',
      options: AppData.periods,
      selectedOption: _period,
      onOptionSelected: (option) {
        setState(() => _period = option);
      },
    );
  }
}
