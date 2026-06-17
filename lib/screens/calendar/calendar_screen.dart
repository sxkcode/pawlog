import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../constants/app_colors.dart';
import '../../constants/blueprint_colors.dart';
import '../../database/database.dart';
import '../../providers/calendar_provider.dart';
import '../../providers/event_provider.dart';
import 'day_timeline_screen.dart';

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
            color: AppColors.primary, fontSize: 17, fontWeight: FontWeight.w600),
        leftChevronIcon: Icon(Icons.chevron_left, color: AppColors.primary),
        rightChevronIcon: Icon(Icons.chevron_right, color: AppColors.primary),
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration:
            const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
        todayDecoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.25),
          shape: BoxShape.circle,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (ctx, day, keys) {
          if (keys.isEmpty) return null;
          // `keys` here are the deduplicated activity key strings produced by
          // calendarEventMapProvider (e.g. ["poop", "walk"]) — at most one
          // entry per activity type per day regardless of how many events were
          // logged. take(4) caps the dot count so a day with many activity
          // types doesn't overflow the cell width.
          //
          // bottom: 2 shifts the row below table_calendar's day-number circle;
          // without it the dots overlap the number.
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
