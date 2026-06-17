// Manages the in-memory cache of logged events and owns the write path for
// creating new events. Responsible for enforcing canonical sort order of
// blueprint keys before writing, so that displayLabel is always generated
// consistently regardless of the order a user taps activity checkboxes.
// NOT responsible for date grouping, display formatting, or calendar
// aggregation — those transformations happen in the UI or provider layer.
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../constants/system_blueprints.dart';
import '../database/database.dart';
import 'database_service.dart';

class EventService extends ChangeNotifier {
  final DatabaseService _svc;
  List<EventWithPet> _events = [];
  bool _loading = true;

  EventService(this._svc) {
    _load();
  }

  /// The current in-memory event list, ordered newest-first.
  ///
  /// Safe to read synchronously from [build] methods — the list is populated
  /// during construction and updated after every write.
  List<EventWithPet> get events => _events;

  /// True until the first [_load] completes; false for all subsequent reads.
  ///
  /// Used by [eventLoadingProvider] so screens can show a spinner instead of
  /// a misleading empty-state message before data arrives.
  bool get isLoading => _loading;

  Future<void> _load() async {
    try {
      _events = await _svc.db.getAllEventsSortedByTimestamp();
    } catch (e, st) {
      debugPrint('EventService._load: $e\n$st');
    } finally {
      // Always clear the loading flag and notify, even on failure, so widgets
      // are never permanently stuck on a spinner.
      _loading = false;
      notifyListeners();
    }
  }

  /// Re-fetches all events from the database and calls [notifyListeners].
  ///
  /// Called externally after destructive operations (e.g. clear-all in
  /// Settings) to force dependent providers to drain their cached lists.
  Future<void> refresh() => _load();

  /// Synchronous alias for [events]; returns the cached list without a DB hit.
  List<EventWithPet> allEventsSorted() => _events;

  /// Writes one [Event] row per pet in [petIds] for the selected activities.
  ///
  /// [systemComponentKeys] are the [SystemBlueprint] enum names (e.g.
  /// `"poop"`, `"pee"`) that the user selected. They are re-sorted here by
  /// canonical enum order before writing, so that [displayLabel] is stable
  /// regardless of the order the user tapped the checkboxes.
  ///
  /// [now] is captured once before the insert loop so every pet in the same
  /// logging action receives the identical timestamp — the home screen groups
  /// events by pet, not by timestamp, so this keeps them visually cohesive.
  ///
  /// Throws on DB failure so the calling widget can reset its saving state.
  /// Calls [notifyListeners] after all inserts via [_load].
  Future<void> logEvents({
    required List<String> systemComponentKeys,
    required List<int> petIds,
    String loggedByName = 'Me',
  }) async {
    try {
      // Re-order keys to match the canonical SystemBlueprint enum sequence.
      // This guarantees "pooped and peed" never becomes "peed and pooped".
      final sorted = SystemBlueprint.values
          .where((b) => systemComponentKeys.contains(b.name))
          .map((b) => b.name)
          .toList();
      final label = buildDisplayLabel(sorted);
      final now = DateTime.now();
      for (final petId in petIds) {
        await _svc.db.insertEvent(EventsCompanion(
          petId: Value(petId),
          systemComponents: Value(sorted),
          customBlueprintIds: const Value([]),
          timestamp: Value(now),
          loggedByName: Value(loggedByName),
          displayLabel: Value(label),
        ));
      }
      await _load();
    } catch (e, st) {
      debugPrint('EventService.logEvents: $e\n$st');
      rethrow;
    }
  }
}
