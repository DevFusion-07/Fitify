import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/responsive_utils.dart';

class AddAlarmScreen extends StatefulWidget {
  const AddAlarmScreen({super.key});

  @override
  State<AddAlarmScreen> createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends State<AddAlarmScreen> {
  TimeOfDay bedtime = const TimeOfDay(hour: 21, minute: 0); // 9:00 PM
  String sleepDuration = '8hours 30minutes';
  String repeatSchedule = 'Mon to Fri';
  bool vibrateEnabled = true;

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.getResponsivePadding(
      context,
      const EdgeInsets.all(16),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Alarm',
          style: GoogleFonts.poppins(
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: padding,
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildBedtimeCard(),
            const SizedBox(height: 16),
            _buildHoursOfSleepCard(),
            const SizedBox(height: 16),
            _buildRepeatCard(),
            const SizedBox(height: 16),
            _buildVibrateCard(),
            const SizedBox(height: 40),
            _buildAddButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBedtimeCard() {
    return _buildConfigurationCard(
      icon: Icons.bed,
      title: 'Bedtime',
      value: _formatTimeOfDay(bedtime),
      onTap: () => _selectBedtime(),
    );
  }

  Widget _buildHoursOfSleepCard() {
    return _buildConfigurationCard(
      icon: Icons.access_time,
      title: 'Hours of sleep',
      value: sleepDuration,
      onTap: () => _selectSleepDuration(),
    );
  }

  Widget _buildRepeatCard() {
    return _buildConfigurationCard(
      icon: Icons.repeat,
      title: 'Repeat',
      value: repeatSchedule,
      onTap: () => _selectRepeatSchedule(),
    );
  }

  Widget _buildVibrateCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.vibration,
              color: Colors.purple.shade600,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Vibrate When Alarm Sound',
              style: GoogleFonts.poppins(
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Switch(
            value: vibrateEnabled,
            onChanged: (value) {
              setState(() {
                vibrateEnabled = value;
              });
            },
            activeColor: Colors.purple.shade400,
            activeTrackColor: Colors.purple.shade200,
          ),
        ],
      ),
    );
  }

  Widget _buildConfigurationCard({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.purple.shade600, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () => _addAlarm(),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.purple.shade400],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Add',
            style: GoogleFonts.poppins(
              fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  Future<void> _selectBedtime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: bedtime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.purple.shade400,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != bedtime) {
      setState(() {
        bedtime = picked;
      });
    }
  }

  void _selectSleepDuration() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Sleep Duration',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            ...[
              '7hours 30minutes',
              '8hours',
              '8hours 30minutes',
              '9hours',
              '9hours 30minutes',
            ].map(
              (duration) => ListTile(
                title: Text(duration, style: GoogleFonts.poppins()),
                onTap: () {
                  setState(() {
                    sleepDuration = duration;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectRepeatSchedule() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Repeat Schedule',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            ...[
              'Never',
              'Mon to Fri',
              'Every day',
              'Weekends only',
              'Custom',
            ].map(
              (schedule) => ListTile(
                title: Text(schedule, style: GoogleFonts.poppins()),
                onTap: () {
                  setState(() {
                    repeatSchedule = schedule;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addAlarm() {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Alarm added successfully!',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    // Navigate back
    Navigator.pop(context);
  }
}
