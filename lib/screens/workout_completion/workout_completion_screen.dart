import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutCompletionScreen extends StatefulWidget {
  const WorkoutCompletionScreen({super.key});

  @override
  State<WorkoutCompletionScreen> createState() =>
      _WorkoutCompletionScreenState();
}

class _WorkoutCompletionScreenState extends State<WorkoutCompletionScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
          ),
        );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                Expanded(flex: 3, child: _buildIllustrationSection()),
                Expanded(flex: 2, child: _buildTextSection()),
                Expanded(flex: 1, child: _buildButtonSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIllustrationSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: CustomPaint(
          size: const Size(double.infinity, double.infinity),
          painter: WorkoutCompletionPainter(),
        ),
      ),
    );
  }

  Widget _buildTextSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congratulations, You Have\nFinished Your Workout',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              '"Exercise is king and nutrition is queen. Combine the two and you will have a kingdom"',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
                height: 1.4,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '- Jack Lalanne',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B73FF),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6B73FF), Color(0xFF8B5CF6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6B73FF).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  'Back To Home',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WorkoutCompletionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw background oval
    final backgroundPaint = Paint()
      ..color = const Color(0xFFE8F2FF)
      ..style = PaintingStyle.fill;

    final backgroundRect = Rect.fromCenter(
      center: center,
      width: size.width * 0.8,
      height: size.height * 0.6,
    );
    canvas.drawOval(backgroundRect, backgroundPaint);

    // Draw exercise ball
    final ballPaint = Paint()
      ..color = const Color(0xFFFFE5F0)
      ..style = PaintingStyle.fill;

    final ballCenter = Offset(
      center.dx - size.width * 0.15,
      center.dy + size.height * 0.1,
    );
    final ballRadius = size.width * 0.12;
    canvas.drawCircle(ballCenter, ballRadius, ballPaint);

    // Draw ball contour lines
    final contourPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawArc(
      Rect.fromCircle(center: ballCenter, radius: ballRadius),
      0,
      3.14,
      false,
      contourPaint,
    );

    // Draw woman figure
    _drawWoman(canvas, center, size);

    // Draw decorative lines
    _drawDecorativeLines(canvas, size);
  }

  void _drawWoman(Canvas canvas, Offset center, Size size) {
    final womanCenter = Offset(center.dx + size.width * 0.05, center.dy);

    // Draw head
    final headPaint = Paint()
      ..color = const Color(0xFFFFE0B2)
      ..style = PaintingStyle.fill;

    final headRadius = size.width * 0.08;
    canvas.drawCircle(womanCenter, headRadius, headPaint);

    // Draw hair
    final hairPaint = Paint()
      ..color = const Color(0xFF3E2723)
      ..style = PaintingStyle.fill;

    final hairPath = Path();
    hairPath.addOval(
      Rect.fromCircle(center: womanCenter, radius: headRadius + 5),
    );
    canvas.drawPath(hairPath, hairPaint);

    // Draw body (sports bra)
    final bodyPaint = Paint()
      ..color = const Color(0xFF8B5CF6)
      ..style = PaintingStyle.fill;

    final bodyRect = Rect.fromCenter(
      center: Offset(womanCenter.dx, womanCenter.dy + headRadius + 20),
      width: size.width * 0.12,
      height: size.height * 0.15,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, const Radius.circular(20)),
      bodyPaint,
    );

    // Draw legs (leggings)
    final legsPaint = Paint()
      ..color = const Color(0xFF8B5CF6)
      ..style = PaintingStyle.fill;

    final leftLegRect = Rect.fromCenter(
      center: Offset(womanCenter.dx - 8, womanCenter.dy + headRadius + 50),
      width: size.width * 0.04,
      height: size.height * 0.2,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(leftLegRect, const Radius.circular(10)),
      legsPaint,
    );

    final rightLegRect = Rect.fromCenter(
      center: Offset(womanCenter.dx + 8, womanCenter.dy + headRadius + 50),
      width: size.width * 0.04,
      height: size.height * 0.2,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rightLegRect, const Radius.circular(10)),
      legsPaint,
    );

    // Draw shoes
    final shoePaint = Paint()
      ..color = const Color(0xFF4C1D95)
      ..style = PaintingStyle.fill;

    final leftShoeRect = Rect.fromCenter(
      center: Offset(womanCenter.dx - 8, womanCenter.dy + headRadius + 70),
      width: size.width * 0.06,
      height: size.height * 0.05,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(leftShoeRect, const Radius.circular(8)),
      shoePaint,
    );

    final rightShoeRect = Rect.fromCenter(
      center: Offset(womanCenter.dx + 8, womanCenter.dy + headRadius + 70),
      width: size.width * 0.06,
      height: size.height * 0.05,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rightShoeRect, const Radius.circular(8)),
      shoePaint,
    );

    // Draw towel
    final towelPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final towelRect = Rect.fromCenter(
      center: Offset(womanCenter.dx - 15, womanCenter.dy + headRadius + 15),
      width: size.width * 0.08,
      height: size.height * 0.12,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(towelRect, const Radius.circular(8)),
      towelPaint,
    );

    // Draw OK gesture hand
    final handPaint = Paint()
      ..color = const Color(0xFFFFE0B2)
      ..style = PaintingStyle.fill;

    final handCenter = Offset(
      womanCenter.dx + 25,
      womanCenter.dy + headRadius + 10,
    );
    final handRadius = size.width * 0.04;
    canvas.drawCircle(handCenter, handRadius, handPaint);

    // Draw OK gesture circle
    final gesturePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final gestureCenter = Offset(handCenter.dx + 5, handCenter.dy - 5);
    final gestureRadius = size.width * 0.015;
    canvas.drawCircle(gestureCenter, gestureRadius, gesturePaint);
  }

  void _drawDecorativeLines(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw curved lines
    final path1 = Path();
    path1.moveTo(center.dx - 50, center.dy - 30);
    path1.quadraticBezierTo(
      center.dx,
      center.dy - 50,
      center.dx + 50,
      center.dy - 30,
    );
    canvas.drawPath(path1, linePaint);

    final path2 = Path();
    path2.moveTo(center.dx - 40, center.dy + 20);
    path2.quadraticBezierTo(
      center.dx,
      center.dy + 40,
      center.dx + 40,
      center.dy + 20,
    );
    canvas.drawPath(path2, linePaint);

    final path3 = Path();
    path3.moveTo(center.dx - 30, center.dy + 60);
    path3.quadraticBezierTo(
      center.dx,
      center.dy + 80,
      center.dx + 30,
      center.dy + 60,
    );
    canvas.drawPath(path3, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
