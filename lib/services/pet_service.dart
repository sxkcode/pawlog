// Manages the in-memory list of pets and exposes CRUD operations. All DB
// writes are delegated to AppDatabase methods — this service never constructs
// SQL directly. NOT responsible for event data; it calls deleteEventsForPet
// before deleting a pet to satisfy the FK constraint, but the actual deletion
// logic lives in the database layer. NOT responsible for authentication or
// per-user filtering — Phase 1 treats all pets as belonging to a single user.
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database/database.dart';
import 'database_service.dart';

class PetService extends ChangeNotifier {
  final DatabaseService _svc;
  List<Pet> _pets = [];
  bool _loading = true;

  PetService(this._svc) {
    _load();
  }

  /// The current in-memory pet list, unordered.
  ///
  /// Safe to read synchronously from [build] methods.
  List<Pet> get pets => _pets;

  /// True until the first [_load] completes; false for all subsequent reads.
  ///
  /// Used by [petLoadingProvider] so screens can show a spinner instead of
  /// a misleading empty-state message before data arrives.
  bool get isLoading => _loading;

  Future<void> _load() async {
    try {
      _pets = await _svc.db.getPetsForUser();
    } catch (e, st) {
      debugPrint('PetService._load: $e\n$st');
    } finally {
      // Always clear the loading flag and notify, even on failure, so widgets
      // are never permanently stuck on a spinner.
      _loading = false;
      notifyListeners();
    }
  }

  /// Inserts a new pet and calls [notifyListeners].
  ///
  /// [birthdate] is stored as epoch milliseconds; [species] and [breed] are
  /// stored as null when the user leaves them blank.
  /// Throws on DB failure so the calling widget can reset its saving state.
  Future<void> addPet({
    required String name,
    String? species,
    String? breed,
    DateTime? birthdate,
  }) async {
    try {
      await _svc.db.insertPet(PetsCompanion(
        name: Value(name),
        species: Value(species),
        breed: Value(breed),
        birthdate: Value(birthdate?.millisecondsSinceEpoch),
      ));
      await _load();
    } catch (e, st) {
      debugPrint('PetService.addPet: $e\n$st');
      rethrow;
    }
  }

  /// Replaces all columns of the existing pet row and calls [notifyListeners].
  ///
  /// [pet] must be a Drift-generated [Pet] data class (e.g. from [pets] list
  /// or via [copyWith]). The [id] field on the object is used to identify the
  /// row to update; it is not modified.
  /// Throws on DB failure so the calling widget can reset its saving state.
  Future<void> updatePet(Pet pet) async {
    try {
      await _svc.db.updatePetById(pet);
      await _load();
    } catch (e, st) {
      debugPrint('PetService.updatePet: $e\n$st');
      rethrow;
    }
  }

  /// Deletes all events for [petId] then deletes the pet row itself.
  ///
  /// Events must be deleted first to satisfy the FK constraint on
  /// [Events.petId]. If the order were reversed, SQLite would either reject
  /// the pet deletion or (if PRAGMA foreign_keys is off) leave orphaned event
  /// rows. Calls [notifyListeners] after both deletes complete.
  /// Throws on DB failure so the calling widget can reset its saving state.
  Future<void> deletePet(int petId) async {
    try {
      await _svc.db.deleteEventsForPet(petId);
      await _svc.db.deletePetById(petId);
      await _load();
    } catch (e, st) {
      debugPrint('PetService.deletePet: $e\n$st');
      rethrow;
    }
  }

  /// Deletes all pets, events, and custom blueprints, then calls [notifyListeners].
  ///
  /// Delegates the actual deletes to [AppDatabase.clearAllData] which handles
  /// FK-safe ordering. After [_load], [pets] will be empty and all dependent
  /// providers will rebuild to their empty states.
  /// Throws on DB failure so the calling widget can handle the error.
  Future<void> clearAll() async {
    try {
      await _svc.db.clearAllData();
      await _load();
    } catch (e, st) {
      debugPrint('PetService.clearAll: $e\n$st');
      rethrow;
    }
  }

  /// Re-fetches pets from the database and calls [notifyListeners].
  Future<void> refresh() => _load();
}
