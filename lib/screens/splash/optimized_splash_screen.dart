import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../onboarding/onboarding_screen.dart';
import '../../utils/performance_utils.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _pulseController;
  late AnimationController _circleController;
  late AnimationController _loadingController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _pulseAnimation;
  late Animation<double> _circleRotation;
  late Animation<double> _loadingProgress;

  @override
  void initState() {
    super.initState();

    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Pulse animation controller
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Circle rotation controller
    _circleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Loading progress controller
    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Logo animations
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );

    // Pulse animation
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Circle rotation
    _circleRotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _circleController, curve: Curves.linear));

    // Loading progress
    _loadingProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loadingController, curve: Curves.easeInOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    // Start logo animation
    _logoController.forward();

    // Wait for logo to appear, then start pulse
    await Future.delayed(const Duration(milliseconds: 800));
    _pulseController.repeat(reverse: true);

    // Start circle rotation
    _circleController.repeat();

    // Start loading progress
    await Future.delayed(const Duration(milliseconds: 500));
    _loadingController.forward();

    // Navigate to onboarding after all animations
    await Future.delayed(const Duration(milliseconds: 3500));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _pulseController.dispose();
    _circleController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return PerformanceMonitor(
      name: 'SplashScreen',
      child: Scaffold(
        body: OptimizedGradientContainer(
          colors: const [
            Color(0xFF6B73FF),
            Color(0xFF8B5CF6),
            Color(0xFF667eea),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.5, 1.0],
          child: Stack(
            children: [
              // Background decoration circles
              _buildBackgroundDecorations(screenSize),

              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo with animations
                    _buildAnimatedLogo(),

                    const SizedBox(height: 40),

                    // App name
                    _buildAppName(),

                    const SizedBox(height: 16),

                    // Tagline
                    _buildTagline(),

                    const SizedBox(height: 60),

                    // Loading animation
                    _buildLoadingAnimation(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundDecorations(Size screenSize) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _circleController,
        builder: (context, child) {
          return Stack(
            children: [
              // Top left circle
              Positioned(
                top: -50 + (math.sin(_circleRotation.value * 2 * math.pi) * 20),
                left:
                    -50 + (math.cos(_circleRotation.value * 2 * math.pi) * 15),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),

              // Top right circle
              Positioned(
                top: 100 + (math.cos(_circleRotation.value * 3 * math.pi) * 25),
                right:
                    -30 + (math.sin(_circleRotation.value * 2 * math.pi) * 10),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.08),
                  ),
                ),
              ),

              // Bottom left circle
              Positioned(
                bottom:
                    150 + (math.sin(_circleRotation.value * 4 * math.pi) * 30),
                left:
                    -20 + (math.cos(_circleRotation.value * 3 * math.pi) * 20),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.06),
                  ),
                ),
              ),

              // Bottom right circle
              Positioned(
                bottom:
                    -40 + (math.cos(_circleRotation.value * 2 * math.pi) * 15),
                right:
                    -40 + (math.sin(_circleRotation.value * 3 * math.pi) * 25),
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge([_logoController, _pulseController]),
        builder: (context, child) {
          return Transform.scale(
            scale: _logoScale.value * _pulseAnimation.value,
            child: Opacity(
              opacity: _logoOpacity.value,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/fitify_logo.svg',
                    width: 60,
                    height: 60,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppName() {
    return OptimizedText(
      'Fitify',
      style: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildTagline() {
    return OptimizedText(
      'Your Personal Fitness Companion',
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white.withOpacity(0.9),
        letterSpacing: 0.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoadingAnimation() {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _loadingController,
        builder: (context, child) {
          return Column(
            children: [
              // Progress bar
              Container(
                width: 200,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _loadingProgress.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Loading text
              OptimizedText(
                'Loading...',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
