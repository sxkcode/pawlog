import 'package:objectbox/objectbox.dart';
import 'pet.dart';

@Entity()
class Event {
  @Id()
  int id = 0;
  List<String> systemComponents;
  List<int> customBlueprintIds;
  @Property(type: PropertyType.date)
  DateTime timestamp;
  String loggedByName;
  String displayLabel;

  final pet = ToOne<Pet>();

  Event({
    required this.systemComponents,
    required this.customBlueprintIds,
    required this.timestamp,
    required this.loggedByName,
    required this.displayLabel,
  });
}
