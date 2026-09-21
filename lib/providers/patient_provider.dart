import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock/mock_data.dart';
import '../data/models/models.dart';

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
