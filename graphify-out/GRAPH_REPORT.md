# Graph Report - physioghar  (2026-09-21)

## Corpus Check
- 61 files · ~60,108 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 487 nodes · 467 edges · 45 communities (36 shown, 9 thin omitted)
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 8 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `cd08bfda`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]
- [[_COMMUNITY_Community 13|Community 13]]
- [[_COMMUNITY_Community 14|Community 14]]
- [[_COMMUNITY_Community 15|Community 15]]
- [[_COMMUNITY_Community 16|Community 16]]
- [[_COMMUNITY_Community 17|Community 17]]
- [[_COMMUNITY_Community 18|Community 18]]
- [[_COMMUNITY_Community 19|Community 19]]
- [[_COMMUNITY_Community 20|Community 20]]
- [[_COMMUNITY_Community 21|Community 21]]
- [[_COMMUNITY_Community 22|Community 22]]
- [[_COMMUNITY_Community 23|Community 23]]
- [[_COMMUNITY_Community 24|Community 24]]
- [[_COMMUNITY_Community 25|Community 25]]
- [[_COMMUNITY_Community 26|Community 26]]
- [[_COMMUNITY_Community 27|Community 27]]
- [[_COMMUNITY_Community 28|Community 28]]
- [[_COMMUNITY_Community 29|Community 29]]
- [[_COMMUNITY_Community 30|Community 30]]
- [[_COMMUNITY_Community 31|Community 31]]
- [[_COMMUNITY_Community 32|Community 32]]
- [[_COMMUNITY_Community 33|Community 33]]
- [[_COMMUNITY_Community 34|Community 34]]
- [[_COMMUNITY_Community 35|Community 35]]
- [[_COMMUNITY_Community 36|Community 36]]
- [[_COMMUNITY_Community 37|Community 37]]
- [[_COMMUNITY_Community 38|Community 38]]

## God Nodes (most connected - your core abstractions)
1. `PhysioGhar Therapist App — AI Build Guidelines` - 10 edges
2. `WindowClassRegistrar` - 7 edges
3. `Create()` - 7 edges
4. `Destroy()` - 7 edges
5. `MessageHandler()` - 5 edges
6. `AppDelegate` - 4 edges
7. `OnCreate()` - 4 edges
8. `WndProc()` - 4 edges
9. `GetClientArea()` - 4 edges
10. `handle_new_rx_page()` - 3 edges

## Surprising Connections (you probably didn't know these)
- `my_application_activate()` --calls--> `fl_register_plugins()`  [INFERRED]
  linux/runner/my_application.cc → linux/flutter/generated_plugin_registrant.cc
- `main()` --calls--> `my_application_new()`  [INFERRED]
  linux/runner/main.cc → linux/runner/my_application.cc
- `OnCreate()` --calls--> `RegisterPlugins()`  [INFERRED]
  windows/runner/flutter_window.cpp → windows/flutter/generated_plugin_registrant.cc
- `OnCreate()` --calls--> `GetClientArea()`  [INFERRED]
  windows/runner/flutter_window.cpp → windows/runner/win32_window.cpp
- `OnCreate()` --calls--> `SetChildContent()`  [INFERRED]
  windows/runner/flutter_window.cpp → windows/runner/win32_window.cpp

## Communities (45 total, 9 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.06
Nodes (32): ../data/mock/mock_data.dart, ../core/constants/enums.dart, ../data/models/models.dart, package:flutter_riverpod/flutter_riverpod.dart, accept, addNote, addSlot, blockSlot (+24 more)

### Community 1 - "Community 1"
Cohesion: 0.10
Nodes (22): RegisterPlugins(), OnCreate(), Create(), Destroy(), EnableFullDpiSupportIfAvailable(), GetClientArea(), GetThisFromHandle(), GetWindowClass() (+14 more)

### Community 2 - "Community 2"
Cohesion: 0.08
Nodes (24): ../../core/constants/enums.dart, ../../core/theme/app_theme.dart, ../../core/widgets/shared_widgets.dart, ../../data/models/models.dart, package:flutter/material.dart, package:flutter_riverpod/flutter_riverpod.dart, package:google_fonts/google_fonts.dart, ../../providers/providers.dart (+16 more)

### Community 3 - "Community 3"
Cohesion: 0.08
Nodes (23): features/account/account_screen.dart, features/bookings/bookings_screen.dart, features/dashboard/dashboard_screen.dart, features/patients/patient_list_screen.dart, features/schedule/schedule_screen.dart, AccountScreen, BookingsScreen, build (+15 more)

### Community 4 - "Community 4"
Cohesion: 0.09
Nodes (22): BookingsScreen, _BookingsScreenState, build, _buildSessionListView, dispose, EmptyState, initState, Scaffold (+14 more)

### Community 5 - "Community 5"
Cohesion: 0.09
Nodes (21): ../account/profile_screen.dart, build, _buildShortcutTile, _buildSummaryCard, DashboardScreen, EmptyState, Function, GestureDetector (+13 more)

### Community 6 - "Community 6"
Cohesion: 0.10
Nodes (20): build, _buildContactRow, _buildSectionTitle, _buildStatItem, Column, Container, Divider, Icon (+12 more)

### Community 7 - "Community 7"
Cohesion: 0.10
Nodes (20): build, _buildFieldLabel, _buildFormView, _buildSuccessView, ComplaintsScreen, _ComplaintsScreenState, Container, dispose (+12 more)

