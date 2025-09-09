import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/styled_dropdown.dart';
import 'package:provider/provider.dart';
import '../../providers/activity_provider.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDateOfBirth;
  bool _isWeightInKg = true;
  bool _isHeightInFeet = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final user = authProvider.user;

      if (user != null) {
        _nameController.text = user.name;
        _emailController.text = user.email;
        // Convert gender to lowercase to match dropdown values
        final gender = user.gender?.toLowerCase();
        if (gender == 'male' || gender == 'female' || gender == 'other') {
          _selectedGender = gender;
        } else {
          _selectedGender = null;
        }
        _selectedDateOfBirth = user.dateOfBirth;

        if (user.weight != null) {
          _weightController.text = user.weight.toString();
        }
        if (user.height != null) {
          final cm = user.height!;
          // Use inches when _isHeightInFeet=false; allow switching to feet later
          _heightController.text =
              (_isHeightInFeet
                      ? (cm / 30.48).toStringAsFixed(1)
                      : (cm / 2.54).toStringAsFixed(0))
                  .toString();
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
      // Set default values if there's an error
      _nameController.text = '';
      _emailController.text = '';
      _selectedGender = null;
      _selectedDateOfBirth = null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _selectDateOfBirth() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDateOfBirth ??
          DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6B73FF),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
      });
    }
  }

  Widget _buildWeightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weight',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your weight',
                  suffixText: _isWeightInKg ? 'kg' : 'lbs',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF6B73FF)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid weight';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            _buildUnitToggle(),
          ],
        ),
      ],
    );
  }

  Widget _buildHeightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Height',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: _isHeightInFeet
                      ? 'Enter height in inches'
                      : 'Enter height in cm',
                  suffixText: _isHeightInFeet ? 'in' : 'cm',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF6B73FF)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid height';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            _buildHeightUnitToggle(),
          ],
        ),
      ],
    );
  }

  Widget _buildUnitToggle() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => setState(() => _isWeightInKg = true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _isWeightInKg
                    ? const Color(0xFF6B73FF)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'KG',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _isWeightInKg ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _isWeightInKg = false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: !_isWeightInKg
                    ? const Color(0xFF6B73FF)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'LBS',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: !_isWeightInKg ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeightUnitToggle() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                // Convert current value to cm based on current unit
                final raw = double.tryParse(_heightController.text);
                double cm = 0;
                if (raw != null) {
                  cm = _isHeightInFeet ? raw * 30.48 : raw * 2.54;
                }
                _isHeightInFeet = false;
                // Display inches
                _heightController.text = (cm / 2.54).toStringAsFixed(0);
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: !_isHeightInFeet
                    ? const Color(0xFF6B73FF)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'CM',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: !_isHeightInFeet ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                final raw = double.tryParse(_heightController.text);
                double cm = 0;
                if (raw != null) {
                  cm = _isHeightInFeet ? raw * 30.48 : raw * 2.54;
                }
                _isHeightInFeet = true;
                // Display decimal feet
                _heightController.text = (cm / 30.48).toStringAsFixed(1);
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _isHeightInFeet
                    ? const Color(0xFF6B73FF)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'IN',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _isHeightInFeet ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Convert weight to kg if needed
      double? weight = double.tryParse(_weightController.text);
      if (weight != null && !_isWeightInKg) {
        weight = weight * 0.453592; // Convert lbs to kg
      }

      // Convert height to cm if needed
      double? height = double.tryParse(_heightController.text);
      if (height != null) {
        if (_isHeightInFeet) {
          // Decimal feet to cm
          height = height * 30.48;
        } else {
          // Inches to cm
          height = height * 2.54;
        }
      }

      final success = await authProvider.updateProfile(
        name: _nameController.text,
        gender: _selectedGender,
        dateOfBirth: _selectedDateOfBirth,
        weight: weight,
        height: height,
      );

      if (mounted) {
        if (success) {
          // Sync ActivityProvider with updated values
          final activity = context.read<ActivityProvider>();
          activity.updateHeightWeight(heightCm: height, weightKg: weight);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Personal data updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error updating personal data: ${authProvider.error ?? "Unknown error"}',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating personal data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Personal Data',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Information Section
                  CommonCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Information',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Name Field
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF6B73FF),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Email Field (Read-only)
                        TextFormField(
                          controller: _emailController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF6B73FF),
                              ),
                            ),
                            suffixIcon: const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Gender Dropdown
                        StyledDropdown<String>(
                          value: _selectedGender,
                          hintText: 'Gender',
                          items: const [
                            DropdownMenuItem(
                              value: 'male',
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: 'female',
                              child: Text('Female'),
                            ),
                            DropdownMenuItem(
                              value: 'other',
                              child: Text('Other'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Date of Birth Field
                        GestureDetector(
                          onTap: _selectDateOfBirth,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  _selectedDateOfBirth != null
                                      ? '${_selectedDateOfBirth!.day}/${_selectedDateOfBirth!.month}/${_selectedDateOfBirth!.year}'
                                      : 'Date of Birth',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: _selectedDateOfBirth != null
                                        ? Colors.black87
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Physical Information Section
                  CommonCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Physical Information',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),

                        _buildWeightField(),
                        const SizedBox(height: 20),
                        _buildHeightField(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: CommonButton(
                      text: 'Save Changes',
                      onPressed: _handleSave,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
