import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'drift_converters.dart';

part 'database.g.dart';

// ---------------------------------------------------------------------------
// Table definitions
// ---------------------------------------------------------------------------

class Pets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get species => text().nullable()();
  TextColumn get breed => text().nullable()();
  IntColumn get birthdate => integer().nullable()(); // epoch ms; null = unknown
  TextColumn get photoPath => text().nullable()();
}

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id)();
  TextColumn get systemComponents =>
      text().map(const StringListConverter())();
  TextColumn get customBlueprintIds =>
      text().map(const IntListConverter())();
  IntColumn get timestamp =>
      integer().map(const DateTimeConverter())();
  TextColumn get loggedByName => text()();
  TextColumn get displayLabel => text()();
}

class CustomBlueprints extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id)();
  TextColumn get name => text()();
  TextColumn get iconKey => text().nullable()();
  TextColumn get componentsJson => text()();
}

// ---------------------------------------------------------------------------
// Join result DTO used by the UI layer
// ---------------------------------------------------------------------------

class EventWithPet {
  final int id;
  final String petName;
  final String displayLabel;
  final DateTime timestamp;
  final String loggedByName;
  final List<String> systemComponents;
  final List<int> customBlueprintIds;

  const EventWithPet({
    required this.id,
    required this.petName,
    required this.displayLabel,
    required this.timestamp,
    required this.loggedByName,
    required this.systemComponents,
    required this.customBlueprintIds,
  });
}

// ---------------------------------------------------------------------------
// Database
// ---------------------------------------------------------------------------

@DriftDatabase(tables: [Pets, Events, CustomBlueprints])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _connect());

  static QueryExecutor _connect() {
    return driftDatabase(
      name: 'pawlog_db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
        onResult: (result) {
          if (result.missingFeatures.isNotEmpty) {
            debugPrint(
              'Drift web using ${result.chosenImplementation} '
              'due to unsupported features: ${result.missingFeatures}',
            );
          }
        },
      ),
    );
  }

  @override
  int get schemaVersion => 1;

  // Returns all events joined with their pet, newest first.
  Future<List<EventWithPet>> getAllEventsSortedByTimestamp() async {
    final query = select(events).join([
      innerJoin(pets, pets.id.equalsExp(events.petId)),
    ])
      ..orderBy([OrderingTerm.desc(events.timestamp)]);

    return (await query.get()).map((row) {
      final e = row.readTable(events);
      final p = row.readTable(pets);
      return EventWithPet(
        id: e.id,
        petName: p.name,
        displayLabel: e.displayLabel,
        timestamp: e.timestamp,
        loggedByName: e.loggedByName,
        systemComponents: e.systemComponents,
        customBlueprintIds: e.customBlueprintIds,
      );
    }).toList();
  }

  Future<List<Pet>> getPetsForUser() => select(pets).get();

  Future<int> insertPet(PetsCompanion companion) =>
      into(pets).insert(companion);

  Future<void> updatePetById(Pet pet) async {
    await (update(pets)..where((t) => t.id.equals(pet.id)))
        .write(pet.toCompanion(false));
  }

  Future<int> deleteEventsForPet(int petId) =>
      (delete(events)..where((t) => t.petId.equals(petId))).go();

  Future<int> deletePetById(int petId) =>
      (delete(pets)..where((t) => t.id.equals(petId))).go();

  Future<int> insertEvent(EventsCompanion companion) =>
      into(events).insert(companion);
}