### Community 8 - "Community 8"
Cohesion: 0.09
Nodes (21): ../../core/theme/app_theme.dart, ../../core/widgets/shared_widgets.dart, ../../data/models/models.dart, package:flutter/material.dart, package:flutter_riverpod/flutter_riverpod.dart, package:google_fonts/google_fonts.dart, package:intl/intl.dart, ../../providers/providers.dart (+13 more)

### Community 9 - "Community 9"
Cohesion: 0.09
Nodes (21): AccountScreen, build, _buildMenuSection, CircleAvatar, Column, Divider, _MenuItem, Scaffold (+13 more)

### Community 10 - "Community 10"
Cohesion: 0.11
Nodes (7): fl_register_plugins(), main(), my_application_activate(), my_application_new(), _MyApplication, dart_entrypoint_arguments, parent_instance

### Community 11 - "Community 11"
Cohesion: 0.11
Nodes (17): build, _buildFieldLabel, dispose, EditProfileScreen, _EditProfileScreenState, initState, Padding, _saveProfile (+9 more)

### Community 12 - "Community 12"
Cohesion: 0.12
Nodes (16): ../constants/enums.dart, package:flutter/material.dart, package:google_fonts/google_fonts.dart, ../theme/app_theme.dart, BottomSheetWrapper, build, Card, Container (+8 more)

### Community 13 - "Community 13"
Cohesion: 0.12
Nodes (16): dart:async, dart:io, dart:typed_data, package:flutter_test/flutter_test.dart, package:physioghar/main.dart, createHttpClient, package:flutter_riverpod/flutter_riverpod.dart, Function (+8 more)

### Community 14 - "Community 14"
Cohesion: 0.12
Nodes (15): ../../core/theme/app_theme.dart, ../../core/widgets/shared_widgets.dart, package:flutter/material.dart, package:flutter_riverpod/flutter_riverpod.dart, package:google_fonts/google_fonts.dart, package:intl/intl.dart, ../../providers/providers.dart, patient_detail_screen.dart (+7 more)

### Community 15 - "Community 15"
Cohesion: 0.14
Nodes (13): ../../features/account/edit_profile_screen.dart, ../../features/account/language_screen.dart, ../../features/account/profile_screen.dart, ../../features/complaints/complaints_screen.dart, ../../features/patients/patient_detail_screen.dart, package:flutter/material.dart, package:google_fonts/google_fonts.dart, ../theme/app_theme.dart (+5 more)

### Community 16 - "Community 16"
Cohesion: 0.18
Nodes (4): wWinMain(), CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16()

### Community 17 - "Community 17"
Cohesion: 0.15
Nodes (12): Build phases (in order), code:block1 (primary       #2F5D50  Pine), code:block2 (lib/), Deliverable checklist, Design tokens, DO, DO NOT, PhysioGhar Therapist App — AI Build Guidelines (+4 more)

### Community 18 - "Community 18"
Cohesion: 0.17
Nodes (11): ../../core/constants/enums.dart, copyWith, Patient, PatientNote, SessionBooking, Slot, TherapistProfile, TicketComplaint (+3 more)

### Community 19 - "Community 19"
Cohesion: 0.17
Nodes (11): build, Divider, LanguageScreen, Scaffold, SizedBox, SnackBar, ../../core/theme/app_theme.dart, package:flutter/material.dart (+3 more)

### Community 20 - "Community 20"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 21 - "Community 21"
Cohesion: 0.25
Nodes (3): FlutterAppDelegate, AppDelegate, AppDelegate

### Community 22 - "Community 22"
Cohesion: 0.29
Nodes (3): RunnerTests, RunnerTests, XCTestCase

### Community 23 - "Community 23"
Cohesion: 0.33
Nodes (5): handle_new_rx_page(), __lldb_init_module(), Intercept NOTIFY_DEBUGGER_ABOUT_RX_PAGES and touch the pages., SBDebugger, SBFrame

### Community 24 - "Community 24"
Cohesion: 0.33
Nodes (5): package:flutter/material.dart, package:google_fonts/google_fonts.dart, AppColors, AppTheme, ThemeData

### Community 25 - "Community 25"
Cohesion: 0.33
Nodes (3): RegisterGeneratedPlugins(), NSWindow, MainFlutterWindow

### Community 26 - "Community 26"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 27 - "Community 27"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 28 - "Community 28"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 30 - "Community 30"
Cohesion: 0.50
Nodes (3): ../../core/constants/enums.dart, MockData, ../models/models.dart

## Knowledge Gaps
- **355 isolated node(s):** `MainActivity`, `flutter_export_environment.sh script`, `SBFrame`, `SBDebugger`, `-registerWithRegistry` (+350 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **9 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `OnCreate()` connect `Community 1` to `Community 16`?**
  _High betweenness centrality (0.002) - this node is a cross-community bridge._
- **What connects `MainActivity`, `flutter_export_environment.sh script`, `SBFrame` to the rest of the system?**
  _356 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.06060606060606061 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.1032258064516129 - nodes in this community are weakly interconnected._
- **Should `Community 2` be split into smaller, more focused modules?**
  _Cohesion score 0.08 - nodes in this community are weakly interconnected._
- **Should `Community 3` be split into smaller, more focused modules?**
  _Cohesion score 0.08333333333333333 - nodes in this community are weakly interconnected._
- **Should `Community 4` be split into smaller, more focused modules?**
  _Cohesion score 0.08695652173913043 - nodes in this community are weakly interconnected._