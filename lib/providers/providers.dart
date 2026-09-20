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

  bool get isAvailable => isAvailableForEmergency;

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

class ScheduleNotifier extends Notifier<ScheduleState> {
  @override
  ScheduleState build() {
    return ScheduleState(
      slots: MockData.initialSlots,
      isAvailableForEmergency: true,
      selectedDay: 'Today',
    );
  }

  void toggleAvailability() {
    state = state.copyWith(isAvailableForEmergency: !state.isAvailableForEmergency);
  }

  void setSelectedDay(String day) {
    state = state.copyWith(selectedDay: day);
  }

  void blockSlot(String slotId) {
    state = state.copyWith(
      slots: [
        for (final s in state.slots)
          if (s.id == slotId) s.copyWith(status: SlotStatus.blocked) else s
      ],
    );
  }

  void unblockSlot(String slotId) {
    state = state.copyWith(
      slots: [
        for (final s in state.slots)
          if (s.id == slotId) s.copyWith(status: SlotStatus.open) else s
      ],
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

final scheduleProvider = NotifierProvider<ScheduleNotifier, ScheduleState>(ScheduleNotifier.new);

class BookingState {
  final List<SessionBooking> requests;
  final List<SessionBooking> upcoming;
  final List<SessionBooking> completed;
  final List<SessionBooking> cancelled;

  BookingState({
    required this.requests,
    required this.upcoming,
    required this.completed,
    required this.cancelled,
  });

  List<SessionBooking> get todaysUpcoming =>
      upcoming.where((b) => b.dateString == 'Today').toList();

  BookingState copyWith({
    List<SessionBooking>? requests,
    List<SessionBooking>? upcoming,
    List<SessionBooking>? completed,
    List<SessionBooking>? cancelled,
  }) {
    return BookingState(
      requests: requests ?? this.requests,
      upcoming: upcoming ?? this.upcoming,
      completed: completed ?? this.completed,
      cancelled: cancelled ?? this.cancelled,
    );
  }
}

class BookingNotifier extends Notifier<BookingState> {
  @override
  BookingState build() {
    final all = MockData.initialSessions;
    return BookingState(
      requests: all.where((b) => b.status == RequestStatus.pending).toList(),
      upcoming: all.where((b) => b.status == RequestStatus.accepted && !b.isCompleted).toList(),
      completed: all.where((b) => b.isCompleted).toList(),
      cancelled: all.where((b) => b.status == RequestStatus.declined).toList(),
    );
  }

  void accept(String requestId) {
    final req = state.requests.firstWhere((r) => r.id == requestId);
    state = state.copyWith(
      requests: state.requests.where((r) => r.id != requestId).toList(),
      upcoming: [...state.upcoming, req.toUpcoming()],
    );
  }

  void decline(String requestId) {
    final req = state.requests.firstWhere((r) => r.id == requestId);
    state = state.copyWith(
      requests: state.requests.where((r) => r.id != requestId).toList(),
      cancelled: [...state.cancelled, req.toCancelled()],
    );
  }

  void markComplete(String sessionId, {String? remarks}) {
    final s = state.upcoming.firstWhere((s) => s.id == sessionId);
    state = state.copyWith(
      upcoming: state.upcoming.where((s) => s.id != sessionId).toList(),
      completed: [...state.completed, s.toCompleted(remarksText: remarks)],
    );
  }

  void reschedule(String sessionId, String newDate, String newTime) {
    state = state.copyWith(
      upcoming: [
        for (final s in state.upcoming)
          if (s.id == sessionId) s.copyWith(dateString: newDate, timeString: newTime) else s
      ],
    );
  }
}

final bookingProvider = NotifierProvider<BookingNotifier, BookingState>(BookingNotifier.new);

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

class PatientNotifier extends Notifier<PatientState> {
  @override
  PatientState build() {
    return PatientState(
      patients: MockData.initialPatients,
      notes: MockData.initialNotes,
      searchQuery: '',
    );
  }

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

  void editNote(String noteId, String title, String content, String tag) {
    updateNote(noteId, title, content, tag);
  }
}

final patientProvider = NotifierProvider<PatientNotifier, PatientState>(PatientNotifier.new);

class ProfileNotifier extends Notifier<TherapistProfile> {
  @override
  TherapistProfile build() {
    return MockData.initialProfile;
  }

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

  void update({
    String? name,
    String? title,
    String? email,
    String? phone,
    String? clinicAddress,
    String? bio,
    List<String>? specializations,
  }) {
    state = state.copyWith(
      name: name ?? state.name,
      title: title ?? state.title,
      email: email ?? state.email,
      phone: phone ?? state.phone,
      clinicAddress: clinicAddress ?? state.clinicAddress,
      bio: bio ?? state.bio,
      specializations: specializations ?? state.specializations,
    );
  }
}

final profileProvider = NotifierProvider<ProfileNotifier, TherapistProfile>(ProfileNotifier.new);

enum AppLocale { en, ne }

class LocaleNotifier extends Notifier<AppLocale> {
  @override
  AppLocale build() {
    return AppLocale.en;
  }

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

final localeProvider = NotifierProvider<LocaleNotifier, AppLocale>(LocaleNotifier.new);
