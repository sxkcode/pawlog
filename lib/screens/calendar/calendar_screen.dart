import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../constants/blueprint_colors.dart';
import '../../database/database.dart';
import '../../providers/calendar_provider.dart';
import '../../providers/event_provider.dart';
import 'day_timeline_screen.dart';

const _teal = Color(0xFF0F7173);

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focused = DateTime.now();
  DateTime? _selected;

  void _onDayTapped(DateTime day, DateTime focused) {
    final key = DateTime(day.year, day.month, day.day);
    final eventsMap = ref.read(calendarEventMapProvider);
    final hasEvents = eventsMap.containsKey(key);
    setState(() {
      _focused = focused;
      if (hasEvents) _selected = day;
    });
    if (!hasEvents || !mounted) return;
    final dayEvents = ref
        .read(eventListProvider)
        .where((EventWithPet e) {
          final d = e.timestamp;
          return d.year == day.year && d.month == day.month && d.day == day.day;
        })
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => DayTimelineScreen(date: day, events: dayEvents),
    ));
  }

  Widget _dot(Color c) => Container(
        width: 7,
        height: 7,
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );

  @override
  Widget build(BuildContext context) {
    final eventsMap = ref.watch(calendarEventMapProvider);

    return TableCalendar<String>(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focused,
      selectedDayPredicate: (day) =>
          _selected != null && isSameDay(_selected!, day),
      onDaySelected: _onDayTapped,
      onPageChanged: (focused) => setState(() => _focused = focused),
      eventLoader: (day) {
        final key = DateTime(day.year, day.month, day.day);
        return eventsMap[key] ?? [];
      },
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
            color: _teal, fontSize: 17, fontWeight: FontWeight.w600),
        leftChevronIcon: Icon(Icons.chevron_left, color: _teal),
        rightChevronIcon: Icon(Icons.chevron_right, color: _teal),
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration:
            const BoxDecoration(color: _teal, shape: BoxShape.circle),
        todayDecoration: BoxDecoration(
          color: _teal.withValues(alpha: 0.25),
          shape: BoxShape.circle,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (ctx, day, keys) {
          if (keys.isEmpty) return null;
          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: keys.take(4).map((k) => _dot(blueprintColor(k))).toList(),
            ),
          );
        },
      ),
    );
  }
}
