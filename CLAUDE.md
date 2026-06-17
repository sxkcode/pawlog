# Pawlog

A Flutter app for logging and tracking pet care events across multiple users and pets.

## Stack
- **Frontend:** Flutter (iOS, Android, web)
- **Local DB:** Drift (drift_flutter) — SQLite on mobile/desktop, WASM on web
- **State:** Riverpod (flutter_riverpod)
- **Auth/Sync:** Firebase Auth + Firestore — not yet implemented

## Platform Targets
iOS, Android, web (Chrome). Never use ObjectBox — removed due to no web support.

## Project Structure
```
lib/
  database/
    database.dart         # Drift AppDatabase, table definitions
    drift_converters.dart # List<String>/List<int> ↔ JSON, DateTime ↔ int
  services/
    database_service.dart # Drift singleton
    event_service.dart    # ChangeNotifier
    pet_service.dart      # ChangeNotifier
    profile_service.dart  # ChangeNotifier, display name via shared_preferences
    theme_service.dart    # ChangeNotifier, ThemeMode via shared_preferences
  providers/
    event_provider.dart
    pet_provider.dart
    profile_provider.dart
    theme_provider.dart
    nav_provider.dart
  screens/
    home/
      home_screen.dart
      widgets/
        event_card.dart
        event_fab.dart
        date_section_header.dart
    pets/
      pets_screen.dart
      pet_detail_screen.dart
    calendar/
      calendar_screen.dart
      day_timeline_screen.dart
    settings/
      settings_screen.dart
    profile/
      profile_screen.dart
  constants/
    system_blueprints.dart # SystemBlueprint enum, buildDisplayLabel()
    blueprint_colors.dart  # Per-activity colors
  main.dart
```

## Architecture Rules
- Business logic and DB access live in `lib/services/` only — never in widgets or build()
- Widgets extend ConsumerWidget or ConsumerStatefulWidget
- Use ref.watch() in build(), ref.read() in callbacks
- setState() only for local widget UI state (e.g. FAB step index)
- Services are ChangeNotifier classes exposed via ChangeNotifierProvider
- All providers defined in lib/providers/
- One widget per file, max 200 lines per file — refactor before adding more

## Conventions
- New screens → `lib/screens/`, screen-specific widgets → `screens/<screen>/widgets/`
- displayLabel generated at write time only, never at render time
- SystemBlueprint keys are lowercase snake_case matching the enum in system_blueprints.dart
- Blueprint components always sorted in canonical enum order before persisting
- List<String> and List<int> stored as JSON via Drift type converters
- DateTime stored as epoch milliseconds via Drift type converter

## Do Not
- No Firebase or network calls yet — local only
- No BuildContext across async gaps without mounted checks
- No duplicate logic — shared logic goes in a service
- No direct Drift/DB access in widgets

## Web Dependencies
When upgrading packages, versions must stay in sync:
- sqlite3.wasm (in web/) must match the sqlite3 version in pubspec.lock
- drift_worker.js (in web/) must match the drift version in pubspec.lock

## Color Palette
| Role | Color |
|---|---|
| Primary / top bar | #0F7173 |
| Background | #E7ECEF |
| Surface / cards | #FFFFFF |
| Bottom nav | #272932 |
| FAB / primary action | #F05D5E |
| Pet avatars / accent | #D8A47F |
| Text primary | #272932 |

## Activity Colors (lib/constants/blueprint_colors.dart)
| Activity | Color |
|---|---|
| Poop | #8B6914 |
| Pee | #F5C842 |
| Walk | #0F7173 |
| Medication | #9B59B6 |
| Play | #F05D5E |
| Training | #2ECC71 |

## Deferred Features
- Pet and profile photos
- Dark mode palette (ThemeMode toggle exists but uses ThemeData.dark() placeholder)
- Push notifications / FCM
- Firebase Auth + Firestore sync (Phase 2)
- Multi-user invite flow (Phase 2)
- Role display on Pets screen + conditional edit/delete controls (Phase 2)
- Account/credential management (Phase 2)

## Phase 2 Notes
Role system: three tiers per pet — Parent, Relative, Sitter.
See @docs/features.md for permission table.
At least one Parent must exist per pet (enforced in app logic).
When Phase 2 begins, role chip should appear on each Pets list item,
and PetDetailScreen edit/delete should gate on role.

## Reference Docs
See @docs/data-model.md for entity definitions.
See @docs/features.md for feature specs and UX flows.