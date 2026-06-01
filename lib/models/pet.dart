import 'package:objectbox/objectbox.dart';
import 'event.dart';
import 'custom_blueprint.dart';

@Entity()
class Pet {
  @Id()
  int id = 0;
  String name;
  String? species;
  String? breed;
  @Property(type: PropertyType.date)
  DateTime? birthdate;
  String? photoPath;

  @Backlink('pet')
  final events = ToMany<Event>();

  @Backlink('pet')
  final customBlueprints = ToMany<CustomBlueprint>();

  Pet({required this.name, this.species, this.breed, this.birthdate, this.photoPath});
}
