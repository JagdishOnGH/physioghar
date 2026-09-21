# PhysioGhar Therapist App

PhysioGhar is a mobile application prototype built with Flutter for physical therapists. It provides a therapist-focused workflow for managing patient appointments, weekly schedules, clinical notes, practitioner profiles, and support complaints—all within a responsive design system.

---

## Technical Specifications & Environment

- **Flutter SDK**: `3.38.5` (Configured via [FVM](https://fvm.app/))
- **Dart SDK**: `^3.10.4` (`3.10.x`)
- **State Management**: [Flutter Riverpod](https://pub.dev/packages/flutter_riverpod) (`NotifierProvider`)
- **Typography**: [Google Fonts](https://pub.dev/packages/google_fonts) (`Fraunces`, `Inter`, `IBM Plex Mono`)
- **Formatting & Utilities**: [intl](https://pub.dev/packages/intl) (`^0.19.0`), [cupertino_icons](https://pub.dev/packages/cupertino_icons) (`^1.0.8`)

---

## App Features & 10 Screen Pages

The app contains 10 screen pages accessible via main navigation tabs or the **Catalog Launcher** (floating action button):

1. **Home Dashboard** (`lib/features/dashboard/pages/dashboard_page.dart`): Quick snapshot of today's upcoming sessions, pending request counters, and one-tap emergency availability toggle.
2. **Schedule & Availability** (`lib/features/schedule/pages/schedule_page.dart`): Weekly slot management displaying `OPEN`, `BOOKED`, and `BLOCKED` slots. Supports slot blocking, unblocking, and adding new custom slots.
3. **Bookings & Sessions** (`lib/features/bookings/pages/bookings_page.dart`): Tabbed management interface for:
   - **Requests**: Accept or Decline incoming patient bookings.
   - **Upcoming**: View accepted sessions, reschedule, or mark sessions as complete with optional clinical remarks.
   - **Completed**: Archive of completed session history and remarks.
   - **Cancelled**: History of declined or cancelled requests.
4. **Patient Directory** (`lib/features/patients/pages/patient_list_page.dart`): Searchable directory of all registered patients with condition summaries and visit counts.
5. **Patient Detail & Notes** (`lib/features/patients/pages/patient_detail_page.dart`): Full patient medical record with persistent clinical notes. Supports adding, editing, and categorizing notes (`Assessment`, `Rehab Goal`, `Treatment`, `Clinical Progress`).
6. **Account Settings** (`lib/features/account/pages/account_page.dart`): Main navigation menu for profile settings, language toggle, support reporting, and session logout.
7. **Profile View** (`lib/features/account/pages/profile_page.dart`): Read-only view of the therapist profile, rating, years of experience, and clinical specializations.
8. **Edit Profile** (`lib/features/account/pages/edit_profile_page.dart`): Form with live input validation for updating name, title, contact details, address, and specializations back to state.
9. **Language Settings** (`lib/features/account/pages/language_page.dart`): Toggle between English (`en`) and Nepali (`ne`) localization for core app terms.
10. **Report an Issue / Complaints** (`lib/features/complaints/pages/complaints_page.dart`): Support ticket creation form with category selection, subject line, description validation, and submission confirmation state.

---

## Project Architecture & Folder Structure

The project follows a feature-first and single-responsibility file organization pattern:

```
lib/
├── core/
│   ├── constants/
│   │   └── enums.dart               # SlotStatus, RequestStatus, ComplaintCategory
│   ├── theme/
│   │   └── app_theme.dart           # AppColors palette, ThemeData, Typography tokens
│   └── widgets/
│       ├── shared_widgets.dart      # SessionCard, StatusPill, EmptyState, PrimaryButton
│       └── screen_launcher.dart     # 10-screen catalog bottom sheet launcher
├── data/
│   ├── mock/
│   │   ├── mock_notes.dart          # Seed clinical notes
│   │   ├── mock_patients.dart       # Seed patient directory
│   │   ├── mock_profile.dart        # Seed therapist profile
│   │   ├── mock_sessions.dart       # Seed session bookings
│   │   ├── mock_slots.dart          # Seed schedule slots
│   │   └── mock_data.dart           # Aggregating MockData interface
│   └── models/
│       ├── patient.dart             # Patient domain entity
│       ├── patient_note.dart        # Clinical note entity
│       ├── session_booking.dart     # Booking session entity
│       ├── slot.dart                # Time slot entity
│       ├── therapist_profile.dart   # Profile entity
│       ├── ticket_complaint.dart    # Complaint ticket entity
│       └── models.dart              # Barrel export for models
├── features/
│   ├── account/
│   │   └── pages/
│   │       ├── account_page.dart
│   │       ├── edit_profile_page.dart
│   │       ├── language_page.dart
│   │       └── profile_page.dart
│   ├── bookings/
│   │   └── pages/
│   │       └── bookings_page.dart
│   ├── complaints/
│   │   └── pages/
│   │       └── complaints_page.dart
│   ├── dashboard/
│   │   └── pages/
│   │       └── dashboard_page.dart
│   ├── patients/
│   │   └── pages/
│   │       ├── patient_detail_page.dart
│   │       └── patient_list_page.dart
│   ├── schedule/
│   │   └── pages/
│   │       └── schedule_page.dart
│   ├── pages/
│   │   └── pages.dart               # Master screen export barrel
│   └── pages.dart                   # Root features barrel export
├── providers/
│   ├── booking_provider.dart        # BookingState & BookingNotifier
│   ├── locale_provider.dart         # AppLocale & LocaleNotifier (en/ne)
│   ├── patient_provider.dart        # PatientState & PatientNotifier
│   ├── profile_provider.dart        # ProfileNotifier
│   ├── schedule_provider.dart       # ScheduleState & ScheduleNotifier
│   └── providers.dart               # Barrel export for all providers
└── main.dart                        # MainShellScreen & bottom navigation bar
```

---

## State Management Rationale

State is managed strictly using **Riverpod** with `NotifierProvider` and `Notifier`:

- **Single Source of Truth**: Data for schedule, bookings, patients, and profile reside exclusively in `lib/providers/`. Screens subscribe to providers via `ref.watch()` or select sub-state via `ref.watch(provider.select(...))`.
- **Zero Local Duplication**: Screens do not maintain parallel local lists. All user actions (e.g., Accepting a request, editing profile fields, adding notes, blocking slots) invoke methods on the provider, triggering UI updates across screens.
- **In-Memory State**: Built to demonstrate realistic client-side state flow without external network dependencies.

---

## Design System & Styling Rules

- **Palette**:
  - **Pine (Primary)**: `#2F5D50`
  - **Pine Light**: `#3F7965`
  - **Pine Pale**: `#D1E8DF`
  - **Amber (Accent/CTA)**: `#E2962F`
  - **Cream (Main BG)**: `#FBFBF8`
  - **Ink (Text Primary)**: `#1E2A2E`
  - **Ink Mid (Text Secondary)**: `#4A5854`
- **Typography**:
  - **Headings & Numbers**: `Fraunces`
  - **Body, Buttons, & Labels**: `Inter`
  - **Eyebrows & Badges**: `IBM Plex Mono`
- **Visual Hygiene**:
  - Card Border Radius: `16px`
  - Pill-shaped Buttons (`StadiumBorder`)
  - Min Tap Target: `44×44px`
  - State Differentiation: `OPEN`, `BOOKED`, and `BLOCKED` slots differ by both color and shape/icon for visual accessibility.

---

## How to Run the Project

### Prerequisites
- [Flutter SDK 3.38.5](https://docs.flutter.dev/get-started/install)
- [FVM (Flutter Version Management)](https://fvm.app/) *(Recommended)*

### Installation Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/JagdishOnGH/physioghar.git
   cd physioghar
   ```

2. **Setup Flutter Version (with FVM)**:
   ```bash
   fvm install 3.38.5
   fvm use 3.38.5
   ```

3. **Install Dependencies**:
   ```bash
   fvm flutter pub get
   ```

4. **Run Code Analysis**:
   ```bash
   fvm flutter analyze
   ```

5. **Launch Application**:
   ```bash
   fvm flutter run
   ```

*(If FVM is not installed, you can replace `fvm flutter` with standard `flutter` commands using Flutter 3.38.5).*

---

## Best Practices & Standard Development Hygiene

- **Code Comments**: Kept clean and uncluttered according to strict project guidelines.
- **Form Validation**: Non-empty checks and format validation on Edit Profile, Complaints, and Add Slot forms.
- **Confirmation Flow**: State-changing actions (e.g., declining requests, blocking slots) use bottom sheet dialog confirmations before committing.
- **Empty & Loading States**: Explicit fallback views provided when lists (patients, sessions, notes, requests) are empty.

---

## Future Improvements & Architectural Roadmap

### 1. Declarative Routing (`go_router` & Code Generator)
- **Type-Safe Navigation**: Replace basic imperative `Navigator.push` calls with [`go_router`](https://pub.dev/packages/go_router) and `go_router_builder` code generation.
- **Deep Linking & Web Support**: Enable URL-driven navigation, route guards for authentication, and state-preserving tab navigation shell routes.

### 2. Clean Architecture Layer Segregation
For enterprise scalability, the codebase can be refactored into a strict 3-tier Clean Architecture:
- **Data Layer**: Contains API clients, Data Sources (Remote & Local Database via Hive/Isar), Data Transfer Objects (DTOs), and Repository Implementations. Responsible for converting raw JSON or DB rows into Domain Entities.
- **Domain Layer**: The core business logic layer. Contains pure Dart **Entities**, **Use Cases / Interactors** (e.g., `AcceptBookingUseCase`, `AddPatientNoteUseCase`), and abstract **Repository Interfaces**. Free of any Flutter or UI dependencies.
- **Presentation Layer**: UI Widgets, Screen Pages (`lib/features/[feat]/pages/`), and Riverpod `StateNotifierProvider` state managers. Consumes Use Cases and exposes immutable UI state to reactive Flutter components.

### 3. Localization & Language Support (English & Nepali)
- **ARB Translation Source**: Localized strings are stored in standard ARB format inside `lib/l10n/`:
  - [`lib/l10n/app_en.arb`](file:///g:/flatter_project/physioghar/lib/l10n/app_en.arb) — English strings template.
  - [`lib/l10n/app_ne.arb`](file:///g:/flatter_project/physioghar/lib/l10n/app_ne.arb) — Nepali translations.
- **Where to Expect Translated Text**: Selecting **Nepali** or **English** in the **Language Settings** screen (`lib/features/account/pages/language_page.dart`) dynamically updates:
  - Account & Settings menu labels (`Account Settings`, `Therapist Profile`, `Language Settings`, `Report an Issue`, `Log Out`).
  - Screen page headers, selection options, and interactive action feedback toasts.
- **Code Access**: Strings are accessed in UI widgets via generated `AppLocalizations.of(context)!.keyName`.

### 4. Backend Integration & Real-Time Sync
- **REST / GraphQL APIs**: OAuth2 / JWT user authentication and backend database integration.
- **Real-Time WebSockets**: Live incoming booking request alerts and instant patient messaging.
- **Push Notifications**: Firebase Cloud Messaging (FCM) integration for session reminders.