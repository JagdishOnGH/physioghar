import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/shared_widgets.dart';
import '../../data/models/models.dart';
import '../../providers/providers.dart';

class PatientDetailScreen extends ConsumerWidget {
  final String patientId;

  const PatientDetailScreen({super.key, required this.patientId});

  void _showAddOrEditNoteSheet(BuildContext context, WidgetRef ref, {PatientNote? noteToEdit}) {
    final titleCtrl = TextEditingController(text: noteToEdit?.title ?? '');
    final tagCtrl = TextEditingController(text: noteToEdit?.tag ?? 'Clinical Note');
    final contentCtrl = TextEditingController(text: noteToEdit?.content ?? '');

    final isEditing = noteToEdit != null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BottomSheetWrapper(
        title: isEditing ? 'Edit Clinical Note' : 'Add Clinical Note',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Note Title', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(hintText: 'e.g. Progress Review — Week 5'),
            ),
            const SizedBox(height: 14),
            Text('Tag / Category', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: tagCtrl,
              decoration: const InputDecoration(hintText: 'e.g. Rehab Milestone, Progress, Evaluation'),
            ),
            const SizedBox(height: 14),
            Text('Note Content', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: contentCtrl,
              maxLines: 4,
              decoration: const InputDecoration(hintText: 'Enter clinical observations, exercises, or progress details...'),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: isEditing ? 'Save Changes' : 'Add Note',
              onPressed: () {
                if (titleCtrl.text.trim().isEmpty || contentCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Title and Content cannot be empty')),
                  );
                  return;
                }

                if (isEditing) {
                  ref.read(patientProvider.notifier).updateNote(
                        noteToEdit.id,
                        titleCtrl.text.trim(),
                        contentCtrl.text.trim(),
                        tagCtrl.text.trim(),
                      );
                } else {
                  ref.read(patientProvider.notifier).addNote(
                        patientId,
                        titleCtrl.text.trim(),
                        contentCtrl.text.trim(),
                        tagCtrl.text.trim(),
                      );
                }

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(isEditing ? 'Note updated successfully' : 'Note added successfully')),
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
  Widget build(BuildContext context, WidgetRef ref) {
    final patientState = ref.watch(patientProvider);
    final patient = patientState.patients.firstWhere(
      (p) => p.id == patientId,
      orElse: () => Patient(
        id: patientId,
        name: 'Patient Record',
        age: 30,
        gender: 'N/A',
        phone: 'N/A',
        email: 'N/A',
        avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
        primaryCondition: 'Physical Therapy Case',
        totalSessions: 0,
        lastVisit: DateTime.now(),
      ),
    );

    final patientNotes = patientState.notes.where((n) => n.patientId == patientId).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          patient.name,
          style: GoogleFonts.fraunces(fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(patient.avatar),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              patient.name,
                              style: GoogleFonts.fraunces(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${patient.age} years old • ${patient.gender}',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.bgLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                patient.primaryCondition,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Divider(height: 1, color: Color(0xFFEFF2EE)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoColumn('Phone', patient.phone),
                      _buildInfoColumn('Sessions', '${patient.totalSessions} Total'),
                      _buildInfoColumn('Last Visit', DateFormat('MMM d').format(patient.lastVisit)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Clinical Notes (${patientNotes.length})',
                  style: GoogleFonts.fraunces(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showAddOrEditNoteSheet(context, ref),
                  icon: const Icon(Icons.add, size: 16, color: Colors.white),
                  label: Text('Add Note', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (patientNotes.isEmpty)
              const EmptyState(
                icon: Icons.note_alt_outlined,
                title: 'No Clinical Notes Yet',
                message: 'Tap "Add Note" to record observations, rehab targets, or progress updates.',
              )
            else
              ...patientNotes.map((note) {
                final dateStr = DateFormat('MMM d, yyyy • h:mm a').format(note.createdAt);
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.accentPale,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                note.tag,
                                style: GoogleFonts.ibmPlexMono(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  dateStr,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 16, color: AppColors.textMuted),
                                  onPressed: () => _showAddOrEditNoteSheet(context, ref, noteToEdit: note),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          note.title,
                          style: GoogleFonts.fraunces(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          note.content,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
