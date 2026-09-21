import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../core/constants/enums.dart';
import '../../../data/models/models.dart';
import '../../../providers/providers.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  final List<String> days = ['Today', 'Tomorrow', 'Oct 26', 'Oct 27'];
  String _selectedDay = 'Today';

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Validation Error',
          style: GoogleFonts.fraunces(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.error),
        ),
        content: Text(message, style: GoogleFonts.inter(fontSize: 14)),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
            ),
            child: Text('OK', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showAddSlotSheet(BuildContext context) {
    final timeController = TextEditingController();
    String targetDay = _selectedDay;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setSheetState) => BottomSheetWrapper(
          title: 'Add New Slot',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Target Day',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: days.map((day) {
                  final isSelected = targetDay == day;
                  return ChoiceChip(
                    label: Text(day),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    labelStyle: GoogleFonts.inter(
                      fontSize: 13,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                    onSelected: (val) {
                      if (val) {
                        setSheetState(() => targetDay = day);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Text(
                'Time Range (e.g. 04:30 PM - 05:30 PM)',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  hintText: 'e.g. 05:00 PM - 06:00 PM',
                  prefixIcon: Icon(Icons.access_time, color: AppColors.textMuted),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Create Slot',
                onPressed: () {
                  if (timeController.text.trim().isEmpty) {
                    _showErrorDialog(context, 'Please enter a valid time range.');
                    return;
                  }
                  ref.read(scheduleProvider.notifier).addSlot(targetDay, timeController.text.trim());
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added new slot for $targetDay')),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void _showSlotActionSheet(BuildContext context, Slot slot) {
    if (slot.status == SlotStatus.booked) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) => BottomSheetWrapper(
          title: 'Booked Session Info',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: slot.patientAvatar != null ? NetworkImage(slot.patientAvatar!) : null,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        slot.patientName ?? 'Booked Patient',
                        style: GoogleFonts.fraunces(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Time: ${slot.timeRange}',
                        style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.accentPale,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Booked slots are read-only in the Schedule manager. Manage appointment status under Bookings.',
                  style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
      return;
    }

    final isBlocked = slot.status == SlotStatus.blocked;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BottomSheetWrapper(
        title: isBlocked ? 'Unblock Slot' : 'Block Slot',
        child: Column(
          children: [
            Text(
              isBlocked
                  ? 'Are you sure you want to unblock this slot (${slot.timeRange})? Patients will be able to book this slot again.'
                  : 'Are you sure you want to block this slot (${slot.timeRange})? No new patients can book during this time.',
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text('Cancel', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isBlocked) {
                        ref.read(scheduleProvider.notifier).unblockSlot(slot.id);
                      } else {
                        ref.read(scheduleProvider.notifier).blockSlot(slot.id);
                      }
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isBlocked ? 'Slot unblocked successfully' : 'Slot blocked successfully',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isBlocked ? AppColors.primary : AppColors.error,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      isBlocked ? 'Unblock' : 'Block Slot',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheduleState = ref.watch(scheduleProvider);
    final isAvailable = ref.watch(scheduleProvider.select((s) => s.isAvailable));
    final daySlots = scheduleState.slots.where((s) => s.dayName == _selectedDay).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule & Availability',
          style: GoogleFonts.fraunces(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: () {
              ref.read(scheduleProvider.notifier).toggleAvailability();
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isAvailable ? AppColors.primary : AppColors.bgNeutral,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isAvailable ? AppColors.accent : AppColors.textMuted,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isAvailable ? 'Available' : 'Busy',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isAvailable ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_alarm, color: AppColors.primary),
            onPressed: () => _showAddSlotSheet(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: days.map((day) {
                  final isSelected = _selectedDay == day;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(day),
                      selected: isSelected,
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.bgNeutral,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                      ),
                      onSelected: (val) {
                        if (val) {
                          setState(() {
                            _selectedDay = day;
                          });
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE8ECE9)),
          Expanded(
            child: daySlots.isEmpty
                ? const EmptyState(
                    icon: Icons.free_breakfast,
                    title: 'No Slots for Selected Day',
                    message: 'Tap the + icon above to create new consultation time slots.',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: daySlots.length,
                    itemBuilder: (context, index) {
                      final slot = daySlots[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => _showSlotActionSheet(context, slot),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                _buildSlotShapeIcon(slot.status),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        slot.timeRange,
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      if (slot.status == SlotStatus.booked && slot.patientName != null)
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 10,
                                              backgroundImage: slot.patientAvatar != null
                                                  ? NetworkImage(slot.patientAvatar!)
                                                  : null,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              slot.patientName!,
                                              style: GoogleFonts.inter(
                                                fontSize: 13,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        )
                                      else
                                        Text(
                                          slot.status == SlotStatus.open
                                              ? 'Available for booking'
                                              : 'Blocked by therapist',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            color: AppColors.textMuted,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                StatusPill.fromSlotStatus(slot.status),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSlotSheet(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Slot',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSlotShapeIcon(SlotStatus status) {
    switch (status) {
      case SlotStatus.open:
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFE2F0EA),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 2),
          ),
          child: const Icon(Icons.check, size: 20, color: AppColors.primary),
        );
      case SlotStatus.booked:
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.accentPale,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.accent, width: 2),
          ),
          child: const Icon(Icons.event, size: 20, color: AppColors.accent),
        );
      case SlotStatus.blocked:
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF2ECE8),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF7A6B63), width: 2),
          ),
          child: const Icon(Icons.block, size: 20, color: Color(0xFF7A6B63)),
        );
    }
  }
}
