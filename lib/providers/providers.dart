import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/enums.dart';
import '../data/mock/mock_data.dart';
import '../data/models/models.dart';

class ScheduleState {
  final List<Slot> slots;
  final bool isAvailableForEmergency;
  final String selectedDay;

  ScheduleState({
    required this.slots,
    required this.isAvailableForEmergency,
    required this.selectedDay,
  });

  ScheduleState copyWith({
    List<Slot>? slots,
    bool? isAvailableForEmergency,
    String? selectedDay,
  }) {
    return ScheduleState(
      slots: slots ?? this.slots,
      isAvailableForEmergency: isAvailableForEmergency ?? this.isAvailableForEmergency,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}

class ScheduleNotifier extends StateNotifier<ScheduleState> {
  ScheduleNotifier()
      : super(ScheduleState(
          slots: MockData.initialSlots,
          isAvailableForEmergency: true,
          selectedDay: 'Today',
        ));

  void toggleAvailability() {
    state = state.copyWith(isAvailableForEmergency: !state.isAvailableForEmergency);
  }

  void setSelectedDay(String day) {
    state = state.copyWith(selectedDay: day);
  }

  void blockSlot(String slotId) {
    state = state.copyWith(
      slots: state.slots.map((s) {
        if (s.id == slotId) {
          return s.copyWith(status: SlotStatus.blocked);
        }
        return s;
      }).toList(),
    );
  }

  void unblockSlot(String slotId) {
    state = state.copyWith(
      slots: state.slots.map((s) {
        if (s.id == slotId) {
          return s.copyWith(status: SlotStatus.open);
        }
        return s;
      }).toList(),
    );
  }

  void addSlot(String dayName, String timeRange) {
    final newSlot = Slot(
      id: 's_${DateTime.now().millisecondsSinceEpoch}',
      dayName: dayName,
      timeRange: timeRange,
      status: SlotStatus.open,
    );
    state = state.copyWith(slots: [...state.slots, newSlot]);
  }
}

final scheduleProvider = StateNotifierProvider<ScheduleNotifier, ScheduleState>((ref) {
  return ScheduleNotifier();
});

class BookingNotifier extends StateNotifier<List<SessionBooking>> {
  BookingNotifier() : super(MockData.initialSessions);

  void acceptRequest(String requestId) {
    state = state.map((session) {
      if (session.id == requestId) {
        return session.copyWith(status: RequestStatus.accepted);
      }
      return session;
    }).toList();
  }

  void declineRequest(String requestId) {
    state = state.map((session) {
      if (session.id == requestId) {
        return session.copyWith(status: RequestStatus.declined);
      }
      return session;
    }).toList();
  }

  void completeSession(String sessionId) {
    state = state.map((session) {
      if (session.id == sessionId) {
        return session.copyWith(isCompleted: true);
      }
      return session;
    }).toList();
  }

  void rescheduleSession(String sessionId, String newDate, String newTime) {
    state = state.map((session) {
      if (session.id == sessionId) {
        return session.copyWith(dateString: newDate, timeString: newTime);
      }
      return session;
    }).toList();
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, List<SessionBooking>>((ref) {
  return BookingNotifier();
});

class PatientState {
  final List<Patient> patients;
  final List<PatientNote> notes;
  final String searchQuery;

  PatientState({
    required this.patients,
    required this.notes,
    required this.searchQuery,
  });

  PatientState copyWith({
    List<Patient>? patients,
    List<PatientNote>? notes,
    String? searchQuery,
  }) {
    return PatientState(
      patients: patients ?? this.patients,
      notes: notes ?? this.notes,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class PatientNotifier extends StateNotifier<PatientState> {
  PatientNotifier()
      : super(PatientState(
          patients: MockData.initialPatients,
          notes: MockData.initialNotes,
          searchQuery: '',
        ));

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void addNote(String patientId, String title, String content, String tag) {
    final newNote = PatientNote(
      id: 'n_${DateTime.now().millisecondsSinceEpoch}',
      patientId: patientId,
      createdAt: DateTime.now(),
      title: title,
      content: content,
      tag: tag.isEmpty ? 'General Note' : tag,
    );
    state = state.copyWith(notes: [newNote, ...state.notes]);
  }

  void updateNote(String noteId, String title, String content, String tag) {
    state = state.copyWith(
      notes: state.notes.map((n) {
        if (n.id == noteId) {
          return n.copyWith(title: title, content: content, tag: tag);
        }
        return n;
      }).toList(),
    );
  }
}

final patientProvider = StateNotifierProvider<PatientNotifier, PatientState>((ref) {
  return PatientNotifier();
});

class ProfileNotifier extends StateNotifier<TherapistProfile> {
  ProfileNotifier() : super(MockData.initialProfile);

  void updateProfile({
    required String name,
    required String title,
    required String email,
    required String phone,
    required String clinicAddress,
    required String bio,
    required List<String> specializations,
  }) {
    state = state.copyWith(
      name: name,
      title: title,
      email: email,
      phone: phone,
      clinicAddress: clinicAddress,
      bio: bio,
      specializations: specializations,
    );
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, TherapistProfile>((ref) {
  return ProfileNotifier();
});

enum AppLocale { en, ne }

class LocaleNotifier extends StateNotifier<AppLocale> {
  LocaleNotifier() : super(AppLocale.en);

  void toggleLocale() {
    state = state == AppLocale.en ? AppLocale.ne : AppLocale.en;
  }

  void setLocale(AppLocale locale) {
    state = locale;
  }

  String translate(String key) {
    final Map<String, Map<AppLocale, String>> dict = {
      'dashboard': {AppLocale.en: 'Dashboard', AppLocale.ne: 'ड्यासबोर्ड'},
      'schedule': {AppLocale.en: 'Schedule & Availability', AppLocale.ne: 'तालिका र उपलब्धता'},
      'bookings': {AppLocale.en: 'Bookings & Sessions', AppLocale.ne: 'बुकिङ र सत्रहरू'},
      'patients': {AppLocale.en: 'Patients Directory', AppLocale.ne: 'बिरामी विवरण'},
      'account': {AppLocale.en: 'Account Settings', AppLocale.ne: 'खाता सेटिङहरू'},
      'available': {AppLocale.en: 'Available', AppLocale.ne: 'उपलब्ध'},
      'busy': {AppLocale.en: 'Busy / Off', AppLocale.ne: 'व्यस्त / बन्द'},
      'report_issue': {AppLocale.en: 'Report an Issue', AppLocale.ne: 'समस्या दर्ता'},
    };
    return dict[key]?[state] ?? key;
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, AppLocale>((ref) {
  return LocaleNotifier();
});
