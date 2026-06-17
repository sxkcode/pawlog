// Drift AppDatabase — defines the three SQLite tables (Pets, Events,
// CustomBlueprints), configures the database connection (WASM on web, native
// SQLite on mobile/desktop), and exposes raw query methods consumed exclusively
// by lib/services/. NOT responsible for business logic, display-label
// generation, in-memory caching, or notifying Riverpod listeners — those
// concerns belong in the service layer. Schema version is 1; any column
// additions will require a MigrationStrategy entry here.
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'drift_converters.dart';
import 'models.dart';
export 'models.dart' show EventWithPet;

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
// Database
// ---------------------------------------------------------------------------

@DriftDatabase(tables: [Pets, Events, CustomBlueprints])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _connect());

  /// Configures the database connection.
  ///
  /// On web, Drift attempts to use a shared worker with SharedArrayBuffer for
  /// the best concurrency. If the page is not served with the required COOP/COEP
  /// headers (common in local dev), it falls back to [sharedIndexedDb] —
  /// functionally equivalent but single-threaded. The [onResult] callback logs
  /// which implementation was chosen and why.
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

  /// Returns every event joined with its pet, ordered newest-first.
  ///
  /// Produces [EventWithPet] DTOs so callers receive a flat, Drift-free
  /// object rather than raw table rows. The JOIN is an INNER JOIN, so events
  /// whose pet has been deleted (which shouldn't occur given the service-layer
  /// delete order) would be silently excluded.
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

  /// Returns all pets, unordered.
  Future<List<Pet>> getPetsForUser() => select(pets).get();

  /// Inserts a new pet row and returns the new row's integer ID.
  Future<int> insertPet(PetsCompanion companion) =>
      into(pets).insert(companion);

  /// Replaces all columns of the pet row matching [pet.id].
  ///
  /// [toCompanion(false)] produces a companion that omits the primary key
  /// from the SET clause — the correct Drift idiom for UPDATE-by-ID.
  Future<void> updatePetById(Pet pet) async {
    await (update(pets)..where((t) => t.id.equals(pet.id)))
        .write(pet.toCompanion(false));
  }

  /// Deletes all events belonging to [petId].
  ///
  /// Must be called before [deletePetById] to satisfy the FK constraint on
  /// [Events.petId].
  Future<int> deleteEventsForPet(int petId) =>
      (delete(events)..where((t) => t.petId.equals(petId))).go();

  /// Deletes the pet row with the given [petId].
  ///
  /// Caller is responsible for deleting related events first via
  /// [deleteEventsForPet]; see [PetService.deletePet].
  Future<int> deletePetById(int petId) =>
      (delete(pets)..where((t) => t.id.equals(petId))).go();

  /// Inserts a new event row and returns the new row's integer ID.
  Future<int> insertEvent(EventsCompanion companion) =>
      into(events).insert(companion);

  /// Deletes all rows from every table.
  ///
  /// Order matters: events and customBlueprints reference pets via FK, so
  /// they must be deleted before pets to avoid a constraint violation.
  Future<void> clearAllData() async {
    await delete(events).go();
    await delete(customBlueprints).go();
    await delete(pets).go();
  }
}
