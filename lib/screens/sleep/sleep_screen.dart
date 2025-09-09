import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_constants.dart';
import '../../widgets/common_widgets.dart';
import 'package:provider/provider.dart';
import '../../widgets/sleep_pattern_widget.dart';
import '../../providers/activity_provider.dart';
import 'sleep_schedule_screen.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  String selectedPeriod = 'Weekly';
  bool isSleeping = false;
  DateTime? sleepStartTime;
  DateTime? sleepEndTime;

  // Sample sleep data
  final List<Map<String, dynamic>> weeklySleepData = [
    {'day': 'Mon', 'hours': 7.5, 'quality': 'Good'},
    {'day': 'Tue', 'hours': 8.2, 'quality': 'Excellent'},
    {'day': 'Wed', 'hours': 6.8, 'quality': 'Fair'},
    {'day': 'Thu', 'hours': 7.9, 'quality': 'Good'},
    {'day': 'Fri', 'hours': 8.5, 'quality': 'Excellent'},
    {'day': 'Sat', 'hours': 9.1, 'quality': 'Excellent'},
    {'day': 'Sun', 'hours': 8.0, 'quality': 'Good'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(
          "Sleep Tracker",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () => _showSleepOptions(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSleepOverview(),
            const SizedBox(height: 24),
            _buildSleepScheduleCard(),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final double gap = 16;
                final double cardSize = (constraints.maxWidth - gap) / 2;
                return Row(
                  children: [
                    SizedBox(
                      width: cardSize,
                      height: cardSize,
                      child: _buildSleepChart(cardSize),
                    ),
                    SizedBox(width: gap),
                    SizedBox(
                      width: cardSize,
                      height: cardSize,
                      child: _buildSleepControlsSquare(cardSize),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            _buildSleepStats(),
            const SizedBox(height: 24),
            _buildSleepTips(),
            const SizedBox(height: 24),
            _buildSleepHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepScheduleCard() {
    return CommonCard(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Daily Sleep Schedule',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SleepScheduleScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.purple.shade400],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Check',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepOverview() {
    final avgSleepHours =
        weeklySleepData
            .map((data) => data['hours'] as double)
            .reduce((a, b) => a + b) /
        weeklySleepData.length;

    return CommonCard(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sleep Overview',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.textPrimary,
                ),
              ),
              _buildPeriodSelector(),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildSleepMetric(
                  'Average Sleep',
                  '${avgSleepHours.toStringAsFixed(1)}h',
                  Icons.bedtime,
                  AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSleepMetric(
                  'Sleep Quality',
                  'Good',
                  Icons.star,
                  AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSleepMetric(
                  'Bedtime',
                  '10:30 PM',
                  Icons.nightlight_round,
                  AppColors.secondary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSleepMetric(
                  'Wake Time',
                  '6:30 AM',
                  Icons.wb_sunny,
                  AppColors.accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedPeriod,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
          items: ['Daily', 'Weekly', 'Monthly']
              .map(
                (period) =>
                    DropdownMenuItem(value: period, child: Text(period)),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedPeriod = value!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSleepMetric(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepChart([double? forcedSize]) {
    final title = Text(
      'Sleep Pattern',
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      overflow: TextOverflow.ellipsis,
    );

    if (forcedSize != null) {
      // Square variant: fit contents within fixed size to avoid overflow
      return CommonCard(
        backgroundColor: Colors.white,
        child: SizedBox(
          width: forcedSize,
          height: forcedSize,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle.merge(
                style: const TextStyle(fontSize: 16),
                child: title,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Consumer<ActivityProvider>(
                    builder: (context, activity, _) => SleepPatternWidget(
                      sleepDuration: activity.sleepDuration,
                      sleepPattern: activity.sleepPattern,
                      height: forcedSize * 0.65,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return CommonCard(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Consumer<ActivityProvider>(
                builder: (context, activity, _) => SleepPatternWidget(
                  sleepDuration: activity.sleepDuration,
                  sleepPattern: activity.sleepPattern,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Removed custom chart painter in favor of reusable SleepPatternWidget

  // replaced by _buildSleepControlsSquare for square layout

  Widget _buildSleepControlsSquare(double size) {
    return CommonCard(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: size,
        height: size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sleep Tracking',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _toggleSleepTracking,
                  child: Container(
                    width: size * 0.34,
                    height: size * 0.34,
                    decoration: BoxDecoration(
                      color: isSleeping ? AppColors.error : AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:
                              (isSleeping ? AppColors.error : AppColors.primary)
                                  .withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      isSleeping ? Icons.stop : Icons.bedtime,
                      color: Colors.white,
                      size: size * 0.17,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _toggleSleepTracking,
                child: Text(
                  isSleeping ? 'Stop Sleep Tracking' : 'Start Sleep Tracking',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (isSleeping) ...[
              const SizedBox(height: 4),
              Center(
                child: Text(
                  'Sleeping since ${_formatTime(sleepStartTime ?? DateTime.now())}',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSleepStats() {
    return CommonCard(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sleep Statistics',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Deep Sleep',
                  '2h 15m',
                  '25%',
                  AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Light Sleep',
                  '4h 30m',
                  '50%',
                  AppColors.info,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'REM Sleep',
                  '1h 45m',
                  '20%',
                  AppColors.secondary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Awake', '30m', '5%', AppColors.warning),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String duration,
    String percentage,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            duration,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            percentage,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepTips() {
    final sleepTips = [
      {
        'title': 'Consistent Sleep Schedule',
        'description': 'Go to bed and wake up at the same time every day',
        'icon': Icons.schedule,
        'color': AppColors.primary,
      },
      {
        'title': 'Avoid Caffeine',
        'description': 'Limit caffeine intake 6 hours before bedtime',
        'icon': Icons.local_cafe,
        'color': AppColors.warning,
      },
      {
        'title': 'Create Bedtime Routine',
        'description': 'Develop a relaxing pre-sleep routine',
        'icon': Icons.bedtime,
        'color': AppColors.secondary,
      },
      {
        'title': 'Optimize Environment',
        'description': 'Keep your bedroom cool, dark, and quiet',
        'icon': Icons.lightbulb_outline,
        'color': AppColors.info,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sleep Tips',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ...sleepTips.map((tip) => _buildSleepTipCard(tip)),
      ],
    );
  }

  Widget _buildSleepTipCard(Map<String, dynamic> tip) {
    return CommonCard(
      backgroundColor: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: tip['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(tip['icon'], color: tip['color'], size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip['title'],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tip['description'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepHistory() {
    return CommonCard(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Sleep',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...weeklySleepData
              .take(5)
              .map((data) => _buildSleepHistoryItem(data)),
        ],
      ),
    );
  }

  Widget _buildSleepHistoryItem(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getQualityColor(data['quality']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                data['day'],
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: _getQualityColor(data['quality']),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data['hours']} hours',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  data['quality'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getQualityColor(data['quality']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              data['quality'],
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: _getQualityColor(data['quality']),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getQualityColor(String quality) {
    switch (quality.toLowerCase()) {
      case 'excellent':
        return AppColors.success;
      case 'good':
        return AppColors.primary;
      case 'fair':
        return AppColors.warning;
      default:
        return AppColors.error;
    }
  }

  void _toggleSleepTracking() {
    setState(() {
      if (isSleeping) {
        sleepEndTime = DateTime.now();
        isSleeping = false;
        _showSleepSummary();
      } else {
        sleepStartTime = DateTime.now();
        isSleeping = true;
      }
    });
  }

  void _showSleepSummary() {
    if (sleepStartTime != null && sleepEndTime != null) {
      final duration = sleepEndTime!.difference(sleepStartTime!);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Sleep Session Complete',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: Text(
            'You slept for ${duration.inHours}h ${duration.inMinutes % 60}m',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: GoogleFonts.poppins(color: AppColors.primary),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _showSleepOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sleep Options',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.schedule, color: AppColors.primary),
              title: Text('Sleep Schedule', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SleepScheduleScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: AppColors.primary),
              title: Text('Sleep Settings', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.analytics, color: AppColors.primary),
              title: Text('Sleep Analytics', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: AppColors.primary,
              ),
              title: Text('Sleep Reminders', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}

// Replaced by SleepPatternWidget for consistency with Home
