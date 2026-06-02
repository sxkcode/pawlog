import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database/database.dart';
import 'database_service.dart';

class PetService extends ChangeNotifier {
  final DatabaseService _svc;

  PetService(this._svc);

  Future<List<Pet>> allPets() => _svc.db.getPetsForUser();

  Future<void> addPet({required String name, String? species, String? breed}) async {
    await _svc.db.insertPet(PetsCompanion(
      name: Value(name),
      species: Value(species),
      breed: Value(breed),
    ));
    notifyListeners();
  }

  Future<void> deletePet(int id) async {
    await (_svc.db.delete(_svc.db.pets)..where((t) => t.id.equals(id))).go();
    notifyListeners();
  }
}
