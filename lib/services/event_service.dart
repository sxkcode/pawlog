import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../constants/system_blueprints.dart';
import '../database/database.dart';
import 'database_service.dart';

class EventService extends ChangeNotifier {
  final DatabaseService _svc;
  List<EventWithPet> _events = [];

  EventService(this._svc) {
    _load();
  }

  List<EventWithPet> get events => _events;

  Future<void> _load() async {
    _events = await _svc.db.getAllEventsSortedByTimestamp();
    notifyListeners();
  }

  Future<void> refresh() => _load();

  List<EventWithPet> allEventsSorted() => _events;

  Future<void> logEvents({
    required List<String> systemComponentKeys,
    required List<int> petIds,
  }) async {
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
        loggedByName: const Value('Me'),
        displayLabel: Value(label),
      ));
    }
    await _load();
  }
}
