import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_schedule_screen.dart';

class WorkoutScheduleScreen extends StatefulWidget {
  const WorkoutScheduleScreen({super.key});

  static Future<void> open(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const WorkoutScheduleScreen()),
    );
  }

  @override
  State<WorkoutScheduleScreen> createState() => _WorkoutScheduleScreenState();
}

class _WorkoutScheduleScreenState extends State<WorkoutScheduleScreen> {
  final List<_ScheduleItem> _items = <_ScheduleItem>[
    _ScheduleItem(
      title: 'Ab Workout, 7:30am',
      dateTime: _todayAt(hour: 7, minute: 30),
      color: const Color(0xFFEEA5FF),
    ),
    _ScheduleItem(
      title: 'Upperbody Workout, 9am',
      dateTime: _todayAt(hour: 9),
      color: const Color(0xFFB5A7FF),
    ),
    _ScheduleItem(
      title: 'Lowerbody Workout, 3pm',
      dateTime: _todayAt(hour: 15),
      color: const Color(0xFFD6DDE8),
    ),
  ];

  DateTime _focused = DateTime.now();
  DateTime _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  static DateTime _todayAt({required int hour, int minute = 0}) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildMonthNavigator(),
            const SizedBox(height: 12),
            _buildDayChips(),
            const SizedBox(height: 8),
            Expanded(child: _buildTimeline()),
          ],
        ),
      ),
      floatingActionButton: _buildGradientFab(context),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _circleButton(Icons.arrow_back_ios, () => Navigator.pop(context)),
          Expanded(
            child: Center(
              child: Text(
                'Workout Schedule',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          _circleButton(Icons.more_horiz, () {}),
        ],
      ),
    );
  }

  Widget _buildMonthNavigator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.grey),
            onPressed: () => setState(
              () => _focused = DateTime(
                _focused.year,
                _focused.month - 1,
                _focused.day,
              ),
            ),
          ),
          Text(
            _monthLabel(_focused),
            style: GoogleFonts.poppins(color: Colors.grey.shade700),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Colors.grey),
            onPressed: () => setState(
              () => _focused = DateTime(
                _focused.year,
                _focused.month + 1,
                _focused.day,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayChips() {
    final now = _focused;
    final start = now.subtract(Duration(days: now.weekday % 7));
    final days = List<DateTime>.generate(
      7,
      (i) => DateTime(start.year, start.month, start.day + i),
    );

    return SizedBox(
      height: 80,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final d = days[i];
          final isSelected =
              d.day == _selectedDate.day &&
              d.month == _selectedDate.month &&
              d.year == _selectedDate.year;
          return Column(
            children: [
              Text(
                _weekdayShort(d.weekday),
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  setState(() {
                    _selectedDate = DateTime(d.year, d.month, d.day);
                  });
                },
                child: Container(
                  width: 56,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF6B73FF)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    '${d.day}',
                    style: GoogleFonts.poppins(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTimeline() {
    const startHour = 6;
    const endHour = 20;
    const rowHeight = 64.0;

    final visible = _items
        .where(
          (e) =>
              e.dateTime.year == _selectedDate.year &&
              e.dateTime.month == _selectedDate.month &&
              e.dateTime.day == _selectedDate.day,
        )
        .toList();

    final totalHeight = (endHour - startHour + 1) * rowHeight;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 120),
      child: SizedBox(
        height: totalHeight,
        child: Stack(
          children: [
            for (int i = 0; i <= endHour - startHour; i++)
              Positioned(
                top: i * rowHeight,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        _hourLabel(startHour + i),
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(height: 1, color: Colors.grey.shade200),
                  ],
                ),
              ),

            for (final e in visible)
              Positioned(
                top:
                    (((e.dateTime.hour - startHour) * 60 + e.dateTime.minute) *
                        (rowHeight / 60)) +
                    18,
                left: 96,
                right: 16,
                child: _eventPill(e.title, e.color),
              ),
          ],
        ),
      ),
    );
  }

  Widget _eventPill(String title, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.9),
            const Color(0xFF6B73FF).withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: Colors.black87, size: 18),
      ),
    );
  }

  Widget _buildGradientFab(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x886B73FF),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<dynamic>(
            context,
            MaterialPageRoute(builder: (_) => const AddScheduleScreen()),
          );
          if (result != null && result is Map) {
            final title = result['title'] as String? ?? 'Workout';
            final dt = result['dateTime'] as DateTime? ?? DateTime.now();
            setState(
              () => _items.add(
                _ScheduleItem(
                  title: title,
                  dateTime: dt,
                  color: const Color(0xFFB5A7FF),
                ),
              ),
            );
          }
        },
        backgroundColor: const Color(0xFF6B73FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  String _weekdayShort(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      default:
        return 'Sun';
    }
  }

  String _monthLabel(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  String _hourLabel(int hour24) {
    final h = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final ampm = hour24 >= 12 ? 'PM' : 'AM';
    return '${h.toString().padLeft(2, '0')}:00  $ampm';
  }
}

class _ScheduleItem {
  _ScheduleItem({
    required this.title,
    required this.dateTime,
    this.color = const Color(0xFFB5A7FF),
  });
  final String title;
  final DateTime dateTime;
  final Color color;
}
