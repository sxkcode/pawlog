# Features & UX Flows

## Home Screen

Reverse-chronological timeline of events for all pets the user is associated with.

- Grouped by date: "Today", "Yesterday", then specific dates (e.g. "Tuesday, May 15")
- One card per pet per logging action
- Cards are NOT merged across pets (Sheba and Winnie get separate cards even if logged together)
- Bottom nav bar: Home | My Pets | Calendar | Settings

### Event Card Layout
```
[ Pet photo ]  {Pet name} {displayLabel}
               {time} · by {loggedByName}
```
Example: "Sheba pooped and peed — 4:32 PM · by Sarah"

---

## FAB (Floating Action Button) — Log Event Flow

Large circle (+) button, bottom-right above the nav bar.

### Step 1: Select Events (bottom sheet slides up)
- Checkbox list of all system blueprints (Poop, Pee, Walk, Medication, Play, Training)
- Checkbox list of pet-specific custom blueprints below, if any exist
- Must select at least one before proceeding
- NEXT → button

### Step 2: Select Pets (same bottom sheet, replaces content)
- Checkbox list of all pets the user is associated with (any role)
- Multi-select allowed
- Must select at least one before confirming
- ← BACK button and DONE ✓ button

### On DONE:
- Timestamp = current time (moment user taps DONE)
- One Event record written per selected pet
- Each Event contains all selected components (same for every pet)
- `displayLabel` generated once at write time using canonical sort order
- Bottom sheet dismisses
- New cards appear at top of timeline immediately

---

## User Roles (per pet)

Three tiers — enforced in app logic for PoC, in Firestore Security Rules later.

| Permission                        | Parent | Relative | Sitter |
|-----------------------------------|--------|----------|--------|
| Log events                        | ✅     | ✅       | ✅     |
| Create/edit custom blueprints     | ✅     | ✅       | ❌     |
| Edit pet details                  | ✅     | ❌       | ❌     |
| Delete pet                        | ✅     | ❌       | ❌     |
| Invite/manage users               | ✅     | ❌       | ❌     |
| At least one must exist per pet   | ✅     | —        | —      |

---

## Custom Blueprints

- Created per-pet by Parents and Relatives
- Can be simple (e.g. "swam", "napped") or composite (e.g. "Bathroom + Play" = poop + pee + walk + play)
- Components are system blueprints only — no nested custom blueprints in PoC
- Stored as JSON in `CustomBlueprint.componentsJson`
- Appear below system blueprints in the Step 1 event selection list

---

## Deferred / Future Features
- Firebase Auth + Firestore sync
- Retroactive timestamp entry ("this happened 2 hours ago")
- Optional notes field per event
- Calendar view
- Push notifications / reminders (FCM)
- Multi-user invite flow (link or code)
- Pet photo from camera/gallery
