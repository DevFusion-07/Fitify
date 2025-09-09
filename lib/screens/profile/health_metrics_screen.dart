import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/activity_provider.dart';
import '../../widgets/common_widgets.dart';

class HealthMetricsScreen extends StatefulWidget {
  const HealthMetricsScreen({super.key});

  @override
  State<HealthMetricsScreen> createState() => _HealthMetricsScreenState();
}

class _HealthMetricsScreenState extends State<HealthMetricsScreen> {
  String _selectedTimeRange = 'Week';

  final List<Map<String, dynamic>> _healthData = [
    {
      'date': DateTime.now().subtract(const Duration(days: 6)),
      'weight': 75.2,
      'bodyFat': 18.5,
      'muscleMass': 45.8,
      'waterIntake': 2.5,
      'sleepHours': 8.2,
      'heartRate': 72,
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'weight': 75.0,
      'bodyFat': 18.3,
      'muscleMass': 45.9,
      'waterIntake': 2.8,
      'sleepHours': 7.8,
      'heartRate': 70,
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'weight': 74.8,
      'bodyFat': 18.1,
      'muscleMass': 46.0,
      'waterIntake': 3.0,
      'sleepHours': 8.5,
      'heartRate': 68,
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'weight': 74.6,
      'bodyFat': 17.9,
      'muscleMass': 46.1,
      'waterIntake': 2.7,
      'sleepHours': 8.0,
      'heartRate': 69,
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'weight': 74.4,
      'bodyFat': 17.7,
      'muscleMass': 46.2,
      'waterIntake': 2.9,
      'sleepHours': 7.9,
      'heartRate': 71,
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'weight': 74.2,
      'bodyFat': 17.5,
      'muscleMass': 46.3,
      'waterIntake': 3.1,
      'sleepHours': 8.3,
      'heartRate': 67,
    },
    {
      'date': DateTime.now(),
      'weight': 74.0,
      'bodyFat': 17.3,
      'muscleMass': 46.4,
      'waterIntake': 2.8,
      'sleepHours': 8.1,
      'heartRate': 69,
    },
  ];

  List<String> get _timeRanges => ['Week', 'Month', 'Year'];

  Map<String, dynamic> get _currentMetrics {
    final latest = _healthData.last;
    return {
      'weight': latest['weight'],
      'bodyFat': latest['bodyFat'],
      'muscleMass': latest['muscleMass'],
      'waterIntake': latest['waterIntake'],
      'sleepHours': latest['sleepHours'],
      'heartRate': latest['heartRate'],
    };
  }

  Map<String, dynamic> get _trends {
    final first = _healthData.first;
    final last = _healthData.last;

    return {
      'weightChange': last['weight'] - first['weight'],
      'bodyFatChange': last['bodyFat'] - first['bodyFat'],
      'muscleMassChange': last['muscleMass'] - first['muscleMass'],
      'avgWaterIntake':
          _healthData.fold(0.0, (sum, data) => sum + data['waterIntake']) /
          _healthData.length,
      'avgSleepHours':
          _healthData.fold(0.0, (sum, data) => sum + data['sleepHours']) /
          _healthData.length,
      'avgHeartRate':
          _healthData.fold(0.0, (sum, data) => sum + data['heartRate']) /
          _healthData.length,
    };
  }

