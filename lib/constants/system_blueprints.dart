enum SystemBlueprint { poop, pee, walk, medication, play, training }

String buildDisplayLabel(List<String> systemKeys, {List<String> customNames = const []}) {
  final parts = [
    ...SystemBlueprint.values
        .where((b) => systemKeys.contains(b.name))
        .map(_labelFor),
    ...customNames,
  ];

  if (parts.isEmpty) return '';
  if (parts.length == 1) return parts.first;
  if (parts.length == 2) return '${parts[0]} and ${parts[1]}';

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
