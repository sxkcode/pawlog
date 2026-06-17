enum SystemBlueprint { poop, pee, walk, medication, play, training }

/// Builds the human-readable event label stored on each [Event] row.
///
/// [systemKeys] are [SystemBlueprint] enum names (e.g. `"poop"`, `"pee"`).
/// [customNames] are the display names of any included custom blueprints.
///
/// The label is generated at write time and stored verbatim — it is never
/// recomputed at render time, so changing this function does not affect
/// previously logged events.
String buildDisplayLabel(List<String> systemKeys, {List<String> customNames = const []}) {
  final parts = [
    // Iterate SystemBlueprint.values (not systemKeys directly) to enforce
    // canonical enum order: poop → pee → walk → medication → play → training.
    // This guarantees "pooped and peed" never becomes "peed and pooped"
    // regardless of the order keys arrive in.
    ...SystemBlueprint.values
        .where((b) => systemKeys.contains(b.name))
        .map(_labelFor),
    // Custom blueprint names are appended after system labels, in the order
    // they were passed by the caller.
    ...customNames,
  ];

  if (parts.isEmpty) return '';
  if (parts.length == 1) return parts.first;
  if (parts.length == 2) return '${parts[0]} and ${parts[1]}';

  // Oxford comma for three or more items: "pooped, peed, and went for a walk".
  final allButLast = parts.sublist(0, parts.length - 1).join(', ');
  return '$allButLast, and ${parts.last}';
}

String _labelFor(SystemBlueprint b) => switch (b) {
      SystemBlueprint.poop => 'pooped',
      SystemBlueprint.pee => 'peed',
      SystemBlueprint.walk => 'went for a walk',
      SystemBlueprint.medication => 'took medication',
      SystemBlueprint.play => 'played',
      SystemBlueprint.training => 'did training',
    };
