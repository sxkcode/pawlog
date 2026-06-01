import 'package:objectbox/objectbox.dart';
import 'pet.dart';

@Entity()
class CustomBlueprint {
  @Id()
  int id = 0;
  String name;
  String? iconKey;
  // JSON: [{"type":"system","key":"poop"}, ...]
  String componentsJson;

  final pet = ToOne<Pet>();

  CustomBlueprint({required this.name, this.iconKey, required this.componentsJson});
}
