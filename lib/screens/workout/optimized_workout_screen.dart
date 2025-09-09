import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/performance_utils.dart';
import 'fullbody_workout_screen.dart';
import 'lowerbody_workout_screen.dart';

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
  final String _selectedPeriod = "Weekly";
  final List<String> _periods = ["Daily", "Weekly", "Monthly"];
  final int _currentPeriodIndex = 1; // Start with Weekly

  // Optimized scroll controller
  final OptimizedScrollController _scrollController =
      OptimizedScrollController();
  double _headerHeight = 80.0;
  final double _minHeaderHeight = 60.0;
  final double _maxHeaderHeight = 80.0;

  // Performance optimization: cache expensive calculations
  late final double _screenHeight = MediaQuery.of(context).size.height;
  late final double _screenWidth = MediaQuery.of(context).size.width;

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
    // Throttle scroll events for better performance
    PerformanceUtils.throttle(() {
      if (_scrollController.position.pixels > 0) {
        setState(() {
          _headerHeight =
              (_maxHeaderHeight - _scrollController.position.pixels * 0.5)
                  .clamp(_minHeaderHeight, _maxHeaderHeight);
        });
      } else {
        setState(() {
          _headerHeight = _maxHeaderHeight;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PerformanceMonitor(
      name: 'WorkoutScreen',
      child: Scaffold(
        body: OptimizedGradientContainer(
          colors: const [Color(0xFF6B73FF), Color(0xFF8B5CF6)],
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
      ),
    );
  }

  Widget _buildHeader() {
    return OptimizedAnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _headerHeight,
      padding: EdgeInsets.symmetric(
        horizontal: _screenWidth * 0.04,
        vertical: _headerHeight * 0.2,
      ),
      child: Row(
        children: [
          Expanded(
            child: OptimizedText(
              "Workout Tracker",
              style: GoogleFonts.poppins(
                fontSize: _headerHeight * 0.25,
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
              size: _headerHeight * 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutProgressGraph() {
    return Container(
      height: _screenHeight * 0.25,
      padding: EdgeInsets.all(_screenWidth * 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OptimizedText(
                "Workout Progress",
                style: GoogleFonts.poppins(
                  fontSize: _screenHeight * 0.02,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              _buildTimeSelector(),
            ],
          ),
          SizedBox(height: _screenHeight * 0.015),
          Expanded(
            child: OptimizedCard(
              backgroundColor: Colors.white.withOpacity(0.1),
              borderRadius: 16,
              child: SizedBox(
                height: _screenHeight * 0.15,
                child: CustomPaint(
                  painter: WorkoutChartPainter(),
                  child: SizedBox(
                    width: double.infinity,
                    height: _screenHeight * 0.15,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:
                                const [
                                      'Sun',
                                      'Mon',
                                      'Tue',
                                      'Wed',
                                      'Thu',
                                      'Fri',
                                      'Sat',
                                    ]
                                    .map(
                                      (day) => OptimizedText(
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: OptimizedText(
        _selectedPeriod,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildScrollableContent() {
    return OptimizedListView(
      controller: _scrollController,
      padding: EdgeInsets.all(_screenWidth * 0.04),
      children: [
        _buildWorkoutToggleSection(),
        SizedBox(height: _screenHeight * 0.02),
        _buildWorkoutContent(),
      ],
    );
  }

  Widget _buildWorkoutToggleSection() {
    return OptimizedCard(
      backgroundColor: Colors.white.withOpacity(0.1),
      borderRadius: 20,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Expanded(
              child: _buildToggleButton(
                "Fullbody",
                _isFullbodyActive,
                () => setState(() {
                  _isFullbodyActive = true;
                  _isUpperbodyActive = false;
                }),
              ),
            ),
            Expanded(
              child: _buildToggleButton(
                "Upperbody",
                _isUpperbodyActive,
                () => setState(() {
                  _isFullbodyActive = false;
                  _isUpperbodyActive = true;
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: OptimizedAnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: OptimizedText(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isActive ? const Color(0xFF6B73FF) : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutContent() {
    if (_isFullbodyActive) {
      return const FullbodyWorkoutScreen();
    } else {
      return const LowerBodyWorkoutScreen();
    }
  }
}

// Optimized custom painter for workout chart
class WorkoutChartPainter extends OptimizedCustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final data = [30, 45, 35, 60, 40, 55, 50];
    final maxValue = data.reduce((a, b) => a > b ? a : b).toDouble();

    for (int i = 0; i < data.length; i++) {
      final x = (size.width / (data.length - 1)) * i;
      final y = size.height - (data[i] / maxValue) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }
}
