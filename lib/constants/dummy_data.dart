import 'package:drift/drift.dart';
import '../database/database.dart';
import '../services/database_service.dart';

// ---------------------------------------------------------------------------
// Seed — called once on first launch when the DB is empty.
// ---------------------------------------------------------------------------

Future<void> seedDatabase(DatabaseService svc) async {
  final shebaId = await svc.db.insertPet(
    PetsCompanion(name: const Value('Sheba')),
  );
  final ladooId = await svc.db.insertPet(
    PetsCompanion(name: const Value('Ladoo')),
  );

  final rows = [
    _evt(shebaId, 'pooped and peed', ['poop', 'pee'], DateTime(2026, 6, 1, 8, 15), 'SK'),
    _evt(ladooId, 'went for a walk', ['walk'], DateTime(2026, 6, 1, 7, 45), 'Sarah'),
    _evt(shebaId, 'took medication', ['medication'], DateTime(2026, 5, 31, 21, 0), 'SK'),
    _evt(ladooId, 'pooped', ['poop'], DateTime(2026, 5, 31, 18, 30), 'Sarah'),
    _evt(shebaId, 'played', ['play'], DateTime(2026, 5, 31, 15, 15), 'Sarah'),
    _evt(shebaId, 'went for a walk and played', ['walk', 'play'], DateTime(2026, 5, 28, 11, 0), 'SK'),
    _evt(ladooId, 'pooped and peed', ['poop', 'pee'], DateTime(2026, 5, 28, 8, 30), 'Sarah'),
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
