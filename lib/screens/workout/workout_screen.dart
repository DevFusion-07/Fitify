import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fullbody_workout_screen.dart';
import 'lowerbody_workout_screen.dart';
import 'ab_workout_screen.dart';
import '../workout_schedule/workout_schedule_screen.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  // State variables for workout toggles
  bool _isFullbodyActive = true;
  bool _isUpperbodyActive = false;

  // Time period selection (same as home screen)
  String _selectedPeriod = "Weekly";
  final List<String> _periods = ["Daily", "Weekly", "Monthly"];
  int _currentPeriodIndex = 1; // Start with Weekly

  // Scroll controller for flexible header
  final ScrollController _scrollController = ScrollController();
  double _headerHeight = 80.0;
  double _minHeaderHeight = 60.0;
  double _maxHeaderHeight = 80.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
            (_maxHeaderHeight - _scrollController.position.pixels * 0.5).clamp(
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Adjust header height based on screen size
    _maxHeaderHeight = screenHeight * 0.1; // 10% of screen height
    _minHeaderHeight = screenHeight * 0.07; // 7% of screen height

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6B73FF), Color(0xFF8B5CF6)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildWorkoutProgressGraph(),
              Expanded(child: _buildScrollableContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _headerHeight,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: _headerHeight * 0.2,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Workout Tracker",
              style: GoogleFonts.poppins(
                fontSize: _headerHeight * 0.25, // Responsive font size
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Show more options
            },
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: _headerHeight * 0.3, // Responsive icon size
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutProgressGraph() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.25, // 25% of screen height
      padding: EdgeInsets.all(screenWidth * 0.05), // 5% of screen width
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Workout Progress",
                style: GoogleFonts.poppins(
                  fontSize: screenHeight * 0.02, // Responsive font size
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              _buildTimeSelector(),
            ],
          ),
          SizedBox(height: screenHeight * 0.015), // Responsive spacing
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: SizedBox(
                height: screenHeight * 0.15, // Responsive height
                child: CustomPaint(
                  painter: WorkoutChartPainter(),
                  child: SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.15, // Responsive height
                    child: Stack(
                      children: [
                        // Add day labels at the bottom
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:
                                [
                                      'Sun',
                                      'Mon',
                                      'Tue',
                                      'Wed',
                                      'Thu',
                                      'Fri',
                                      'Sat',
                                    ]
                                    .map(
                                      (day) => Text(
                                        day,
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                        // Highlight label for Friday
                        Positioned(
                          right: 60,
                          top: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              "Fri, 20 May\n80% +\nUpperbody Workout",
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                color: const Color(0xFF6B73FF),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
            colors: [Colors.white, Colors.white],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
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
                color: const Color(0xFF6B73FF),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF6B73FF),
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

  Widget _buildScrollableContent() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDailyWorkoutSchedule(),
            const SizedBox(height: 24),
            _buildUpcomingWorkout(),
            const SizedBox(height: 24),
            _buildWhatDoYouWantToTrain(),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyWorkoutSchedule() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Daily Workout Schedule",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              WorkoutScheduleScreen.open(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6B73FF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
            ),
            child: Text(
              "Check",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingWorkout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Upcoming Workout",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to all upcoming workouts
              },
              child: Text(
                "See more",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6B73FF),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildWorkoutCard(
          title: "Fullbody Workout",
          time: "Today, 03:00pm",
          icon: Icons.fitness_center,
          isActive: _isFullbodyActive,
          onToggle: (value) {
            setState(() {
              _isFullbodyActive = value;
              if (value) _isUpperbodyActive = false; // Only one can be active
            });
          },
        ),
        const SizedBox(height: 12),
        _buildWorkoutCard(
          title: "Upperbody Workout",
          time: "June 06, 02:00pm",
          icon: Icons.sports_gymnastics,
          isActive: _isUpperbodyActive,
          onToggle: (value) {
            setState(() {
              _isUpperbodyActive = value;
              if (value) _isFullbodyActive = false; // Only one can be active
            });
          },
        ),
      ],
    );
  }

  Widget _buildWorkoutCard({
    required String title,
    required String time,
    required IconData icon,
    required bool isActive,
    required Function(bool) onToggle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? const Color(0xFF6B73FF) : Colors.grey.shade200,
          width: isActive ? 2 : 1,
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
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF6B73FF).withOpacity(0.1)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: isActive ? const Color(0xFF6B73FF) : Colors.grey.shade600,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isActive,
            onChanged: onToggle,
            activeColor: const Color(0xFF6B73FF),
            activeTrackColor: const Color(0xFF6B73FF).withOpacity(0.3),
            inactiveThumbColor: Colors.grey.shade300,
            inactiveTrackColor: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }

  Widget _buildWhatDoYouWantToTrain() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What Do You Want to Train",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildWorkoutTypeCard(
          title: "Fullbody Workout",
          details: "11 Exercises | 32mins",
          illustration: Icons.fitness_center,
          color: const Color(0xFF6B73FF),
        ),
        const SizedBox(height: 12),
        _buildWorkoutTypeCard(
          title: "Lowerbody Workout",
          details: "9 Exercises | 28mins",
          illustration: Icons.directions_run,
          color: const Color(0xFF10B981),
        ),
        const SizedBox(height: 12),
        _buildWorkoutTypeCard(
          title: "AB Workout",
          details: "8 Exercises | 22mins",
          illustration: Icons.accessibility_new,
          color: const Color(0xFFF59E0B),
        ),
      ],
    );
  }

  Widget _buildWorkoutTypeCard({
    required String title,
    required String details,
    required IconData illustration,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1),
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
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(illustration, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Widget target;
              if (title.toLowerCase().contains('lower')) {
                target = const LowerBodyWorkoutScreen();
              } else if (title.toLowerCase().contains('ab')) {
                target = const AbWorkoutScreen();
              } else {
                target = const FullbodyWorkoutScreen();
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => target),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
            ),
            child: Text(
              "View more",
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
}

class WorkoutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final data = [30.0, 45.0, 60.0, 35.0, 80.0, 75.0, 50.0];
    final maxValue = 100.0;
    final chartHeight = size.height - 30; // Leave space for day labels

    // Grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 0.5;

    // Draw horizontal grid lines
    for (int i = 0; i <= 5; i++) {
      final y = (i / 5) * chartHeight;
      canvas.drawLine(Offset(20, y), Offset(size.width - 20, y), gridPaint);
    }

    // Draw vertical grid lines
    for (int i = 0; i < data.length; i++) {
      final x = 20 + (i / (data.length - 1)) * (size.width - 40);
      canvas.drawLine(Offset(x, 0), Offset(x, chartHeight), gridPaint);
    }

    // Calculate points
    final points = <Offset>[];
    for (int i = 0; i < data.length; i++) {
      final x = 20 + (i / (data.length - 1)) * (size.width - 40);
      final y = chartHeight - (data[i] / maxValue) * chartHeight;
      points.add(Offset(x, y));
    }

    // Draw filled area
    final fillPath = Path();
    fillPath.moveTo(points.first.dx, chartHeight);
    for (final point in points) {
      fillPath.lineTo(point.dx, point.dy);
    }
    fillPath.lineTo(points.last.dx, chartHeight);
    fillPath.close();

    final fillPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    // Draw line
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(linePath, linePaint);

    // Draw points
    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final highlightPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final point = points[i];
      if (i == 4) {
        // Friday (highlighted)
        canvas.drawCircle(point, 6, highlightPaint);
        canvas.drawCircle(point, 3, Paint()..color = const Color(0xFF6B73FF));
      } else {
        canvas.drawCircle(point, 3, pointPaint);
      }
    }

    // Draw percentage labels on Y-axis
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i <= 5; i++) {
      final percentage = '${100 - (i * 20)}%';
      final y = (i / 5) * chartHeight;

      textPainter.text = TextSpan(
        text: percentage,
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
