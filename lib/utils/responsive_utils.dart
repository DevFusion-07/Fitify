import 'package:flutter/material.dart';

class ResponsiveUtils {
  static double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375.0; // Base width (iPhone X)
    return baseFontSize * scaleFactor.clamp(0.8, 1.2);
  }

  static double getResponsiveSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375.0;
    return baseSize * scaleFactor.clamp(0.8, 1.2);
  }

  static double getCardHeight(BuildContext context, double baseHeight) {
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = screenHeight / 812.0; // Base height (iPhone X)
    return baseHeight * scaleFactor.clamp(0.8, 1.2);
  }

  static EdgeInsets getResponsivePadding(BuildContext context, EdgeInsets basePadding) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375.0;
    return basePadding * scaleFactor.clamp(0.8, 1.2);
  }
}
