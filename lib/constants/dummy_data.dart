class DummyEvent {
  final String petName;
  final String displayLabel;
  final DateTime timestamp;
  final String loggedByName;

  const DummyEvent({
    required this.petName,
    required this.displayLabel,
    required this.timestamp,
    required this.loggedByName,
  });
}

// Today = 2026-06-01, yesterday = 2026-05-31, older = 2026-05-28 (Thursday)
final List<DummyEvent> dummyEvents = [
  DummyEvent(
    petName: 'Sarge',
    displayLabel: 'pooped and peed',
    timestamp: DateTime(2026, 6, 1, 8, 15),
    loggedByName: 'SK',
  ),
  DummyEvent(
    petName: 'Winnie',
    displayLabel: 'went for a walk',
    timestamp: DateTime(2026, 6, 1, 7, 45),
    loggedByName: 'Emily',
  ),
  DummyEvent(
    petName: 'Sarge',
    displayLabel: 'took medication',
    timestamp: DateTime(2026, 5, 31, 21, 0),
    loggedByName: 'SK',
  ),
  DummyEvent(
    petName: 'Winnie',
    displayLabel: 'pooped',
    timestamp: DateTime(2026, 5, 31, 18, 30),
    loggedByName: 'Emily',
  ),
  DummyEvent(
    petName: 'Sarge',
    displayLabel: 'played',
    timestamp: DateTime(2026, 5, 31, 15, 15),
    loggedByName: 'Jake',
  ),
  DummyEvent(
    petName: 'Sarge',
    displayLabel: 'went for a walk and played',
    timestamp: DateTime(2026, 5, 28, 11, 0),
    loggedByName: 'SK',
  ),
  DummyEvent(
    petName: 'Winnie',
    displayLabel: 'pooped and peed',
    timestamp: DateTime(2026, 5, 28, 8, 30),
    loggedByName: 'Emily',
  ),
];
