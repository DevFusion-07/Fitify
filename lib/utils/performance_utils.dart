import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_constants.dart';

// Performance optimized widget that prevents unnecessary rebuilds
class PerformanceOptimizedWidget extends StatelessWidget {
  final Widget child;
  final bool shouldRebuild;

  const PerformanceOptimizedWidget({
    super.key,
    required this.child,
    this.shouldRebuild = false,
  });

  @override
  Widget build(BuildContext context) {
    return shouldRebuild ? child : RepaintBoundary(child: child);
  }
}

// Optimized list view with better performance
class OptimizedListView extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const OptimizedListView({
    super.key,
    required this.children,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return RepaintBoundary(child: children[index]);
      },
    );
  }
}

// Optimized grid view with better performance
class OptimizedGridView extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const OptimizedGridView({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 10,
    this.mainAxisSpacing = 10,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) {
        return RepaintBoundary(child: children[index]);
      },
    );
  }
}

// Optimized image widget with caching and error handling
class OptimizedImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const OptimizedImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: width?.toInt(),
        cacheHeight: height?.toInt(),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) return child;
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            child: child,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ??
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.grey.shade400,
                  size: 32,
                ),
              );
        },
      ),
    );
  }
}

// Optimized animated container with better performance
class OptimizedAnimatedContainer extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  final AlignmentGeometry? alignment;

  const OptimizedAnimatedContainer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.padding,
    this.margin,
    this.color,
    this.width,
    this.height,
    this.decoration,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedContainer(
        duration: duration,
        curve: curve,
        padding: padding,
        margin: margin,
        color: color,
        width: width,
        height: height,
        decoration: decoration,
        alignment: alignment,
        child: child,
      ),
    );
  }
}

// Optimized scroll controller with better performance
class OptimizedScrollController extends ScrollController {
  OptimizedScrollController({
    super.initialScrollOffset,
    super.keepScrollOffset,
    super.debugLabel,
  });

  @override
  void addListener(VoidCallback listener) {
    // Throttle scroll events for better performance
    super.addListener(() {
      // Only trigger listener if scroll position changed significantly
      if (hasClients && position.pixels != position.pixels) {
        listener();
      }
    });
  }
}

// Performance monitoring widget
class PerformanceMonitor extends StatefulWidget {
  final Widget child;
  final String? name;

  const PerformanceMonitor({super.key, required this.child, this.name});

  @override
  State<PerformanceMonitor> createState() => _PerformanceMonitorState();
}

class _PerformanceMonitorState extends State<PerformanceMonitor> {
  late DateTime _buildStart;

  @override
  void initState() {
    super.initState();
    _buildStart = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final buildTime = DateTime.now().difference(_buildStart).inMilliseconds;

    // Log slow builds in debug mode
    if (buildTime > 16) {
      // 60 FPS = 16ms per frame
      debugPrint(
        'Performance warning: ${widget.name ?? 'Widget'} took ${buildTime}ms to build',
      );
    }

    return RepaintBoundary(child: widget.child);
  }
}

// Optimized text widget with better performance
class OptimizedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool softWrap;

  const OptimizedText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
      ),
    );
  }
}

// Optimized button widget with better performance
class OptimizedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Widget? icon;

  const OptimizedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.height,
    this.padding,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        height: height ?? 36,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.primary,
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 18),
            ),
            elevation: 0,
            padding: padding,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 8)],
              OptimizedText(
                text,
                style:
                    textStyle ??
                    GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Optimized card widget with better performance
class OptimizedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;

  const OptimizedCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: margin ?? const EdgeInsets.only(bottom: 12),
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            boxShadow:
                boxShadow ??
                [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
          ),
          child: child,
        ),
      ),
    );
  }
}

// Optimized gradient container with better performance
class OptimizedGradientContainer extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final List<double>? stops;
  final TileMode tileMode;

  const OptimizedGradientContainer({
    super.key,
    required this.child,
    required this.colors,
    this.begin,
    this.end,
    this.stops,
    this.tileMode = TileMode.clamp,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: begin ?? Alignment.topCenter,
            end: end ?? Alignment.bottomCenter,
            stops: stops,
            tileMode: tileMode,
          ),
        ),
        child: child,
      ),
    );
  }
}

// Optimized custom painter with better performance
abstract class OptimizedCustomPainter extends CustomPainter {
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Only repaint if the painter actually changed
    return oldDelegate.runtimeType != runtimeType;
  }

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    // Only rebuild semantics if the painter actually changed
    return oldDelegate.runtimeType != runtimeType;
  }
}

// Performance utilities
class PerformanceUtils {
  // Debounce function to limit frequent calls
  static Timer? _debounceTimer;

  static void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(duration, callback);
  }

  // Throttle function to limit calls to a maximum frequency
  static DateTime? _lastCall;

  static void throttle(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 100),
  }) {
    final now = DateTime.now();
    if (_lastCall == null || now.difference(_lastCall!) >= duration) {
      callback();
      _lastCall = now;
    }
  }

  // Check if widget should rebuild based on performance
  static bool shouldRebuild(dynamic oldValue, dynamic newValue) {
    return oldValue != newValue;
  }

  // Optimize list for better performance
  static List<T> optimizeList<T>(List<T> list, {int maxItems = 100}) {
    if (list.length <= maxItems) return list;
    return list.take(maxItems).toList();
  }

  // Memory efficient string operations
  static String truncateString(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
