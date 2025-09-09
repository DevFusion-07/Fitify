import 'package:google_fonts/google_fonts.dart';
import 'screens/splash/splash_screen.dart';
import 'providers/activity_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'providers/auth_provider.dart';
import 'utils/performance_utils.dart';

void main() {
  runApp(const FitifyApp());
}

class FitifyApp extends StatelessWidget {
  const FitifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider()..initialize(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ActivityProvider>(
          create: (_) => ActivityProvider(),
          update: (_, auth, activity) {
            final instance = activity ?? ActivityProvider();
            final user = auth.user;
            if (user != null) {
              final height = user.height;
              final weight = user.weight;
              if (height != null || weight != null) {
                instance.updateHeightWeight(
                  heightCm: height ?? instance.heightCm,
                  weightKg: weight ?? instance.weightKg,
                );
              }
            }
            return instance;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Fitify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.poppins().fontFamily,
          // Performance optimizations
          useMaterial3: true,
          // Reduce animation duration for better performance
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        home: const PerformanceMonitor(
          name: 'SplashScreen',
          child: SplashScreen(),
        ),
      ),
    );
  }
}
