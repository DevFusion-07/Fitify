import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../goals/goal_selection_screen.dart';
import '../../providers/auth_provider.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  String? selectedGender;
  String? selectedWeight;
  String? selectedHeight;
  DateTime? selectedDateOfBirth;
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  bool isWeightInKg = true;
  bool isHeightInFeet = false; // false = inches, true = feet

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              _buildIllustration(),
              const SizedBox(height: 32),
              _buildTitle(),
              const SizedBox(height: 40),
              _buildGenderField(),
              const SizedBox(height: 20),
              _buildDateOfBirthField(),
              const SizedBox(height: 20),
              _buildWeightField(),
              const SizedBox(height: 20),
              _buildHeightField(),
              const SizedBox(height: 40),
              _buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Image.asset(
        'assets/images/signup_login/complete_your_profile.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFF6B73FF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.fitness_center,
              size: 80,
              color: Color(0xFF6B73FF),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          "Let's complete your profile",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "It will help us to know more about you!",
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildGenderField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.people_outline, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedGender,
                hint: Text(
                  "Choose Gender",
                  style: GoogleFonts.poppins(color: Colors.grey.shade600),
                ),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: "Male", child: Text("Male")),
                  DropdownMenuItem(value: "Female", child: Text("Female")),
                  DropdownMenuItem(value: "Other", child: Text("Other")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDateOfBirthField() {
    return GestureDetector(
      onTap: _selectDateOfBirth,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedDateOfBirth != null
                    ? "${selectedDateOfBirth!.day}/${selectedDateOfBirth!.month}/${selectedDateOfBirth!.year}"
                    : "Date of Birth",
                style: GoogleFonts.poppins(
                  color: selectedDateOfBirth != null
                      ? Colors.black87
                      : Colors.grey.shade600,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateOfBirth() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDateOfBirth) {
      setState(() {
        selectedDateOfBirth = picked;
      });
    }
  }

  Widget _buildWeightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Weight',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            _buildUnitToggle(
              isKg: isWeightInKg,
              onToggle: (value) {
                setState(() {
                  isWeightInKg = value;
                  // Convert weight if needed
                  if (_weightController.text.isNotEmpty) {
                    final currentWeight = double.tryParse(
                      _weightController.text,
                    );
                    if (currentWeight != null) {
                      if (isWeightInKg) {
                        // Convert from pounds to kg
                        _weightController.text = (currentWeight * 0.453592)
                            .toStringAsFixed(1);
                      } else {
                        // Convert from kg to pounds
                        _weightController.text = (currentWeight * 2.20462)
                            .toStringAsFixed(1);
                      }
                    }
                  }
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.monitor_weight_outlined, color: Colors.grey),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: isWeightInKg
                        ? "Your Weight (kg)"
                        : "Your Weight (lbs)",
                    hintStyle: GoogleFonts.poppins(color: Colors.grey.shade600),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Height',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            _buildHeightUnitToggle(
              isFeet: isHeightInFeet,
              onToggle: (value) {
                setState(() {
                  isHeightInFeet = value;
                  // Convert height if needed
                  if (_heightController.text.isNotEmpty) {
                    final currentHeight = double.tryParse(
                      _heightController.text,
                    );
                    if (currentHeight != null) {
                      if (isHeightInFeet) {
                        // Convert from inches to feet
                        _heightController.text = (currentHeight / 12)
                            .toStringAsFixed(1);
                      } else {
                        // Convert from feet to inches
                        _heightController.text = (currentHeight * 12)
                            .toStringAsFixed(0);
                      }
                    }
                  }
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.height, color: Colors.grey),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: isHeightInFeet
                        ? "Your Height (ft)"
                        : "Your Height (in)",
                    hintStyle: GoogleFonts.poppins(color: Colors.grey.shade600),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnitToggle({
    required bool isKg,
    required Function(bool) onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => onToggle(true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isKg ? const Color(0xFF6B73FF) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'KG',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isKg ? Colors.white : Colors.grey[600],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onToggle(false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: !isKg ? const Color(0xFF6B73FF) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'LBS',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: !isKg ? Colors.white : Colors.grey[600],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeightUnitToggle({
    required bool isFeet,
    required Function(bool) onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => onToggle(false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: !isFeet ? const Color(0xFF6B73FF) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'IN',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: !isFeet ? Colors.white : Colors.grey[600],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onToggle(true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isFeet ? const Color(0xFF6B73FF) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'FT',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isFeet ? Colors.white : Colors.grey[600],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _handleNext,
        icon: const Icon(Icons.arrow_forward),
        label: Text(
          "Next",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B73FF),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _handleNext() async {
    if (selectedGender != null &&
        selectedDateOfBirth != null &&
        _weightController.text.isNotEmpty &&
        _heightController.text.isNotEmpty) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final weight = double.tryParse(_weightController.text);
      final height = double.tryParse(_heightController.text);

      if (weight == null || height == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter valid weight and height"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Convert to standard units (kg and cm) before saving
      double finalWeight = weight;
      double finalHeight = height;

      if (!isWeightInKg) {
        // Convert pounds to kg
        finalWeight = weight * 0.453592;
      }

      if (isHeightInFeet) {
        // Convert feet to inches, then to cm
        finalHeight = height * 12 * 2.54;
      } else {
        // Convert inches to cm
        finalHeight = height * 2.54;
      }

      final success = await authProvider.updateProfile(
        gender: selectedGender,
        dateOfBirth: selectedDateOfBirth,
        weight: finalWeight,
        height: finalHeight,
      );

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GoalSelectionScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.error ?? "Failed to save profile"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }
}
