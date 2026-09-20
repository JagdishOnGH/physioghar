import '../../core/constants/enums.dart';

class Patient {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String phone;
  final String email;
  final String avatar;
  final String primaryCondition;
  final int totalSessions;
  final DateTime lastVisit;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.primaryCondition,
    required this.totalSessions,
    required this.lastVisit,
  });

  Patient copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    String? phone,
    String? email,
    String? avatar,
    String? primaryCondition,
    int? totalSessions,
    DateTime? lastVisit,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      primaryCondition: primaryCondition ?? this.primaryCondition,
      totalSessions: totalSessions ?? this.totalSessions,
      lastVisit: lastVisit ?? this.lastVisit,
    );
  }
}

class PatientNote {
  final String id;
  final String patientId;
  final DateTime createdAt;
  final String title;
  final String content;
  final String tag;

  PatientNote({
    required this.id,
    required this.patientId,
    required this.createdAt,
    required this.title,
    required this.content,
    required this.tag,
  });

  PatientNote copyWith({
    String? id,
    String? patientId,
    DateTime? createdAt,
    String? title,
    String? content,
    String? tag,
  }) {
    return PatientNote(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      content: content ?? this.content,
      tag: tag ?? this.tag,
    );
  }
}

class Slot {
  final String id;
  final String dayName;
  final String timeRange;
  final SlotStatus status;
  final String? patientName;
  final String? patientAvatar;

  Slot({
    required this.id,
    required this.dayName,
    required this.timeRange,
    required this.status,
    this.patientName,
    this.patientAvatar,
  });

  Slot copyWith({
    String? id,
    String? dayName,
    String? timeRange,
    SlotStatus? status,
    String? patientName,
    String? patientAvatar,
  }) {
    return Slot(
      id: id ?? this.id,
      dayName: dayName ?? this.dayName,
      timeRange: timeRange ?? this.timeRange,
      status: status ?? this.status,
      patientName: patientName ?? this.patientName,
      patientAvatar: patientAvatar ?? this.patientAvatar,
    );
  }
}

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

class TherapistProfile {
  final String id;
  final String name;
  final String title;
  final String email;
  final String phone;
  final String clinicAddress;
  final String bio;
  final String avatarUrl;
  final double rating;
  final int totalPatientsCount;
  final int yearsExperience;
  final List<String> specializations;

  TherapistProfile({
    required this.id,
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.clinicAddress,
    required this.bio,
    required this.avatarUrl,
    required this.rating,
    required this.totalPatientsCount,
    required this.yearsExperience,
    required this.specializations,
  });

  TherapistProfile copyWith({
    String? id,
    String? name,
    String? title,
    String? email,
    String? phone,
    String? clinicAddress,
    String? bio,
    String? avatarUrl,
    double? rating,
    int? totalPatientsCount,
    int? yearsExperience,
    List<String>? specializations,
  }) {
    return TherapistProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rating: rating ?? this.rating,
      totalPatientsCount: totalPatientsCount ?? this.totalPatientsCount,
      yearsExperience: yearsExperience ?? this.yearsExperience,
      specializations: specializations ?? this.specializations,
    );
  }
}

class TicketComplaint {
  final String id;
  final ComplaintCategory category;
  final String subject;
  final String description;
  final DateTime createdAt;
  final String status;

  TicketComplaint({
    required this.id,
    required this.category,
    required this.subject,
    required this.description,
    required this.createdAt,
    required this.status,
  });
}
