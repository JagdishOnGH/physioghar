---
trigger: always_on
---

# PhysioGhar Therapist App — AI Build Guidelines

Flutter prototype. Therapist-side only. No backend — mock data + local state only. Riverpod for state.

## Stack

- Flutter (stable) + Dart
- State: Riverpod (StateNotifierProvider / NotifierProvider per domain)
- Fonts: google_fonts (Fraunces = headings/large numbers, Inter = body/buttons/labels, IBM Plex Mono = uppercase eyebrows)
- No auth, no network calls, no persistence required beyond in-memory app state

## Design tokens

```
primary       #2F5D50  Pine
secondary     #3F7965  Pine Light
bg-light      #D1E8DF  Pine Pale
bg-neutral    #EEF1ED  Mist
accent        #E2962F  Amber        (CTA/highlight only, use sparingly)
accent-pale   #FBEFD9  Amber Pale   (pending states)
bg-main       #FBFBF8  Cream
text-primary  #1E2A2E  Ink
text-secondary #4A5854 Ink Mid
text-muted    #8FA8A0  Ink Mute
error         #C84B4B  Danger
error-bg      #FCE8E8  Danger Pale
```

- Card radius: 16px. Buttons: pill-shaped. Min tap target: 44×44. Viewport: 390×844.
- OPEN/BOOKED/BLOCKED slot states must be distinguishable by color+shape, not color alone.

## Project structure

```
lib/
  core/
    theme/            # ThemeData, text styles, color tokens
    constants/         # enums (SlotStatus, RequestStatus, etc.)
    widgets/            # shared: SessionCard, StatusPill, EmptyState, PrimaryButton, BottomSheetWrapper
  data/
    models/             # Patient, Session, Slot, Request, Note, Complaint, TherapistProfile
    mock/               # seed data (mock_patients.dart, mock_sessions.dart, etc.)
  features/
    dashboard/
      dashboard_screen.dart
    schedule/
      schedule_screen.dart
      widgets/          # slot_tile.dart, slot_action_sheet.dart
    bookings/
      bookings_screen.dart   # tabbed: requests/upcoming/completed/cancelled
      widgets/
    patients/
      patient_list_screen.dart
      patient_detail_screen.dart
      widgets/          # note_card.dart, add_note_sheet.dart
    account/
      account_screen.dart
      profile_screen.dart
      edit_profile_screen.dart
    complaints/
      complaints_screen.dart
  providers/
    schedule_provider.dart
    booking_provider.dart
    patient_provider.dart
    profile_provider.dart
    locale_provider.dart
  main.dart
  router.dart           # go_router or Navigator 2.0, simple routes
```

## State domains (single source of truth — no per-screen duplicate state)

| Provider | Owns | Read by |
| --- | --- | --- |
| scheduleProvider | slots per day, availability bool | Dashboard, Schedule |
| bookingProvider | requests[], upcoming[], completed[], cancelled[] | Dashboard, Bookings |
| patientProvider | patients[], notes per patient | Patient List, Patient Detail |
| profileProvider | therapist fields, locale | Account, Profile, Edit Profile |

Dashboard and Account screens are READ-ONLY views into these — never fork local copies.

## Build phases (in order)

1. **Setup**: theme, fonts, folder scaffold, models, mock data seed, providers (empty logic ok)
2. **Schedule & Availability** ⭐ — slot list, OPEN/BOOKED/BLOCKED render, block/unblock mutation, add slot
3. **Bookings** ⭐ — tabs, Accept/Decline → list transitions, Complete → moves to completed, Reschedule
4. **Patients + Notes** ⭐ — list, detail, add/edit note with persistence across navigation
5. **Dashboard** — wire to already-built providers (toggle, cards, today's list)
6. **Account/Profile/Edit/Language** — form, save-reflects-immediately, 3-4 string locale swap
7. **Complaints** — form + success state
8. **Polish** — empty states, validation errors, README, APK build

⭐ = graded hardest. Do not shortcut these three.

## DO

- Every action that changes state must mutate the provider, not just close a dialog/sheet
- Reuse one SessionCard / StatusPill / EmptyState widget across screens — don't rebuild per screen
- Add empty state for every list (no sessions, no patients, no notes, no requests)
- Add basic validation on forms (Edit Profile, Complaints, Add Slot) — non-empty, basic email format
- Keep mock data in `data/mock/`, never hardcoded inline in widgets
- Confirm destructive/state-changing taps (block slot, decline request) via bottom sheet before committing
- Test the full required flow manually: Request → Accept → Upcoming → Complete → Completed
- Test notes persist after navigating away and back to Patient Detail

## DO NOT

- Do not add backend/API calls, auth, or real persistence (SharedPreferences optional at most, not required)
- Do not build screens/features not listed in the spec (no admin views, no payment, no chat)
- Do not translate the whole app for language toggle — 3-4 strings is sufficient
- Do not use Unicode sub/superscript chars anywhere (not applicable here but keep general hygiene)
- Do not create duplicate state per screen (e.g. local List<Slot> copy inside a StatefulWidget)
- Do not over-polish Account/Complaints at the expense of the 3 starred sections
- Do not skip loading/empty/error states — explicitly graded
- Do not use more than the specified fonts/colors — no ad hoc hex values

## Screens (10 total) — one-line purpose

1. Dashboard — today's snapshot + nav shortcuts
2. Schedule & Availability ⭐ — weekly slot management, block/unblock
3. Bookings ⭐ — Requests/Upcoming/Completed/Cancelled tabs
4. Patient List — directory
5. Patient Detail + Notes ⭐ — record + persistent notes
6. Account — settings menu
7. Profile (view) — read-only
8. Edit Profile — form, saves back to profile
9. Language — en/ne toggle, partial strings
10. Complaints — category+subject+description form, success state

## Deliverable checklist

- [ ] Source code (GitHub repo or ZIP)
- [ ] README: run instructions, Flutter/Dart version, packages, state mgmt rationale, folder structure, assumptions
- [ ] Debug/release APK
- [ ] Short write-up: state mgmt choice, mock data handling, architecture decisions, what you'd improve with more time
