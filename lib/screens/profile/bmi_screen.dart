import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_constants.dart';
import 'package:provider/provider.dart';
import '../../providers/activity_provider.dart';
import '../../widgets/common_widgets.dart';
import '../../utils/responsive_utils.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  String bmiCategory = 'Normal weight';
  Color bmiColor = AppColors.success;

  // Sample BMI history data
  final List<Map<String, dynamic>> bmiHistory = [
    {'date': 'Jan 2024', 'bmi': 19.8, 'weight': 56.5},
    {'date': 'Feb 2024', 'bmi': 20.0, 'weight': 57.0},
    {'date': 'Mar 2024', 'bmi': 19.9, 'weight': 56.8},
    {'date': 'Apr 2024', 'bmi': 20.1, 'weight': 58.0},
    {'date': 'May 2024', 'bmi': 20.3, 'weight': 58.5},
  ];

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.getResponsivePadding(
      context,
      const EdgeInsets.all(16),
    );

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBMICard(),
            const SizedBox(height: 24),
            _buildBMICalculation(),
            const SizedBox(height: 24),
            _buildBMICategories(),
            const SizedBox(height: 24),
            _buildBMIHistory(),
            const SizedBox(height: 24),
            _buildBMITips(),
          ],
        ),
      ),
    );
  }

  Widget _buildBMICard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B73FF), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B73FF).withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your BMI",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.watch<ActivityProvider>().bmi.toStringAsFixed(1),
                      style: GoogleFonts.poppins(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bmiCategory,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "kg/m²",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildBMIProgressBar(),
        ],
      ),
    );
  }

  Widget _buildBMIProgressBar() {
    final bmi = context.watch<ActivityProvider>().bmi;
    double progress = (bmi - 15) / (35 - 15); // Scale from 15-35 BMI range
    progress = progress.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "BMI Range",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "15",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            Text(
              "35",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBMICalculation() {
    return CommonCard(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BMI Calculation',
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
                child: _buildInputField(
                  'Height (cm)',
                  context.watch<ActivityProvider>().heightCm.toStringAsFixed(0),
                  Icons.height,
                  AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInputField(
                  'Weight (kg)',
                  context.watch<ActivityProvider>().weightKg.toStringAsFixed(0),
                  Icons.monitor_weight,
                  AppColors.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Calculate BMI',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
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
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBMICategories() {
    final categories = [
      {'range': 'Underweight', 'bmi': '< 18.5', 'color': AppColors.info},
      {
        'range': 'Normal weight',
        'bmi': '18.5 - 24.9',
        'color': AppColors.success,
      },
      {'range': 'Overweight', 'bmi': '25.0 - 29.9', 'color': AppColors.warning},
      {'range': 'Obesity', 'bmi': '≥ 30.0', 'color': AppColors.error},
    ];

    return CommonCard(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BMI Categories',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          ...categories.map(
            (category) => _buildCategoryItem(
              category['range'] as String,
              category['bmi'] as String,
              category['color'] as Color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String range, String bmi, Color color) {
    final isCurrent = range.toLowerCase() == bmiCategory.toLowerCase();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrent ? color.withOpacity(0.1) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrent ? color : Colors.grey.shade200,
          width: isCurrent ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              range,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            bmi,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          if (isCurrent) ...[
            const SizedBox(width: 8),
            Icon(Icons.check_circle, color: color, size: 20),
          ],
        ],
      ),
    );
  }

  Widget _buildBMIHistory() {
    return CommonCard(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BMI History',
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
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: CustomPaint(
              painter: BMIHistoryPainter(bmiHistory),
              child: Container(),
            ),
          ),
          const SizedBox(height: 16),
          ...bmiHistory.take(3).map((data) => _buildHistoryItem(data)),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            data['date'],
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            'BMI: ${data['bmi'].toStringAsFixed(1)}',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Weight: ${data['weight']}kg',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBMITips() {
    final tips = [
      {
        'title': 'Maintain Healthy Weight',
        'description': 'Focus on balanced nutrition and regular exercise',
        'icon': Icons.fitness_center,
        'color': AppColors.primary,
      },
      {
        'title': 'Monitor Progress',
        'description': 'Track your BMI regularly to stay on target',
        'icon': Icons.trending_up,
        'color': AppColors.success,
      },
      {
        'title': 'Consult Healthcare Provider',
        'description': 'Seek professional advice for personalized guidance',
        'icon': Icons.medical_services,
        'color': AppColors.info,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BMI Tips',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ...tips.map((tip) => _buildTipCard(tip)),
      ],
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip) {
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

  void _calculateBMI() {
    final activity = context.read<ActivityProvider>();
    final bmi = activity.bmi;

    setState(() {
      if (bmi < 18.5) {
        bmiCategory = 'Underweight';
        bmiColor = AppColors.info;
      } else if (bmi >= 18.5 && bmi < 25) {
        bmiCategory = 'Normal weight';
        bmiColor = AppColors.success;
      } else if (bmi >= 25 && bmi < 30) {
        bmiCategory = 'Overweight';
        bmiColor = AppColors.warning;
      } else {
        bmiCategory = 'Obesity';
        bmiColor = AppColors.error;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'BMI calculated: ${bmi.toStringAsFixed(1)} - $bmiCategory',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: bmiColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class BMIHistoryPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  BMIHistoryPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = AppColors.primary.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final maxBMI = data
        .map((d) => d['bmi'] as double)
        .reduce((a, b) => a > b ? a : b);
    final minBMI = data
        .map((d) => d['bmi'] as double)
        .reduce((a, b) => a < b ? a : b);
    final bmiRange = maxBMI - minBMI;

    final stepX = size.width / (data.length - 1);
    final stepY = size.height / (bmiRange > 0 ? bmiRange : 1);

    // Create the line path
    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - ((data[i]['bmi'] as double) - minBMI) * stepY;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    // Complete the fill path
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    // Draw fill and stroke
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw data points
    final pointPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - ((data[i]['bmi'] as double) - minBMI) * stepY;
      canvas.drawCircle(Offset(x, y), 4, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
