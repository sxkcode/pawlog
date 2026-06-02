import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database/database.dart';
import 'database_service.dart';

class PetService extends ChangeNotifier {
  final DatabaseService _svc;
  List<Pet> _pets = [];

  PetService(this._svc) {
    _load();
  }

  List<Pet> get pets => _pets;

  Future<void> _load() async {
    _pets = await _svc.db.getPetsForUser();
    notifyListeners();
  }

  Future<void> addPet({
    required String name,
    String? species,
    String? breed,
    DateTime? birthdate,
  }) async {
    await _svc.db.insertPet(PetsCompanion(
      name: Value(name),
      species: Value(species),
      breed: Value(breed),
      birthdate: Value(birthdate?.millisecondsSinceEpoch),
    ));
    await _load();
  }

  Future<void> updatePet(Pet pet) async {
    await _svc.db.updatePetById(pet);
    await _load();
  }

  Future<void> deletePet(int petId) async {
    await _svc.db.deleteEventsForPet(petId);
    await _svc.db.deletePetById(petId);
    await _load();
  }
}
