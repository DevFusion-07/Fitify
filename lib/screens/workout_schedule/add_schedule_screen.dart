import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  DateTime _date = DateTime.now();
  TimeOfDay _time = const TimeOfDay(hour: 15, minute: 0);
  String _workout = 'Upperbody Workout';
  String _difficulty = 'Beginner';
  int _reps = 12;
  int _weight = 0;

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      initialDate: _date,
    );
    if (d != null) setState(() => _date = d);
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: _time);
    if (t != null) setState(() => _time = t);
  }

  void _save() {
    final dt = DateTime(
      _date.year,
      _date.month,
      _date.day,
      _time.hour,
      _time.minute,
    );
    Navigator.pop(context, {'title': _workout, 'dateTime': dt});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Add Schedule',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(
              'Date',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '${_date.year}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')}',
              style: GoogleFonts.poppins(),
            ),
            onTap: _pickDate,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: Text(
              'Time',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(_time.format(context), style: GoogleFonts.poppins()),
            onTap: _pickTime,
          ),
          const SizedBox(height: 16),
          Text(
            'Details Workout',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _tile(
            icon: Icons.fitness_center,
            title: 'Choose Workout',
            trailing: Text(
              _workout,
              style: GoogleFonts.poppins(color: Colors.grey.shade600),
            ),
            onTap: () async {
              final v = await _pickFromList('Choose Workout', const [
                'Upperbody Workout',
                'Lowerbody Workout',
                'Ab Workout',
                'Fullbody Workout',
              ], _workout);
              if (v != null) setState(() => _workout = v);
            },
          ),
          const SizedBox(height: 8),
          _tile(
            icon: Icons.trending_up,
            title: 'Difficulty',
            trailing: Text(
              _difficulty,
              style: GoogleFonts.poppins(color: Colors.grey.shade600),
            ),
            onTap: () async {
              final v = await _pickFromList('Difficulty', const [
                'Beginner',
                'Intermediate',
                'Advanced',
              ], _difficulty);
              if (v != null) setState(() => _difficulty = v);
            },
          ),
          const SizedBox(height: 8),
          _tile(
            icon: Icons.repeat,
            title: 'Custom Repetitions',
            trailing: Text(
              '$_reps reps',
              style: GoogleFonts.poppins(color: Colors.grey.shade600),
            ),
            onTap: () async {
              final v = await _pickNumber(
                'Repetitions',
                _reps,
                min: 1,
                max: 200,
              );
              if (v != null) setState(() => _reps = v);
            },
          ),
          const SizedBox(height: 8),
          _tile(
            icon: Icons.fitness_center_outlined,
            title: 'Custom Weights',
            trailing: Text(
              _weight > 0 ? '$_weight kg' : 'Bodyweight',
              style: GoogleFonts.poppins(color: Colors.grey.shade600),
            ),
            onTap: () async {
              final v = await _pickNumber(
                'Weight (kg)',
                _weight,
                min: 0,
                max: 300,
              );
              if (v != null) setState(() => _weight = v);
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B73FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                'Save',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6B73FF)),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultTextStyle.merge(
              style: GoogleFonts.poppins(),
              child: trailing,
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Future<String?> _pickFromList(
    String title,
    List<String> options,
    String current,
  ) async {
    return showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(),
            ...options.map(
              (o) => ListTile(
                title: Text(o, style: GoogleFonts.poppins()),
                trailing: o == current
                    ? const Icon(Icons.check, color: Color(0xFF6B73FF))
                    : null,
                onTap: () => Navigator.pop(context, o),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<int?> _pickNumber(
    String title,
    int current, {
    required int min,
    required int max,
  }) async {
    int temp = current;
    final res = await showModalBottomSheet<int>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => setModalState(
                          () => temp = (temp - 1).clamp(min, max),
                        ),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(
                        '$temp',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () => setModalState(
                          () => temp = (temp + 1).clamp(min, max),
                        ),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, temp),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B73FF),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Select'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    return res;
  }
}
