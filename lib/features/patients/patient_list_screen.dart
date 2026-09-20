import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/shared_widgets.dart';
import '../../providers/providers.dart';
import 'patient_detail_screen.dart';

class PatientListScreen extends ConsumerWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientState = ref.watch(patientProvider);
    final patientNotifier = ref.read(patientProvider.notifier);

    final query = patientState.searchQuery.toLowerCase();
    final filteredPatients = patientState.patients.where((p) {
      return p.name.toLowerCase().contains(query) || p.primaryCondition.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patient Directory',
          style: GoogleFonts.fraunces(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (val) => patientNotifier.setSearchQuery(val),
              decoration: InputDecoration(
                hintText: 'Search patients by name or condition...',
                prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                suffixIcon: patientState.searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppColors.textMuted),
                        onPressed: () => patientNotifier.setSearchQuery(''),
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: filteredPatients.isEmpty
                ? const EmptyState(
                    icon: Icons.person_search,
                    title: 'No Patients Found',
                    message: 'No patient matches your search query. Try searching by name or condition.',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredPatients.length,
                    itemBuilder: (context, index) {
                      final patient = filteredPatients[index];
                      final lastVisitStr = DateFormat('MMM d, yyyy').format(patient.lastVisit);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PatientDetailScreen(patientId: patient.id),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundImage: NetworkImage(patient.avatar),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            patient.name,
                                            style: GoogleFonts.fraunces(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            '(${patient.age}y, ${patient.gender[0]})',
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              color: AppColors.textMuted,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.bgNeutral,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          patient.primaryCondition,
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '${patient.totalSessions} sessions • Last visit: $lastVisitStr',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right, color: AppColors.textMuted),
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
    );
  }
}
