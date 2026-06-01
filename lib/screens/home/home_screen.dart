import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/dummy_data.dart';
import '../../providers/event_provider.dart';
import 'widgets/date_section_header.dart';
import 'widgets/event_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventListProvider);
    final items = _buildListItems(events);

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 88),
      itemCount: items.length,
      itemBuilder: (_, i) => items[i],
    );
  }

  static List<Widget> _buildListItems(List<DummyEvent> events) {
    // Sort descending by timestamp
    final sorted = [...events]..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    // Group by calendar date
    final Map<DateTime, List<DummyEvent>> byDate = {};
    for (final e in sorted) {
      final day = DateTime(e.timestamp.year, e.timestamp.month, e.timestamp.day);
      (byDate[day] ??= []).add(e);
    }

    // Dates are already in descending order from the sorted list
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