  @override
  Widget build(BuildContext context) {
    final currentMetrics = _currentMetrics;
    final trends = _trends;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Health Metrics',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Time Range Filter
            Container(
              margin: const EdgeInsets.all(20),
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

            // Current Metrics Overview
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    'Current Health Status',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Consumer<ActivityProvider>(
                        builder: (context, activity, _) => _buildCurrentMetric(
                          '${activity.weightKg.toStringAsFixed(1)} kg',
                          'Weight',
                          Icons.monitor_weight,
                        ),
                      ),
                      _buildCurrentMetric(
                        '${currentMetrics['bodyFat']}%',
                        'Body Fat',
                        Icons.pie_chart,
                      ),
                      _buildCurrentMetric(
                        '${currentMetrics['heartRate']}',
                        'Heart Rate',
                        Icons.favorite,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // BMI Section
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                final user = authProvider.user;
                if (user?.height != null && user?.weight != null) {
                  final bmi = user!.bmi!;
                  final bmiCategory = _getBMICategory(bmi);

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: CommonCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Body Mass Index (BMI)',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bmi.toStringAsFixed(1),
                                      style: GoogleFonts.poppins(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: _getBMIColor(bmi),
                                      ),
                                    ),
                                    Text(
                                      bmiCategory,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: _getBMIColor(bmi),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: _getBMIColor(bmi).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${((bmi - 15) / 25 * 100).clamp(0, 100).round()}%',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: _getBMIColor(bmi),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 20),

            // Health Trends
            CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Health Trends',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<ActivityProvider>(
                    builder: (context, activity, _) => _buildTrendItem(
                      'Weight',
                      '${activity.weightKg.toStringAsFixed(1)} kg',
                      trends['weightChange'],
                      'kg',
                      Icons.monitor_weight,
                      const Color(0xFF6B73FF),
                    ),
                  ),
                  _buildTrendItem(
                    'Body Fat',
                    '${currentMetrics['bodyFat']}%',
                    trends['bodyFatChange'],
                    '%',
                    Icons.pie_chart,
                    const Color(0xFF8B5CF6),
                  ),
                  _buildTrendItem(
                    'Muscle Mass',
                    '${currentMetrics['muscleMass']} kg',
                    trends['muscleMassChange'],
                    'kg',
                    Icons.fitness_center,
                    const Color(0xFF10B981),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Daily Metrics
            CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Metrics',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDailyMetricItem(
                    'Water Intake',
                    '${trends['avgWaterIntake'].toStringAsFixed(1)} L',
                    Icons.water_drop,
                    const Color(0xFF3B82F6),
                  ),
                  _buildDailyMetricItem(
                    'Sleep Hours',
                    '${trends['avgSleepHours'].toStringAsFixed(1)} h',
                    Icons.bedtime,
                    const Color(0xFFF59E0B),
                  ),
                  _buildDailyMetricItem(
                    'Resting Heart Rate',
                    '${trends['avgHeartRate'].round()} bpm',
                    Icons.favorite,
                    const Color(0xFFEF4444),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Health Goals
            CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Health Goals',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<ActivityProvider>(
                    builder: (context, activity, _) => _buildGoalItem(
                      'Weight Goal',
                      'Target: 70 kg',
                      'Current: ${activity.weightKg.toStringAsFixed(1)} kg',
                      0.8,
                      const Color(0xFF6B73FF),
                    ),
                  ),
                  _buildGoalItem(
                    'Body Fat Goal',
                    'Target: 15%',
                    'Current: ${currentMetrics['bodyFat']}%',
                    0.6,
                    const Color(0xFF8B5CF6),
                  ),
                  _buildGoalItem(
                    'Water Intake Goal',
                    'Target: 3.0 L',
                    'Current: ${currentMetrics['waterIntake']} L',
                    0.9,
                    const Color(0xFF3B82F6),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentMetric(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
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

  Widget _buildTrendItem(
    String title,
    String current,
    double change,
    String unit,
    IconData icon,
    Color color,
  ) {
    final isWeightOrBodyFat = title == 'Weight' || title == 'Body Fat';
    final isGoodChange = isWeightOrBodyFat ? change < 0 : change > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(icon, color: color, size: 24),
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
                  current,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isGoodChange ? Colors.green.shade100 : Colors.red.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isGoodChange ? Icons.trending_up : Icons.trending_down,
                  size: 16,
                  color: isGoodChange ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  '${change.abs().toStringAsFixed(1)}$unit',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isGoodChange ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyMetricItem(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalItem(
    String title,
    String target,
    String current,
    double progress,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            target,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            current,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }
}
