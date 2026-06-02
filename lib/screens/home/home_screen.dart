import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/database.dart';
import '../../providers/event_provider.dart';
import 'widgets/date_section_header.dart';
import 'widgets/event_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventListProvider);

    if (events.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.pets, size: 72, color: Color(0xFFD8A47F)),
            SizedBox(height: 16),
            Text(
              'No events yet.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF272932),
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Tap + to log your first event.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    final items = _buildListItems(events);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 88),
      itemCount: items.length,
      itemBuilder: (_, i) => items[i],
    );
  }

  static List<Widget> _buildListItems(List<EventWithPet> events) {
    // Query is already sorted descending; group by calendar date.
    final Map<DateTime, List<EventWithPet>> byDate = {};
    for (final e in events) {
      final day = DateTime(e.timestamp.year, e.timestamp.month, e.timestamp.day);
      (byDate[day] ??= []).add(e);
    }

    final sortedDates = byDate.keys.toList()..sort((a, b) => b.compareTo(a));

    final items = <Widget>[];
    for (final date in sortedDates) {
      items.add(DateSectionHeader(date: date));
      for (final event in byDate[date]!) {
        items.add(EventCard(event: event));
      }
    }
    return items;
  }
}
