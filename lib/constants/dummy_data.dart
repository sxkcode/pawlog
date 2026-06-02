import 'package:drift/drift.dart';
import '../database/database.dart';
import '../services/database_service.dart';

// ---------------------------------------------------------------------------
// Seed — called once on first launch when the DB is empty.
// ---------------------------------------------------------------------------

Future<void> seedDatabase(DatabaseService svc) async {
  final sargeId = await svc.db.insertPet(
    PetsCompanion(name: const Value('Sarge')),
  );
  final winnieId = await svc.db.insertPet(
    PetsCompanion(name: const Value('Winnie')),
  );

  final rows = [
    _evt(sargeId, 'pooped and peed', ['poop', 'pee'], DateTime(2026, 6, 1, 8, 15), 'SK'),
    _evt(winnieId, 'went for a walk', ['walk'], DateTime(2026, 6, 1, 7, 45), 'Emily'),
    _evt(sargeId, 'took medication', ['medication'], DateTime(2026, 5, 31, 21, 0), 'SK'),
    _evt(winnieId, 'pooped', ['poop'], DateTime(2026, 5, 31, 18, 30), 'Emily'),
    _evt(sargeId, 'played', ['play'], DateTime(2026, 5, 31, 15, 15), 'Jake'),
    _evt(sargeId, 'went for a walk and played', ['walk', 'play'], DateTime(2026, 5, 28, 11, 0), 'SK'),
    _evt(winnieId, 'pooped and peed', ['poop', 'pee'], DateTime(2026, 5, 28, 8, 30), 'Emily'),
  ];

  for (final row in rows) {
    await svc.db.insertEvent(row);
  }
}

EventsCompanion _evt(
  int petId,
  String displayLabel,
  List<String> systemComponents,
  DateTime timestamp,
  String loggedByName,
) {
  return EventsCompanion(
    petId: Value(petId),
    systemComponents: Value(systemComponents),
    customBlueprintIds: const Value([]),
    timestamp: Value(timestamp),
    loggedByName: Value(loggedByName),
    displayLabel: Value(displayLabel),
  );
}
