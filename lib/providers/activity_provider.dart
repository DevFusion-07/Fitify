import 'package:flutter/material.dart';
import 'dart:math' as math;

class ActivityProvider extends ChangeNotifier {
  // Height/Weight (source of truth for BMI)
  double _heightCm = 170.0;
  double _weightKg = 58.0;
  double get heightCm => _heightCm;
  double get weightKg => _weightKg;
  void updateHeightWeight({double? heightCm, double? weightKg}) {
    if (heightCm != null) _heightCm = heightCm;
    if (weightKg != null) _weightKg = weightKg;
    notifyListeners();
  }

  // BMI derived from height/weight
  double get bmi {
    final heightM = _heightCm / 100.0;
    if (heightM <= 0) return 0.0;
    return double.parse(((_weightKg) / (heightM * heightM)).toStringAsFixed(1));
  }

  // Heart rate (BPM)
  int _heartRate = 78;
  List<double> _heartRateHistory = [
    65.0,
    70.0,
    75.0,
    78.0,
    82.0,
    79.0,
    76.0,
    73.0,
    70.0,
    68.0,
  ];
  int get heartRate => _heartRate;
  List<double> get heartRateHistory => _heartRateHistory;
  void updateHeartRate(int bpm, {List<double>? history}) {
    _heartRate = bpm;
    if (history != null) _heartRateHistory = history;
    notifyListeners();
  }

  // Water intake (liters)
  double _currentWaterIntakeL = 4.0;
  double _targetWaterIntakeL = 8.0;
  List<WaterUpdate> _waterUpdates = const [
    WaterUpdate(timeRange: '6am - 8am', amountMl: 700),
    WaterUpdate(timeRange: '2pm - 4pm', amountMl: 500),
    WaterUpdate(timeRange: '4pm - now', amountMl: 1100),
  ];
  double get currentWaterIntakeL => _currentWaterIntakeL;
  double get targetWaterIntakeL => _targetWaterIntakeL;
  List<WaterUpdate> get waterUpdates => _waterUpdates;
  void addWater(int amountMl, String timeRange) {
    _currentWaterIntakeL += amountMl / 1000.0;
    _waterUpdates = [
      ..._waterUpdates,
      WaterUpdate(timeRange: timeRange, amountMl: amountMl),
    ];
    notifyListeners();
  }

  void updateWaterTargets({double? currentL, double? targetL}) {
    if (currentL != null) _currentWaterIntakeL = currentL;
    if (targetL != null) _targetWaterIntakeL = targetL;
    notifyListeners();
  }

  // Sleep
  String _sleepDuration = '8h 20m';
  List<double> _sleepPattern = [0.2, 0.4, 0.6, 0.8, 0.9, 0.7, 0.5, 0.3, 0.1];
  String get sleepDuration => _sleepDuration;
  List<double> get sleepPattern => _sleepPattern;
  void updateSleep({required String duration, List<double>? pattern}) {
    _sleepDuration = duration;
    if (pattern != null) _sleepPattern = pattern;
    notifyListeners();
  }

  // Calories
  int _currentCalories = 760;
  int _targetCalories = 1010;
  int get currentCalories => _currentCalories;
  int get targetCalories => _targetCalories;
  int get remainingCalories => math.max(0, _targetCalories - _currentCalories);
  void updateCalories({int? current, int? target}) {
    if (current != null) _currentCalories = current;
    if (target != null) _targetCalories = target;
    notifyListeners();
  }

  // Workout progress data
  final List<double> _progressDaily = [
    15.0,
    25.0,
    35.0,
    45.0,
    55.0,
    65.0,
    75.0,
  ];
  final List<double> _progressWeekly = [
    20.0,
    35.0,
    45.0,
    60.0,
    75.0,
    85.0,
    30.0,
  ];
  final List<double> _progressMonthly = [
    10.0,
    20.0,
    30.0,
    45.0,
    55.0,
    65.0,
    75.0,
    70.0,
    80.0,
    90.0,
    95.0,
    85.0,
  ];
  List<double> get progressDaily => _progressDaily;
  List<double> get progressWeekly => _progressWeekly;
  List<double> get progressMonthly => _progressMonthly;
}

class WaterUpdate {
  final String timeRange;
  final int amountMl;
  const WaterUpdate({required this.timeRange, required this.amountMl});
}
