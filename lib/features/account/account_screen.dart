import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/screen_launcher.dart';
import '../../providers/providers.dart';
import 'profile_screen.dart';
import 'edit_profile_screen.dart';
import 'language_screen.dart';
import '../complaints/complaints_screen.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final locale = ref.watch(localeProvider);
    final localeNotifier = ref.read(localeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localeNotifier.translate('account'),
          style: GoogleFonts.fraunces(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
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
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(profile.avatarUrl),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.name,
                          style: GoogleFonts.fraunces(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          profile.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profile.email,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildMenuSection(
              context,
              title: 'NAVIGATION DIRECTORY',
              items: [
                _MenuItem(
                  icon: Icons.grid_view_rounded,
                  title: 'All 10 Screens Catalog',
                  subtitle: 'Browse & jump directly to any screen in the app',
                  onTap: () {
                    ScreenLauncher.showCatalog(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildMenuSection(
              context,
              title: 'PROFILE & CLINIC',
              items: [
                _MenuItem(
                  icon: Icons.person_outline,
                  title: 'View Therapist Profile',
                  subtitle: 'Public qualifications, bio, and clinic info',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                ),
                _MenuItem(
                  icon: Icons.edit_outlined,
                  title: 'Edit Profile Information',
                  subtitle: 'Update contact details, bio, and specializations',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildMenuSection(
              context,
              title: 'PREFERENCES & SUPPORT',
              items: [
                _MenuItem(
                  icon: Icons.language,
                  title: 'Language Settings',
                  subtitle: 'Current: ${locale == AppLocale.en ? "English" : "Nepali (नेपाली)"}',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LanguageScreen()),
                    );
                  },
                ),
                _MenuItem(
                  icon: Icons.report_problem_outlined,
                  title: 'Report an Issue / Support',
                  subtitle: 'Submit tickets or feedback to PhysioGhar team',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ComplaintsScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: const Icon(Icons.info_outline, color: AppColors.textMuted),
                title: Text(
                  'PhysioGhar Prototype v1.0.0',
                  style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary),
                ),
                subtitle: Text(
                  'Therapist Console • Local Prototype State',
                  style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(
    BuildContext context, {
    required String title,
    required List<_MenuItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: GoogleFonts.ibmPlexMono(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Card(
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.bgNeutral,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item.icon, size: 20, color: AppColors.primary),
                    ),
                    title: Text(
                      item.title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      item.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                    onTap: item.onTap,
                  ),
                  if (index < items.length - 1)
                    const Divider(height: 1, indent: 64, color: Color(0xFFEFF2EE)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}
