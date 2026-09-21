import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/enums.dart';
import '../data/mock/mock_data.dart';
import '../data/models/models.dart';

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
