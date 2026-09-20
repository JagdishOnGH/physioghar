import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/shared_widgets.dart';
import '../../providers/providers.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Therapist Profile',
          style: GoogleFonts.fraunces(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
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
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 46,
                    backgroundImage: NetworkImage(profile.avatarUrl),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile.name,
                    style: GoogleFonts.fraunces(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, size: 18, color: AppColors.accent),
                      const SizedBox(width: 4),
                      Text(
                        '${profile.rating} Rating',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.verified, size: 18, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        'Licensed Provider',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8ECE9)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('${profile.totalPatientsCount}+', 'Patients Treated'),
                  const SizedBox(
                    height: 36,
                    child: VerticalDivider(color: Color(0xFFE8ECE9)),
                  ),
                  _buildStatItem('${profile.yearsExperience} Yrs', 'Experience'),
                  const SizedBox(
                    height: 36,
                    child: VerticalDivider(color: Color(0xFFE8ECE9)),
                  ),
                  _buildStatItem('100%', 'Verified'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Biography & Clinical Focus'),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  profile.bio,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Specializations'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: profile.specializations.map((spec) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.bgLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    spec,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Clinic Contact Details'),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildContactRow(Icons.email_outlined, 'Email', profile.email),
                    const Divider(height: 20, color: Color(0xFFEFF2EE)),
                    _buildContactRow(Icons.phone_outlined, 'Phone', profile.phone),
                    const Divider(height: 20, color: Color(0xFFEFF2EE)),
                    _buildContactRow(Icons.location_on_outlined, 'Address', profile.clinicAddress),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Edit Profile Details',
              icon: Icons.edit,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.fraunces(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.fraunces(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted),
              ),
              Text(
                value,
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
