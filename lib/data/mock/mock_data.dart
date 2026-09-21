import '../models/models.dart';
import 'mock_notes.dart';
import 'mock_patients.dart';
import 'mock_profile.dart';
import 'mock_sessions.dart';
import 'mock_slots.dart';

class MockData {
  static TherapistProfile get initialProfile => mockProfileData;
  static List<Patient> get initialPatients => mockPatientsData;
  static List<PatientNote> get initialNotes => mockNotesData;
  static List<Slot> get initialSlots => mockSlotsData;
  static List<SessionBooking> get initialSessions => mockSessionsData;
}
