import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fullbody_workout_screen.dart';
import 'lowerbody_workout_screen.dart';
import 'ab_workout_screen.dart';
import '../workout_schedule/workout_schedule_screen.dart';

class WorkoutTrackerScreen extends StatefulWidget {
  const WorkoutTrackerScreen({super.key});

  @override
  State<WorkoutTrackerScreen> createState() => _WorkoutTrackerScreenState();
}

class _WorkoutTrackerScreenState extends State<WorkoutTrackerScreen> {
  // State variables for workout toggles
  bool _isFullbodyActive = true;
  bool _isUpperbodyActive = false;

  @override
  Widget build(BuildContext context) {
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24,
            ),
          ),
          Expanded(
            child: Text(
              "Workout Tracker",
              style: GoogleFonts.poppins(
                fontSize: 20,
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
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutProgressGraph() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Workout Progress",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Weekly",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
                height: 180,
                child: CustomPaint(
                  painter: WorkoutChartPainter(),
                  child: SizedBox(
                    width: double.infinity,
                    height: 180,
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
                                          color: Colors.white.withValues(
                                            alpha: 0.8,
                                          ),
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
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
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
            color: Colors.grey.withValues(alpha: 0.1),
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
                  ? const Color(0xFF6B73FF).withValues(alpha: 0.1)
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
            activeTrackColor: const Color(0xFF6B73FF).withValues(alpha: 0.3),
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
            color: Colors.grey.withValues(alpha: 0.1),
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
              color: color.withValues(alpha: 0.1),
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
      ..color = Colors.white.withValues(alpha: 0.2)
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
      ..color = Colors.white.withValues(alpha: 0.1)
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
          color: Colors.white.withValues(alpha: 0.8),
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
