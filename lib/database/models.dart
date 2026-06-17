// Plain Dart DTOs that cross the service/UI boundary without carrying
// Drift-generated types. Keeping these types separate means screens and
// providers can import models.dart instead of database.dart, which prevents
// accidental direct DB access in widget files and reduces compile-time
// coupling to the Drift code-gen output. NOT responsible for persistence —
// these are read-only value objects produced by query methods in database.dart.

/// Flattened read-model produced by the Events ✕ Pets JOIN in
/// [AppDatabase.getAllEventsSortedByTimestamp].
///
/// All fields are denormalized from their respective table rows so widgets
/// never need to perform their own joins or hold references to Drift row
/// objects. Instances are created once by the database layer and consumed
/// read-only by [EventService] and the UI.
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
