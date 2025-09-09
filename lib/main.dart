import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/splash/splash_screen.dart';
import 'utils/performance_utils.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(const FitifyApp());
}

class FitifyApp extends StatelessWidget {
  const FitifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider()..initialize(),
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
