import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../providers/providers.dart';
import '../../pages/pages.dart';

class DashboardScreen extends ConsumerWidget {
  final Function(int)? onNavigateTab;

  const DashboardScreen({super.key, this.onNavigateTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAvailable = ref.watch(scheduleProvider.select((s) => s.isAvailableForEmergency));
    final todaySessions = ref.watch(bookingProvider.select((b) => b.todaysUpcoming));
    final requestCount = ref.watch(bookingProvider.select((b) => b.requests.length));
    final completedCount = ref.watch(bookingProvider.select((b) => b.completed.length));
    final activePatientsCount = ref.watch(patientProvider.select((p) => p.patients.length));
    final profile = ref.watch(profileProvider);
    final localeNotifier = ref.read(localeProvider.notifier);

    final dateFormatted = DateFormat('EEEE, MMM d').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.spa, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PhysioGhar',
                  style: GoogleFonts.fraunces(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  localeNotifier.translate('dashboard'),
                  style: GoogleFonts.ibmPlexMono(
                    fontSize: 10,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new system alerts')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8ECE9)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProfileScreen()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(profile.avatarUrl),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProfileScreen()),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.name,
                            style: GoogleFonts.fraunces(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '$dateFormatted • Today',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(scheduleProvider.notifier).toggleAvailability();
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            isAvailable
                                ? localeNotifier.translate('available')
                                : localeNotifier.translate('busy'),
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 104,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildSummaryCard(
                    context,
                    title: 'Today\'s Sessions',
                    value: '${todaySessions.length}',
                    badgeText: 'DAY',
                    icon: Icons.schedule,
                    iconBg: AppColors.bgLight,
                    iconColor: AppColors.primary,
                    onTap: () => onNavigateTab?.call(2),
                  ),
                  const SizedBox(width: 12),
                  _buildSummaryCard(
                    context,
                    title: 'Intake Requests',
                    value: '$requestCount',
                    badgeText: 'NEW',
                    icon: Icons.person_add_outlined,
                    iconBg: AppColors.accentPale,
                    iconColor: AppColors.accent,
                    onTap: () => onNavigateTab?.call(2),
                  ),
                  const SizedBox(width: 12),
                  _buildSummaryCard(
                    context,
                    title: 'Completed (Wk)',
                    value: '$completedCount',
                    badgeText: 'WK',
                    icon: Icons.task_alt,
                    iconBg: AppColors.bgNeutral,
                    iconColor: AppColors.textSecondary,
                    onTap: () => onNavigateTab?.call(2),
                  ),
                  const SizedBox(width: 12),
                  _buildSummaryCard(
                    context,
                    title: 'Active Patients',
                    value: '$activePatientsCount',
                    badgeText: 'TOTAL',
                    icon: Icons.people_outline,
                    iconBg: const Color(0xFFE4EFF2),
                    iconColor: const Color(0xFF2A6B7C),
                    onTap: () => onNavigateTab?.call(3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Schedule',
                  style: GoogleFonts.fraunces(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => onNavigateTab?.call(1),
                  icon: const Icon(Icons.arrow_forward, size: 16, color: AppColors.primary),
                  label: Text(
                    'Full Schedule',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (todaySessions.isEmpty)
              const EmptyState(
                icon: Icons.event_note,
                title: 'No Sessions Scheduled Today',
                message: 'You have no confirmed patient sessions for today. Check booking requests or manage availability.',
              )
            else
              ...todaySessions.map((session) {
                return SessionCard(
                  patientName: session.patientName,
                  patientAvatar: session.patientAvatar,
                  sessionType: session.sessionType,
                  dateString: session.dateString,
                  timeString: session.timeString,
                  complaint: session.chiefComplaint,
                  statusPill: StatusPill.fromRequestStatus(session.status, isCompleted: session.isCompleted),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PatientDetailScreen(patientId: session.patientId),
                      ),
                    );
                  },
                  actionButtons: session.isCompleted
                      ? null
                      : [
                          OutlinedButton(
                            onPressed: () {
                              ref.read(bookingProvider.notifier).markComplete(session.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Session marked as completed for ${session.patientName}')),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              shape: const StadiumBorder(),
                            ),
                            child: Text(
                              'Mark Complete',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                );
              }),
            const SizedBox(height: 20),
            Text(
              'Quick Shortcuts',
              style: GoogleFonts.fraunces(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildShortcutTile(
                    context,
                    icon: Icons.calendar_month,
                    label: 'Manage Slots',
                    color: AppColors.primary,
                    onTap: () => onNavigateTab?.call(1),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildShortcutTile(
                    context,
                    icon: Icons.group,
                    label: 'Patient List',
                    color: AppColors.secondary,
                    onTap: () => onNavigateTab?.call(3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String value,
    required String badgeText,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8ECE9)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 16, color: iconColor),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.bgNeutral,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badgeText,
                    style: GoogleFonts.ibmPlexMono(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: GoogleFonts.fraunces(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
