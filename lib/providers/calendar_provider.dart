import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import 'event_provider.dart';

/// Date (midnight-normalised) → distinct system-blueprint keys logged that day.
/// Drives calendar dot markers and auto-updates when new events are logged.
final calendarEventMapProvider = Provider<Map<DateTime, List<String>>>((ref) {
  final events = ref.watch(eventListProvider);
  final map = <DateTime, List<String>>{};
  for (final EventWithPet e in events) {
    final day = DateTime(e.timestamp.year, e.timestamp.month, e.timestamp.day);
    final keys = map.putIfAbsent(day, () => []);
    for (final k in e.systemComponents) {
      if (!keys.contains(k)) keys.add(k);
    }
  }
  return map;
});
