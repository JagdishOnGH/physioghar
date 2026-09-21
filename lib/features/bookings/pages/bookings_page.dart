import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../data/models/models.dart';
import '../../../providers/providers.dart';
import '../../pages/pages.dart';

class BookingsScreen extends ConsumerStatefulWidget {
  const BookingsScreen({super.key});

  @override
  ConsumerState<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends ConsumerState<BookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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

  void _showDeclineConfirmation(BuildContext context, SessionBooking session) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BottomSheetWrapper(
        title: 'Decline Booking Request',
        child: Column(
          children: [
            Text(
              'Are you sure you want to decline the session request for ${session.patientName} on ${session.dateString} (${session.timeString})?',
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
                      ref.read(bookingProvider.notifier).decline(session.id);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Declined request from ${session.patientName}')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: const StadiumBorder(),
                    ),
                    child: Text('Decline Request', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
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

  void _showMarkCompleteSheet(BuildContext context, SessionBooking session) {
    final remarksCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BottomSheetWrapper(
        title: 'Complete Session & Add Remarks',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient: ${session.patientName}',
              style: GoogleFonts.fraunces(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Session: ${session.sessionType} • ${session.timeString}',
              style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            Text(
              'Clinical Remarks / Summary (Optional)',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: remarksCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter session outcomes, patient progress, or follow-up notes...',
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: 'Mark Session Completed',
              onPressed: () {
                final text = remarksCtrl.text.trim();
                ref.read(bookingProvider.notifier).markComplete(session.id, remarks: text.isEmpty ? null : text);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Marked session completed for ${session.patientName}')),
                );
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _showRescheduleSheet(BuildContext context, SessionBooking session) {
    final dateCtrl = TextEditingController(text: session.dateString);
    final timeCtrl = TextEditingController(text: session.timeString);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BottomSheetWrapper(
        title: 'Reschedule Session',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: dateCtrl,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.calendar_today, size: 18)),
            ),
            const SizedBox(height: 14),
            Text('Time', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: timeCtrl,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.access_time, size: 18)),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: 'Confirm Reschedule',
              onPressed: () {
                final date = dateCtrl.text.trim();
                final time = timeCtrl.text.trim();
                if (date.isEmpty || time.isEmpty) {
                  _showErrorDialog(context, 'Date and Time cannot be empty.');
                  return;
                }

                ref.read(bookingProvider.notifier).reschedule(
                      session.id,
                      date,
                      time,
                    );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Rescheduled session for ${session.patientName}')),
                );
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingProvider);

    final requestsList = bookingState.requests;
    final upcomingList = bookingState.upcoming;
    final completedList = bookingState.completed;
    final cancelledList = bookingState.cancelled;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Requests & Sessions',
          style: GoogleFonts.fraunces(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textMuted,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
          tabs: [
            Tab(text: 'Requests (${requestsList.length})'),
            Tab(text: 'Upcoming (${upcomingList.length})'),
            Tab(text: 'Completed (${completedList.length})'),
            Tab(text: 'Cancelled (${cancelledList.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSessionListView(
            items: requestsList,
            emptyTitle: 'No Pending Booking Requests',
            emptyMessage: 'New patient intake requests will appear here when submitted.',
            buildActions: (session) => [
              OutlinedButton(
                onPressed: () => _showDeclineConfirmation(context, session),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.error),
                  shape: const StadiumBorder(),
                ),
                child: Text('Decline', style: GoogleFonts.inter(fontSize: 12, color: AppColors.error, fontWeight: FontWeight.w600)),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(bookingProvider.notifier).accept(session.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Accepted request for ${session.patientName}')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                child: Text('Accept', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          _buildSessionListView(
            items: upcomingList,
            emptyTitle: 'No Upcoming Sessions',
            emptyMessage: 'You currently have no scheduled upcoming sessions.',
            buildActions: (session) => [
              OutlinedButton(
                onPressed: () => _showRescheduleSheet(context, session),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.secondary),
                  shape: const StadiumBorder(),
                ),
                child: Text('Reschedule', style: GoogleFonts.inter(fontSize: 12, color: AppColors.secondary, fontWeight: FontWeight.w600)),
              ),
              ElevatedButton(
                onPressed: () => _showMarkCompleteSheet(context, session),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                child: Text('Complete', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          _buildSessionListView(
            items: completedList,
            emptyTitle: 'No Completed Sessions',
            emptyMessage: 'Completed clinical sessions will be listed here.',
            buildActions: null,
          ),
          _buildSessionListView(
            items: cancelledList,
            emptyTitle: 'No Cancelled Sessions',
            emptyMessage: 'Declined or cancelled session requests will be recorded here.',
            buildActions: null,
          ),
        ],
      ),
    );
  }

  Widget _buildSessionListView({
    required List<SessionBooking> items,
    required String emptyTitle,
    required String emptyMessage,
    required List<Widget>? Function(SessionBooking)? buildActions,
  }) {
    if (items.isEmpty) {
      return EmptyState(
        icon: Icons.calendar_today,
        title: emptyTitle,
        message: emptyMessage,
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final session = items[index];
        return SessionCard(
          patientName: session.patientName,
          patientAvatar: session.patientAvatar,
          sessionType: session.sessionType,
          dateString: session.dateString,
          timeString: session.timeString,
          complaint: session.remarks != null ? 'Remarks: ${session.remarks}' : session.chiefComplaint,
          statusPill: StatusPill.fromRequestStatus(session.status, isCompleted: session.isCompleted),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PatientDetailScreen(patientId: session.patientId),
              ),
            );
          },
          actionButtons: buildActions != null ? buildActions(session) : null,
        );
      },
    );
  }
}
