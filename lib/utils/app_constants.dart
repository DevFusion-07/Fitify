import 'package:flutter/material.dart';

// App-wide color constants
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF6B73FF);
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color accent = Color(0xFFFF6B35);

  // Background colors
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF4F6FF);
  static const Color cardBackground = Colors.white;

  // Text colors
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);

  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFE11D48);
  static const Color info = Color(0xFF3B82F6);

  // Meal card colors
  static const Color breakfastBg = Color(0xFFE3F2FD);
  static const Color lunchBg = Color(0xFFF3E5F5);
  static const Color dinnerBg = Color(0xFFFFF3E0);

  // Workout colors
  static const Color workoutPrimary = Color(0xFF6B73FF);
  static const Color workoutSecondary = Color(0xFF8B5CF6);
  static const Color workoutAccent = Color(0xFFFF6B35);
}

// App-wide spacing constants
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;

  // Common margins
  static const EdgeInsets screenPadding = EdgeInsets.fromLTRB(16, 12, 16, 24);
  static const EdgeInsets cardPadding = EdgeInsets.all(16);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 6,
  );

  // Common gaps
  static const SizedBox gapXs = SizedBox(height: xs);
  static const SizedBox gapSm = SizedBox(height: sm);
  static const SizedBox gapMd = SizedBox(height: md);
  static const SizedBox gapLg = SizedBox(height: lg);
  static const SizedBox gapXl = SizedBox(height: xl);
  static const SizedBox gapXxl = SizedBox(height: xxl);
  static const SizedBox gapXxxl = SizedBox(height: xxxl);
}

// App-wide border radius constants
class AppRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 18.0;
  static const double xxl = 20.0;
  static const double xxxl = 25.0;

  // Common border radius
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(md));
  static const BorderRadius buttonRadius = BorderRadius.all(
    Radius.circular(xl),
  );
  static const BorderRadius pillRadius = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius imageRadius = BorderRadius.all(Radius.circular(sm));
}

// App-wide shadow constants
class AppShadows {
  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 6)),
  ];

  static const List<BoxShadow> buttonShadow = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> lightShadow = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 2)),
  ];
}

// App-wide text styles
class AppTextStyles {
  static const String fontFamily = 'Poppins';

  // Common text styles
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

// App-wide dimensions
class AppDimensions {
  // Card dimensions
  static const double cardWidth = 210.0;
  static const double cardHeight = 210.0;
  static const double imageSize = 140.0;
  static const double smallImageSize = 48.0;
  static const double iconSize = 24.0;
  static const double smallIconSize = 18.0;

  // Button dimensions
  static const double buttonHeight = 36.0;
  static const double smallButtonHeight = 34.0;

  // Container dimensions
  static const double containerHeight = 230.0;
  static const double chartHeight = 140.0;

  // Spacing between elements
  static const double cardSpacing = 20.0;
  static const double sectionSpacing = 32.0;
}

// App-wide data constants
class AppData {
  // Meal filter options
  static const List<String> mealFilters = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
  ];

  // Period options
  static const List<String> periods = ['Daily', 'Weekly', 'Monthly'];

  // Chart data
  static const List<double> sampleChartData = [22, 40, 35, 50, 28, 62, 45];

  // Meal card data
  static const Map<String, Map<String, dynamic>> mealCards = {
    'Breakfast': {
      'title': 'Breakfast',
      'subtitle': '120+ Foods',
      'backgroundColor': AppColors.breakfastBg,
      'buttonColor': AppColors.primary,
      'imagePath': 'assets/images/meal/breakfast.png',
    },
    'Lunch': {
      'title': 'Lunch',
      'subtitle': '130+ Foods',
      'backgroundColor': AppColors.lunchBg,
      'buttonColor': AppColors.secondary,
      'imagePath': 'assets/images/meal/lunch.png',
    },
    'Dinner': {
      'title': 'Dinner',
      'subtitle': '140+ Foods',
      'backgroundColor': AppColors.dinnerBg,
      'buttonColor': AppColors.accent,
      'imagePath': 'assets/images/meal/dinner.png',
    },
  };

  // Stat data
  static const Map<String, Map<String, dynamic>> stats = {
    'Calories': {'value': '82%', 'color': AppColors.success},
    'Fibre': {'value': '89%', 'color': AppColors.primary},
    'Sugar': {'value': '39%', 'color': AppColors.error},
    'Fats': {'value': '42%', 'color': AppColors.warning},
  };
}
