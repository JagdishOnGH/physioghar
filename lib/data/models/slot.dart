import '../../core/constants/enums.dart';

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
