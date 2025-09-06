import '../activity_tracker/activity_tracker_screen.dart';
import '../../widgets/circular_progress_indicator.dart';
import '../../widgets/staggered_animation_widget.dart';
import '../../widgets/calories_progress_widget.dart';
import '../notification/notification_screen.dart';
import '../../widgets/sleep_pattern_widget.dart';
import '../../widgets/workout_item_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/water_intake_widget.dart';
import '../workout/workout_tracker_screen.dart';
import '../../widgets/line_chart_widget.dart';
import '../../widgets/bottom_navigation.dart';
import '../../utils/responsive_utils.dart';
import '../workout/workout_screen.dart';
import '../profile/profile_screen.dart';
import 'package:flutter/material.dart';
import '../sleep/sleep_screen.dart';
import '../meal/meal_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const HomeTab(),
    const WorkoutScreen(),
    const MealScreen(),
    const SleepScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
      // Removed floating action button to prevent overlap with bottom navigation search icon
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Time period selection
  String _selectedPeriod = "Weekly";
  final List<String> _periods = ["Daily", "Weekly", "Monthly"];
  int _currentPeriodIndex = 1; // Start with Weekly

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFF), Color(0xFFF0F4FF), Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              100,
            ), // Added bottom padding for bottom navigation
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StaggeredAnimationWidget(
                      index: 0,
                      child: _buildHeader(context),
                    ),
                    const SizedBox(height: 24),
                    StaggeredAnimationWidget(index: 1, child: _buildBMICard()),
                    const SizedBox(height: 24),
                    StaggeredAnimationWidget(
                      index: 2,
                      child: _buildTodayTargetCard(),
                    ),
                    const SizedBox(height: 24),
                    StaggeredAnimationWidget(
                      index: 3,
                      child: _buildActivityStatus(),
                    ),
                    const SizedBox(height: 24),
                    StaggeredAnimationWidget(
                      index: 4,
                      child: _buildWorkoutProgress(),
                    ),
                    const SizedBox(height: 24),
                    StaggeredAnimationWidget(
                      index: 5,
                      child: _buildLatestWorkout(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back,",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              "Stefani Wong",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.notifications_outlined),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBMICard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B73FF), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B73FF).withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BMI (Body Mass Index)",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "You have a normal weight",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to BMI details
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6B73FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "View More",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          CustomCircularProgressIndicator(
            progress: 0.67, // 20.1 / 30 (normal BMI range)
            size: 80,
            color: Colors.white,
            backgroundColor: Colors.white,
            strokeWidth: 6,
            child: Text(
              "20.1",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayTargetCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today Target",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "You have 3 targets to complete",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildTargetProgress(0.8, "Workout"),
                    const SizedBox(width: 12),
                    _buildTargetProgress(0.6, "Water"),
                    const SizedBox(width: 12),
                    _buildTargetProgress(0.4, "Sleep"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ActivityTrackerScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF10B981),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text(
              "Check",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetProgress(double progress, String label) {
    return Column(
      children: [
        CustomCircularProgressIndicator(
          progress: progress,
          size: 40,
          color: Colors.white,
          backgroundColor: Colors.white,
          strokeWidth: 3,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Activity Status",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildHeartRateCard()),
            const SizedBox(width: 12),
            Expanded(
              child: WaterIntakeWidget(
                currentIntake: 4.0,
                targetIntake: 8.0,
                updates: [
                  WaterIntakeUpdate(timeRange: "6am - 8am", amount: 700),
                  WaterIntakeUpdate(timeRange: "4pm - now", amount: 1100),
                  WaterIntakeUpdate(timeRange: "2pm - 4pm", amount: 500),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SleepPatternWidget(
                sleepDuration: "8h 20m",
                sleepPattern: [0.2, 0.4, 0.6, 0.8, 0.9, 0.7, 0.5, 0.3, 0.1],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CaloriesProgressWidget(
                currentCalories: 760,
                targetCalories: 1010,
                remainingCalories: 250,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeartRateCard() {
    return Builder(
      builder: (context) {
        final cardHeight = ResponsiveUtils.getCardHeight(context, 120);
        final padding = ResponsiveUtils.getResponsivePadding(
          context,
          const EdgeInsets.all(12),
        );

        return Container(
          height: cardHeight,
          padding: padding,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: const Color(0xFF6B73FF),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "Heart Rate",
                      style: GoogleFonts.poppins(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(
                          context,
                          14,
                        ),
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "78 BPM",
                            style: GoogleFonts.poppins(
                              fontSize: ResponsiveUtils.getResponsiveFontSize(
                                context,
                                16,
                              ),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6B73FF),
                            ),
                          ),
                          SizedBox(
                            height: ResponsiveUtils.getResponsiveSize(
                              context,
                              4,
                            ),
                          ),
                          Text(
                            "Heart rate",
                            style: GoogleFonts.poppins(
                              fontSize: ResponsiveUtils.getResponsiveFontSize(
                                context,
                                10,
                              ),
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: ResponsiveUtils.getResponsiveSize(context, 12),
                    ),
                    SizedBox(
                      width: ResponsiveUtils.getResponsiveSize(context, 60),
                      height: ResponsiveUtils.getResponsiveSize(context, 30),
                      child: LineChartWidget(
                        data: [65, 70, 75, 78, 82, 79, 76, 73, 70, 68],
                        height: ResponsiveUtils.getResponsiveSize(context, 30),
                        showGrid: false,
                        showPoints: false,
                        highlightIndex: 3,
                        highlightLabel: "3mins ago",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWorkoutProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Workout Progress",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            _buildTimeSelector(),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 200, // Increased height for better graph display
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Progress",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "0% - 100%",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LineChartWidget(
                  data: [20, 35, 45, 60, 75, 85, 30],
                  height: 140, // Increased height for better visibility
                  showGrid: true,
                  showPoints: true,
                  highlightIndex: 5,
                  highlightLabel: "Fri, 28 May\nUpperbody Workout\n90% ↑",
                  lineColor: const Color(0xFF6B73FF),
                  fillColor: const Color(0xFF6B73FF),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSelector() {
    return GestureDetector(
      onTap: () {
        _showTimeSelectorDialog();
      },
      onPanUpdate: (details) {
        // Handle swipe gestures
        if (details.delta.dy < -5) {
          // Swipe up - cycle to next period
          _cyclePeriod(1);
        } else if (details.delta.dy > 5) {
          // Swipe down - cycle to previous period
          _cyclePeriod(-1);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6B73FF), Color(0xFF8B5CF6)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6B73FF).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedPeriod,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _cyclePeriod(int direction) {
    setState(() {
      _currentPeriodIndex = (_currentPeriodIndex + direction) % _periods.length;
      if (_currentPeriodIndex < 0) {
        _currentPeriodIndex = _periods.length - 1;
      }
      _selectedPeriod = _periods[_currentPeriodIndex];
    });

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Switched to $_selectedPeriod view'),
        backgroundColor: const Color(0xFF6B73FF),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _showTimeSelectorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Select Time Period',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTimeOption('Daily', Icons.today, 'View daily progress'),
              const SizedBox(height: 12),
              _buildTimeOption(
                'Weekly',
                Icons.calendar_view_week,
                'View weekly progress',
              ),
              const SizedBox(height: 12),
              _buildTimeOption(
                'Monthly',
                Icons.calendar_month,
                'View monthly progress',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeOption(String title, IconData icon, String description) {
    final isSelected = _selectedPeriod == title;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPeriod = title;
          _currentPeriodIndex = _periods.indexOf(title);
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Switched to $title view'),
            backgroundColor: const Color(0xFF6B73FF),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6B73FF).withOpacity(0.1)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF6B73FF) : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6B73FF).withOpacity(0.2)
                    : const Color(0xFF6B73FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? const Color(0xFF6B73FF)
                    : const Color(0xFF6B73FF).withOpacity(0.7),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF6B73FF)
                          : Colors.black87,
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: isSelected
                          ? const Color(0xFF6B73FF).withOpacity(0.8)
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF6B73FF), size: 20)
            else
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestWorkout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Latest Workout",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkoutTrackerScreen(),
                  ),
                );
              },
              child: Text(
                "See more",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6B73FF),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        WorkoutItemWidget(
          title: "Fullbody Workout",
          subtitle: "180 Calories Burn | 20 minutes",
          icon: WorkoutType.types['fullbody']!['icon'] as IconData,
          iconColor: WorkoutType.types['fullbody']!['color'] as Color,
          onTap: () {
            // TODO: Navigate to workout details
          },
        ),
        WorkoutItemWidget(
          title: "Lowerbody Workout",
          subtitle: "200 Calories Burn | 30 minutes",
          icon: WorkoutType.types['lowerbody']!['icon'] as IconData,
          iconColor: WorkoutType.types['lowerbody']!['color'] as Color,
          onTap: () {
            // TODO: Navigate to workout details
          },
        ),
        WorkoutItemWidget(
          title: "Ab Workout",
          subtitle: "150 Calories Burn | 15 minutes",
          icon: WorkoutType.types['ab']!['icon'] as IconData,
          iconColor: WorkoutType.types['ab']!['color'] as Color,
          onTap: () {
            // TODO: Navigate to workout details
          },
        ),
      ],
    );
  }
}
