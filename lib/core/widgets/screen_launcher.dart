import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'shared_widgets.dart';
import '../../features/pages/pages.dart';


class ScreenLauncher {
  static void showCatalog(BuildContext context, {Function(int)? onSelectTab}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BottomSheetWrapper(
        title: 'All 10 App Screens',
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: ListView(
            children: [
              _buildCatalogItem(
                context,
                num: '1',
                title: 'Home Dashboard',
                subtitle: 'Snapshot, Availability Toggle & Shortcuts',
                icon: Icons.dashboard,
                onTap: () {
                  Navigator.pop(ctx);
                  onSelectTab?.call(0);
                },
              ),
              _buildCatalogItem(
                context,
                num: '2',
                title: 'Schedule & Availability',
                subtitle: 'Weekly Slots, Block/Unblock & Add Slot',
                icon: Icons.calendar_today,
                onTap: () {
                  Navigator.pop(ctx);
                  onSelectTab?.call(1);
                },
              ),
              _buildCatalogItem(
                context,
                num: '3',
                title: 'Booking Requests & Sessions',
                subtitle: 'Requests, Upcoming, Completed, Cancelled Tabs',
                icon: Icons.book_online,
                onTap: () {
                  Navigator.pop(ctx);
                  onSelectTab?.call(2);
                },
              ),
              _buildCatalogItem(
                context,
                num: '4',
                title: 'Patients Directory',
                subtitle: 'Filterable Patient Directory & Stats',
                icon: Icons.people,
                onTap: () {
                  Navigator.pop(ctx);
                  onSelectTab?.call(3);
                },
              ),
              _buildCatalogItem(
                context,
                num: '5',
                title: 'Patient Detail & Notes',
                subtitle: 'Patient Record & Persistent Notes Feed',
                icon: Icons.assignment_ind,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PatientDetailScreen(patientId: 'p_01'),
                    ),
                  );
                },
              ),
              _buildCatalogItem(
                context,
                num: '6',
                title: 'Account Menu',
                subtitle: 'Therapist Settings & Navigation Hub',
                icon: Icons.account_circle,
                onTap: () {
                  Navigator.pop(ctx);
                  onSelectTab?.call(4);
                },
              ),
              _buildCatalogItem(
                context,
                num: '7',
                title: 'Profile View',
                subtitle: 'Therapist Bio, Rating & Qualifications',
                icon: Icons.badge,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
              ),
              _buildCatalogItem(
                context,
                num: '8',
                title: 'Edit Profile',
                subtitle: 'Form Validation & Live Profile Update',
                icon: Icons.edit_note,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                  );
                },
              ),
              _buildCatalogItem(
                context,
                num: '9',
                title: 'Language Settings',
                subtitle: 'English / Nepali Toggle',
                icon: Icons.language,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LanguageScreen()),
                  );
                },
              ),
              _buildCatalogItem(
                context,
                num: '10',
                title: 'Report an Issue / Complaints',
                subtitle: 'Support Ticket Form & Success State',
                icon: Icons.report_problem,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ComplaintsScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildCatalogItem(
    BuildContext context, {
    required String num,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.bgLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              num,
              style: GoogleFonts.ibmPlexMono(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textMuted),
        onTap: onTap,
      ),
    );
  }
}
