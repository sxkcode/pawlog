# PetTracker

A Flutter app for logging and tracking pet care events (feeding, walks, bathroom, medication, etc.) across multiple users and pets.

## Stack
- **Frontend:** Flutter (iOS, Android, web)
- **Local DB:** ObjectBox
- **Auth/Sync (future):** Firebase Auth + Firestore — not yet implemented

## Project Structure
```
lib/
  models/          # ObjectBox entities
  services/
    objectbox.dart # Box init, singleton
    event_service.dart
    pet_service.dart
  screens/
    home/
      home_screen.dart
      widgets/
        event_card.dart
        event_fab.dart
        date_section_header.dart
    pets/
    calendar/
    settings/
  constants/
    system_blueprints.dart
  main.dart
```

## Key Conventions
- All new screens go under `lib/screens/`
- Widgets specific to a screen live in `screens/<screen>/widgets/`
- ObjectBox singleton initialized once in `main.dart`, passed via service
- `displayLabel` on Event is always generated at write time, never at render time
- System blueprint keys are always lowercase snake_case strings matching `SystemBlueprint` enum
- Components on composite blueprints are always sorted in canonical enum order before persisting

## Architecture
State management: [pick one — see below]
- All business logic lives in service classes under lib/services/
- Screens and widgets contain zero business logic — they call services 
  and render state only
- No business logic in constructors or initState()

## State Management
Use Riverpod (the `flutter_riverpod` package, with riverpod_annotation 
for code generation).

- All providers defined in lib/providers/
- Business logic and ObjectBox access in AsyncNotifier or Notifier 
  classes under lib/services/
- Widgets extend ConsumerWidget (stateless) or ConsumerStatefulWidget 
  (stateful) — never plain StatelessWidget/StatefulWidget unless the 
  widget has zero state dependencies
- Use ref.watch() to subscribe to state in build()
- Use ref.read() to call methods in callbacks (onPressed etc.)
- setState() only for purely local widget UI state (e.g. current step 
  in the FAB bottom sheet)
- Never access ObjectBox directly from a widget or build() method

## File size rules
- If a file exceeds 200 lines, refactor before adding more code
- One widget per file
- No widget file should contain more than one StatefulWidget

## Do Not
- Do not add Firebase or any network calls yet — local only for now
- Do not use `BuildContext` across async gaps without mounted checks
- Do not store computed/derived values in ObjectBox except `displayLabel`
- Do not use setState() for anything shared across screens
- Do not put database calls directly in widget build() methods
- Do not duplicate logic — if something is needed in two places, 
  it goes in a service

## Reference Docs
See @docs/data-model.md for full entity definitions and relationships.
See @docs/features.md for full feature specs and UX flows.

## Dependencies
- A new sqlite3.wasm must be downloaded if sqlite3 is updated in pubspec.yaml and the .wasm must match the version in the pubspec.lock
- A new drift_worker.js must be downloaded if drift is updated in pubspec.yaml and the .js must match the version in the pubspec.lock
