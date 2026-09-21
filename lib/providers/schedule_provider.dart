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
