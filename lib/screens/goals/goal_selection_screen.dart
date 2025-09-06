import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/welcome_screen.dart';

class GoalSelectionScreen extends StatefulWidget {
  const GoalSelectionScreen({super.key});

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  int selectedGoalIndex = 0;

  final List<GoalData> goals = [
    GoalData(
      title: "Improve Shape",
      description:
          "I have a low amount of body fat and need / want to build more muscle",
      imagePath: 'assets/images/signup_login/improve_shape.png',
    ),
    GoalData(
      title: "Lean & Tone",
      description:
          "I'm \"skinny fat\". look thin but have no shape. I want to add learn muscle in the right way",
      imagePath: 'assets/images/signup_login/lean_and_tone.png',
    ),
    GoalData(
      title: "Lose a Fat",
      description:
          "I have over 20 lbs to lose. I want to drop all this fat and gain muscle mass",
      imagePath: 'assets/images/signup_login/lose_fat.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildHeader(),
            const SizedBox(height: 40),
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    selectedGoalIndex = index;
                  });
                },
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return _buildGoalCard(goals[index], index);
                },
              ),
            ),
            _buildConfirmButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            "What is your goal ?",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "It will help us to choose a best program for you",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(GoalData goal, int index) {
    final isSelected = selectedGoalIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [Color(0xFF6B73FF), Color(0xFF8B5CF6)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  : null,
              color: isSelected ? null : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.asset(
                    goal.imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          size: 60,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF6B73FF),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  goal.title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  width: 40,
                  height: 2,
                  color: isSelected ? Colors.white : Colors.transparent,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    goal.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isSelected
                          ? Colors.white.withOpacity(0.9)
                          : Colors.grey.shade600,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _handleConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6B73FF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            "Confirm",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _handleConfirm() {
    // TODO: Save selected goal
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(userName: "User"),
      ),
    );
  }
}

class GoalData {
  final String title;
  final String description;
  final String imagePath;

  GoalData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
