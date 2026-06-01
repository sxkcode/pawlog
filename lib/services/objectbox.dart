import '../objectbox.g.dart';
import '../models/pet.dart';
import '../models/event.dart';
import '../models/custom_blueprint.dart';

class ObjectBoxService {
  final Store store;

  ObjectBoxService._create(this.store);

  static Future<ObjectBoxService> create() async {
    final store = await openStore();
    return ObjectBoxService._create(store);
  }

  Box<Pet> get petBox => store.box<Pet>();
  Box<Event> get eventBox => store.box<Event>();
  Box<CustomBlueprint> get customBlueprintBox => store.box<CustomBlueprint>();
}
