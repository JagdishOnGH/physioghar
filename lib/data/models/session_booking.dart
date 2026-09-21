import '../../core/constants/enums.dart';

class SessionBooking {
  final String id;
  final String patientId;
  final String patientName;
  final String patientAvatar;
  final String sessionType;
  final String dateString;
  final String timeString;
  final String chiefComplaint;
  final RequestStatus status;
  final bool isCompleted;
  final String? remarks;

  SessionBooking({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.patientAvatar,
    required this.sessionType,
    required this.dateString,
    required this.timeString,
    required this.chiefComplaint,
    required this.status,
    this.isCompleted = false,
    this.remarks,
  });

  SessionBooking toUpcoming() {
    return copyWith(status: RequestStatus.accepted, isCompleted: false);
  }

  SessionBooking toCancelled() {
    return copyWith(status: RequestStatus.declined, isCompleted: false);
  }

  SessionBooking toCompleted({String? remarksText}) {
    return copyWith(
      status: RequestStatus.accepted,
      isCompleted: true,
      remarks: remarksText ?? remarks,
    );
  }

  SessionBooking copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? patientAvatar,
    String? sessionType,
    String? dateString,
    String? timeString,
    String? chiefComplaint,
    RequestStatus? status,
    bool? isCompleted,
    String? remarks,
  }) {
    return SessionBooking(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      patientAvatar: patientAvatar ?? this.patientAvatar,
      sessionType: sessionType ?? this.sessionType,
      dateString: dateString ?? this.dateString,
      timeString: timeString ?? this.timeString,
      chiefComplaint: chiefComplaint ?? this.chiefComplaint,
      status: status ?? this.status,
      isCompleted: isCompleted ?? this.isCompleted,
      remarks: remarks ?? this.remarks,
    );
  }
}
