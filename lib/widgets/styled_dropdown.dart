import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final Color primaryColor;
  final EdgeInsetsGeometry contentPadding;

  const StyledDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText,
    this.primaryColor = const Color(0xFF6B73FF),
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 6,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      icon: const Icon(Icons.keyboard_arrow_down, size: 18),
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
        isDense: true,
        contentPadding: contentPadding,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: primaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
      borderRadius: BorderRadius.circular(16),
      dropdownColor: Colors.white,
    );
  }
}
